## Browser Automation

Use `agent-browser` for web automation. Run `agent-browser --help` for all commands.

Core workflow:

1. `agent-browser open <url>` - Navigate to page
2. `agent-browser snapshot -i` - Get interactive elements with refs (@e1, @e2)
3. `agent-browser click @e1` / `fill @e2 "text"` - Interact using refs
4. Re-snapshot after page changes

## Roles

When making edits to files, prefer batch/whole-file operations over many incremental line-by-line edits. For translations or large-scale changes, rewrite the entire file at once rather than making 80+ individual edit operations.

Always create a feature branch before making changes. Never commit directly to main. Use the pattern: `git checkout -b feature/<description>` before starting work.

Prefer the simplest approach first. Before migrating to a new pattern (e.g., Server Actions, WebWorkers), evaluate whether a simpler solution (middleware, existing patterns) would work. Propose the minimal viable approach and get user confirmation before starting complex refactors.
