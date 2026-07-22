# Boris Issue Notes

This is the small, reproducible issue log for Boris behavior encountered while building Mediluna. It is intentionally separate from playful Mediluna lore so it can be handed to the compiler maintainer as engineering feedback.

## Open: multiline HTML blocks are interrupted by blank lines

### Observed behavior

When a Markdown page contains an HTML block with a blank line inside it, Boris renders the remainder as a fenced code block instead of preserving it as HTML.

### Minimal reproduction

```markdown
<section>
  <div>First block</div>

  <div>Second block</div>
</section>
```

The second `<div>` is emitted escaped inside `<pre><code>...</code></pre>`.

### Expected behavior

HTML blocks should remain raw HTML until their enclosing block is closed, or Boris should document the stricter no-blank-line rule as a validation error with a useful source location.

### Current workaround

Keep multiline HTML contiguous in Markdown sources. The Friends / Agents page uses that workaround in `content/friends/agents/index.md`.

## Open: nested-page relative references in the CI checker

### Observed behavior

The new `friends/agents/index.html` page generated correct relative navigation links such as `../../contributing.html`, but the repository checker resolved every relative reference from `dist/` rather than from the HTML file containing the reference.

### Expected behavior

Relative `href` and `src` values should be checked relative to the containing generated page, matching browser URL resolution.

### Current workaround

Keep authored pages at the repository root until the checker resolves relative references from the containing page. This is a CI validation issue, not a Boris rendering issue, but it surfaced when Boris began emitting a nested route.

## Issue-report format

For future Boris problems, add:

1. The generated output that was surprising.
2. The smallest source reproduction.
3. Expected output or behavior.
4. A workaround, if one exists.
5. Whether the fix belongs in Boris, the site, or the repository checks.
