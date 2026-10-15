---
trigger: always_on
description: Automatically execute the humanizer skill when /humanize or /humanizer is invoked in chat.
---

# Humanizer Slash Command Trigger

When the user enters `/humanize` or `/humanizer` in the chat, or asks to humanize text:
1. Immediately activate and follow the `humanizer` skill.
2. Read the user's input text, writing sample, or target file path.
3. Apply the 26 AI writing patterns from Wikipedia's "Signs of AI writing" to remove artificial tells (e.g. not-X-but-Y contrasts, dramatic one-line closers, staged run-ups, forced triads, excessive dashes, inflated claims, sales words, decorative bolding, chatbot leftovers).
4. Preserve all original meaning, facts, and citations without hallucinating details.
5. If a writing sample is provided, emulate its voice and rhythm.
6. For pasted text: display the draft rewrite, any remaining patterns, and the final polished humanized text.
7. For a target file: update only the prose within the file, keeping code blocks, paths, data, and metadata untouched.
