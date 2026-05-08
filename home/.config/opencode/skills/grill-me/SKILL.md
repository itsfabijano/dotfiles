---
name: grill-me
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me".
---

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one.

Ask questions one at a time.

For each question:
- Use OpenCode's options selector instead of a plain text question when the decision can reasonably be expressed as choices.
- Put your recommended option first and suffix it with `(Recommended)`.
- Keep option labels short and concrete.
- Rely on the built-in freeform reply path when the user wants to type their own answer.
- Only ask a freeform question without options when choices would be misleading or too constraining.

If a question can be answered by exploring the codebase, explore the codebase instead of asking.

Continue until the key branches of the decision tree are resolved or the remaining uncertainty is explicitly accepted.
