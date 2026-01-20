const fs = require('fs');
const path = require('path');
const os = require('os');

// --- Configuration ---
const LOG_DIR = path.join(process.cwd(), '.gemini/cli_history');
const STREAM_LOG = path.join(LOG_DIR, 'stream_log.txt');
const ROLLING_LOG = path.join(LOG_DIR, 'recent_history.md');
const MAX_ROLLING_ITEMS = 200;

// Temp logging for the per-response summary in CLI output
const projectPath = process.cwd().split(path.sep).join('_');
const tempDir = path.join(os.tmpdir(), 'gemini_hooks', projectPath);
const tempReadLog = path.join(tempDir, 'read_log.txt');
const tempWriteLog = path.join(tempDir, 'write_log.txt');

// Ensure directories exist
if (!fs.existsSync(LOG_DIR)) fs.mkdirSync(LOG_DIR, { recursive: true });
if (!fs.existsSync(tempDir)) fs.mkdirSync(tempDir, { recursive: true });

// --- Helpers ---
function getTimestamp() {
  const now = new Date();
  return now.toISOString().replace('T', ' ').substring(0, 19);
}

function getActionInfo(toolName) {
  const map = {
    'read_file': { type: 'READ', emoji: '📖' },
    'search_file_content': { type: 'SEARCH', emoji: '🔍' },
    'list_directory': { type: 'LIST', emoji: '📂' },
    'glob': { type: 'GLOB', emoji: '🌐' },
    'write_file': { type: 'WRITE', emoji: '✍️' },
    'replace': { type: 'EDIT', emoji: '🛠️' },
    'run_shell_command': { type: 'EXEC', emoji: '💻' },
    'web_fetch': { type: 'FETCH', emoji: '🔗' },
    'google_web_search': { type: 'WEB', emoji: '🌍' },
    'delegate_to_agent': { type: 'AGENT', emoji: '🤖' }
  };
  return map[toolName] || { type: 'OTHER', emoji: '❓' };
}

// --- Main Logic ---
let inputData = '';
process.stdin.on('data', chunk => inputData += chunk);
process.stdin.on('end', () => {
  try {
    if (!inputData) return;
    const event = JSON.parse(inputData);
    
    // Support both AfterTool and other hook event structures
    const toolName = event.tool_name || event.tool?.name || event.name;
    const args = event.tool_input || event.tool?.args || event.args || {};

    if (!toolName) return;

    const { type, emoji } = getActionInfo(toolName);
    const timestamp = getTimestamp();
    
    let targets = [];
    if (args.file_path) targets.push(args.file_path);
    if (args.dir_path) targets.push(args.dir_path);
    if (args.url) targets.push(args.url);
    if (args.query) targets.push(args.query);
    if (args.objective) targets.push('Agent Objective: ' + args.objective.substring(0, 50) + '...');
    
    if (targets.length === 0) {
        if (toolName === 'run_shell_command' && args.command) {
            targets.push(args.command.substring(0, 50) + (args.command.length > 50 ? '...' : ''));
        } else {
            targets.push('N/A');
        }
    }

    targets.forEach(target => {
      const streamEntry = '[' + timestamp + '] [' + type + '] ' + target;
      const rollingEntry = '| ' + timestamp + ' | ' + emoji + ' **' + type + '** | `' + target + '` |';

      // 1. Update Stream Log
      fs.appendFileSync(STREAM_LOG, streamEntry + '\n');

      // 2. Update Rolling History
      updateRollingHistory(rollingEntry);

      // 3. Update Temp Logs for Reporter
      if (['READ', 'SEARCH', 'LIST', 'GLOB', 'FETCH', 'WEB'].includes(type)) {
        fs.appendFileSync(tempReadLog, target + '\n');
      } else {
        fs.appendFileSync(tempWriteLog, target + '\n');
      }
    });

  } catch (error) {
    // Fail silently
  }
});

function updateRollingHistory(newEntry) {
  let lines = [];
  if (fs.existsSync(ROLLING_LOG)) {
    const content = fs.readFileSync(ROLLING_LOG, 'utf8');
    lines = content.split('\n').filter(l => l.trim().startsWith('| 20'));
  }

  lines.push(newEntry);

  if (lines.length > MAX_ROLLING_ITEMS) {
    lines = lines.slice(lines.length - MAX_ROLLING_ITEMS);
  }

  const header = '# 📜 CLI Activity History (Last ' + MAX_ROLLING_ITEMS + ')\n\n| Timestamp | Action | Target |\n| :--- | :--- | :--- |\n';
  const footer = '\n\n*Last updated: ' + getTimestamp() + '*';
  
  fs.writeFileSync(ROLLING_LOG, header + lines.join('\n') + footer);
}