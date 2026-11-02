# Antigravity Memory Bank 🧠

A lightweight, persistent memory and context tracking system for **Google Antigravity**.

Designed to maintain user identity, development preferences, and project progress across sessions without exhausting token context.

---

## Quick Install (One-Liner)

Run the following command in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/0xposa/antigravity-memory-bank/main/install.sh | bash
```

This single command automatically sets up:
* **`~/.gemini/config/MEMORY.md`**: Global persistent memory for user profile, device specs, and workspace preferences.
* **`~/.gemini/config/GEMINI.md`**: System rules enforcing live web search and unconditional memory loading.
* **`memory-bank` Skill**: Built-in agent skill for managing project tasks, progress checklists, and active context.

---

## Memory Architecture

The system uses a clean two-tier architecture:

### 1. Global Layer (`~/.gemini/config/`)
* **`MEMORY.md`**: Stores developer identity, hardware/OS specifications, communication preferences, and persistent entities.
* **`GEMINI.md`**: System-level operating rules (such as search-first policies and auto-memory synchronization).

### 2. Project Layer (`.agents/context/`)
Initialized locally inside each project workspace:
* **`activeContext.md`**: Tracks current task focus, recent code changes, active blockers, and immediate next steps.
* **`progress.md`**: Checklist of completed `[x]` versus upcoming `[ ]` deliverables.
* **`systemPatterns.md`**: Technical stack definitions, coding standards, and architectural decisions.

---

## Usage

Once installed, interact with your AI assistant using everyday prompts:

* *"Initialize memory for this project"* — Generates the `.agents/context/` workspace structure.
* *"Save today's progress"* — Updates the active context and task checklist before finishing a session.
* *"Resume where we left off"* — Seamlessly picks up work from the last recorded state.
* *"Remember this preference"* — Stores new user guidelines directly into global memory.

---

## License

[MIT](LICENSE)
