# ==============================================================================
# Git Automation Makefile
# ==============================================================================
#
# Prerequisite:
#   - GitHub authentication must be configured (ssh or credential helper).
#   - You must be on the 'main' branch (or update the target branch below).
#
# Usage for Humans & AI:
#   make git m="<your_commit_message>"
#
# Example:
#   make git m="feat: implement new login screen"
#
# This command performs the following:
#   1. Checks if a commit message is provided.
#   2. Stages all changes (git add .).
#   3. Commits with the provided message.
#   4. Pushes to origin main.
# ==============================================================================

.PHONY: git

git:
	@if [ -z "$(m)" ]; then \
		echo "Error: Commit message is required."; \
		echo "Usage: make git m=\"your message\""; \
		exit 1; \
	fi
	git add .
	git commit -m "$(m)"
	git push origin main