#!/usr/bin/env bash
set -e

# Target directory is current directory or first argument
TARGET_DIR="${1:-.}"
CONTEXT_DIR="$TARGET_DIR/.agents/context"
TEMPLATES_DIR="$(dirname "$0")/../resources/templates"

mkdir -p "$CONTEXT_DIR"

if [ ! -f "$CONTEXT_DIR/activeContext.md" ]; then
    cp "$TEMPLATES_DIR/activeContext.md" "$CONTEXT_DIR/activeContext.md"
    echo "✓ Created $CONTEXT_DIR/activeContext.md"
fi

if [ ! -f "$CONTEXT_DIR/progress.md" ]; then
    cp "$TEMPLATES_DIR/progress.md" "$CONTEXT_DIR/progress.md"
    echo "✓ Created $CONTEXT_DIR/progress.md"
fi

if [ ! -f "$CONTEXT_DIR/systemPatterns.md" ]; then
    cp "$TEMPLATES_DIR/systemPatterns.md" "$CONTEXT_DIR/systemPatterns.md"
    echo "✓ Created $CONTEXT_DIR/systemPatterns.md"
fi

echo "Memory bank successfully initialized in $CONTEXT_DIR"
