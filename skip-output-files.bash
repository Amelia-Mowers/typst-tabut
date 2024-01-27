#!/bin/bash

# This isn't working

# git update-index --skip-worktree README.md
# git update-index --skip-worktree README.pdf
# find doc/compiled-snippets -type f -print0 | xargs -0 -I{} sh -c 'if git ls-files --error-unmatch "{}" > /dev/null 2>&1; then if ! git update-index --skip-worktree "{}"; then echo "Failed to update-index: {}"; fi; fi'