# Boris Issue Notes

This is the small, reproducible issue log for Boris behavior encountered while building Mediluna. It is intentionally separate from playful Mediluna lore so it can be handed to the compiler maintainer as engineering feedback.

Entries stay listed after resolution so the discovery history is preserved alongside the outcome.

## Resolved upstream: multiline HTML blocks are interrupted by blank lines (boris#206)

**Status:** filed as [drawmeanelephant/boris#206](https://github.com/drawmeanelephant/boris/issues/206), closed 2026-07-27 as documented behavior. Not a compiler defect.

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

### Resolution

The reproduction above does not reproduce as written on current Boris — verified on `afterparty` (`542959f`) and on the `bin/boris` binary pinned in this repo. The real edge is narrower: a blank line ends the HTML block, and any following line indented four or more spaces is then parsed as an indented code block and escaped. Indenting continuation lines three spaces or fewer renders as HTML again.

Boris#206 asked for this interaction to be recorded as a Class-4 "surprising but intended" entry in `docs/contracts/fixtures/apex-unified-compat/MATRIX.md` or the HTML-block docs, since the discovery cost was non-trivial. CommonMark/GFM compatibility is an explicit non-goal there, so it closed as a docs request. The ask was fulfilled before close: boris commit `3563328` (2026-07-25, `docs(compat): record blank-line HTML block indentation as class 4`) added a 20-line Class-4 entry to that MATRIX.

### Current workaround

Keep multiline HTML contiguous, or indent continuation lines three spaces or fewer after a blank line. `content/index.md` and `content/contributing.md` each open a `<section>` at line 5 and keep their HTML blocks contiguous. `content/friends-agents.md` contains no raw HTML at all; an earlier revision of this note pointed at it in error.

## Open locally: nested-page relative references in the CI checker (mediluna#6)

**Status:** confirmed a defect in this repository's own `scripts/ci-check.sh`, not in Boris. Tracked as [mediluna#6](https://github.com/drawmeanelephant/mediluna/issues/6). No upstream filing warranted.

### Observed behavior

The new `friends/agents/index.html` page generated correct relative navigation links such as `../../contributing.html`, but the repository checker resolved every relative reference from `dist/` rather than from the HTML file containing the reference.

### Expected behavior

Relative `href` and `src` values should be checked relative to the containing generated page, matching browser URL resolution.

### Investigation outcome (2026-08-24)

Boris emission is correct: `docs/contracts/html-output.md` keeps emitted HTML target-relative by default ("navigation, theme assets, and content-local assets are emitted relative to the page that carries them"), and its §Site nav HTML normative shape emits `href="REL"` where `REL` is a site-relative path from the current page's output path. A nested `content/friends/agents/index.md` built with the pinned `bin/boris` emits links that resolve correctly from the containing page. The checker pools every `href`/`src` into one de-duplicated list and resolves all of them against `dist/`, so it rejects correct nested links (`broken internal reference: ../../art-archive.html`) and can mask broken ones. Details and a fix sketch: mediluna#6.

### Current workaround

Until the per-page reference checker landed (mediluna#6), authored pages had to stay at the repository root: the checker rejected correct nested links, and keeping pages flat was the only way to keep a nested-route build green in CI.

## Issue-report format

For future Boris problems, add:

1. The generated output that was surprising.
2. The smallest source reproduction.
3. Expected output or behavior.
4. A workaround, if one exists.
5. Whether the fix belongs in Boris, the site, or the repository checks.
