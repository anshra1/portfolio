const fs = require('fs');
const path = require('path');
const os = require('os');

const projectPath = process.cwd().split(path.sep).join('_');
const tempDir = path.join(os.tmpdir(), 'gemini_hooks', projectPath);
const readLogPath = path.join(tempDir, 'read_log.txt');
const writeLogPath = path.join(tempDir, 'write_log.txt');

function getUniqueLines(filePath) {
  if (!fs.existsSync(filePath)) return [];
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split('\n').map(l => l.trim()).filter(l => l);
  return [...new Set(lines)].sort();
}

const readFiles = getUniqueLines(readLogPath);
const writeFiles = getUniqueLines(writeLogPath);

if (readFiles.length === 0 && writeFiles.length === 0) {
  // No activity to report
  process.exit(0);
}

console.log('\n---');
console.log('### 🛠 Activity Log');

  if (readFiles.length > 0) {
    console.log('**Read:**');
    readFiles.forEach(f => console.log('- `' + f + '`'));
  }

  if (writeFiles.length > 0) {
      if (readFiles.length > 0) console.log(''); // spacer
      console.log('**Written/Modified:**');
      writeFiles.forEach(f => console.log('- `' + f + '`'));
  }
// Cleanup for the next turn
try {
  if (fs.existsSync(readLogPath)) fs.unlinkSync(readLogPath);
  if (fs.existsSync(writeLogPath)) fs.unlinkSync(writeLogPath);
} catch (e) {
  // ignore cleanup errors
}
