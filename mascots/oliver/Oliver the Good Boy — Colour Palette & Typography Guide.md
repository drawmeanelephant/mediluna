# Oliver the Good Boy — Colour Palette & Typography Guide

## Purpose and Scope

This guide defines the core colour and type system for **Oliver the Good Boy**. It is intended for website, social, presentation, and campaign production, and should be read alongside the graphical-equity guide. The system is deliberately warm and grounded: **orange creates energy**, **charcoal supplies clarity**, **soft greys express Oliver’s Weimaraner character**, and **off-white provides breathing room**.

> **Design principle:** Let Oliver feel friendly and confident, never noisy. Use orange as a bright signal rather than a dominant field, and let typography communicate with the same warmth and directness as the mascot.

## Core Palette

| Colour name | Hex | RGB | Role | Recommended use |
| --- | --- | --- | --- | --- |
| **Oliver Orange** | `#E44D26` | `228, 77, 38` | Energy and action | Tag device, tail-swish, CTA accent, key highlight, large display statement |
| **Charcoal** | `#333333` | `51, 51, 51` | Authority and readability | Primary type, porthole fills, dark backgrounds, navigation, strong UI controls |
| **Warm Grey** | `#A6A19A` | `166, 161, 154` | Mascot-neutral support | Large quiet fields, icon fills, subtle backgrounds, illustration support |
| **Medium Taupe** | `#817B75` | `129, 123, 117` | Depth and secondary structure | Secondary shapes, dividers, tonal illustration detail, large display type only |
| **Off-White** | `#F7F5F2` | `247, 245, 242` | Canvas and breathing space | Default page background, social copy-safe space, light panels |

### Palette Hierarchy

Use **Off-White** as the default canvas, allowing Oliver, typography, and graphic devices to feel considered rather than crowded. **Charcoal** should carry most reading text and interaction states. **Oliver Orange** should signal momentum: it is particularly effective in the tag device, the tail-swish ribbon, and a single focal callout. Warm Grey and Medium Taupe should work as soft, organic support colours rather than competing accents.

For a typical web or social composition, begin with a quiet neutral field, add Charcoal for the hierarchy, then introduce one confident orange action. The greys should fill a supporting role and never become a substitute for legible text contrast.

## Digital Tokens

```css
:root {
  --oliver-orange: #E44D26;
  --oliver-charcoal: #333333;
  --oliver-warm-grey: #A6A19A;
  --oliver-medium-taupe: #817B75;
  --oliver-off-white: #F7F5F2;

  --font-display: "Poppins", Arial, sans-serif;
  --font-body: "Inter", Arial, sans-serif;
}
```

## Colour Pairing and Accessibility

The following figures are calculated from the defined sRGB values. For web content, WCAG 2.2 Level AA requires at least **4.5:1** contrast for normal text and **3:1** for large-scale text; its guidance treats approximately 24 px regular or 18.5 px bold text as large-scale. [1]

| Foreground / background | Contrast ratio | Approved use |
| --- | ---: | --- |
| **Charcoal on Off-White** | `11.61:1` | Primary body copy, headings, buttons, navigation, long-form reading |
| **Charcoal on Warm Grey** | `4.93:1` | Standard text, labels, and short UI copy |
| **Medium Taupe on Off-White** | `3.84:1` | Large display type, secondary non-text detail, icons; not normal body text |
| **Oliver Orange on Off-White** | `3.58:1` | Large bold display type, decorative tag/ribbon, non-text indicator; not normal body text |
| **Oliver Orange on Charcoal** | `3.24:1` | Large bold display type or non-text accent; not normal body text |
| **Charcoal on Medium Taupe** | `3.02:1` | Large bold type, strong iconography, or non-text UI boundary only |
| **Warm Grey on Off-White** | `2.36:1` | Decorative field only; never text or essential UI |
| **Orange with either grey** | `1.07–1.52:1` | Decorative pairing only; never text, navigation, or CTA labelling |

> **Practical rule:** Use Charcoal text on Off-White whenever copy must be read. Do not set a small orange label, small taupe label, or warm-grey label on an Off-White field. Keep CTA labels Charcoal-on-Off-White or Off-White-on-Charcoal; use orange around the component as the attention signal.

## Typography System

### Typeface Roles

| Typeface | Brand role | Recommended weights | Character |
| --- | --- | --- | --- |
| **Poppins** | Display and brand voice | 600 SemiBold, 700 Bold, 800 ExtraBold | Rounded, confident, upbeat, and mascot-compatible |
| **Inter** | Reading and interface system | 400 Regular, 500 Medium, 600 SemiBold, 700 Bold | Clear, neutral, compact, and highly legible in digital environments |

**Poppins** gives Oliver its confident, friendly headline voice. Use it for brand statements, headings, social post headlines, hero titles, labels, and prominent numeric callouts. **Inter** is the workhorse: use it for paragraph copy, navigation, buttons, cards, captions, forms, and supporting labels.

### Type Scale

The following is the default website scale. Use the same hierarchy on social artwork, with no more than two type sizes in a single post whenever possible.

| Style | Typeface / weight | Desktop size / leading | Mobile size / leading | Case and tracking | Primary application |
| --- | --- | ---: | ---: | --- | --- |
| **Display** | Poppins 800 | `64 / 72 px` | `44 / 52 px` | Sentence case; `-0.03em` | Homepage hero, major campaigns |
| **H1** | Poppins 700 | `52 / 60 px` | `36 / 44 px` | Sentence case; `-0.02em` | Page title |
| **H2** | Poppins 700 | `40 / 48 px` | `30 / 38 px` | Sentence case; `-0.01em` | Section title |
| **H3** | Poppins 600 | `28 / 36 px` | `24 / 32 px` | Sentence case; normal tracking | Card/feature title |
| **Eyebrow** | Poppins 700 | `12 / 16 px` | `12 / 16 px` | Uppercase; `0.10em` | Category, overline, compact label |
| **Lead** | Inter 400 | `20 / 30 px` | `18 / 28 px` | Sentence case; normal tracking | Introduction or supporting statement |
| **Body** | Inter 400 | `16 / 26 px` | `16 / 26 px` | Sentence case; normal tracking | Paragraphs, descriptions, articles |
| **UI / button** | Inter 600 | `14 / 20 px` | `14 / 20 px` | Sentence case; `0.01em` | Buttons, navigation, form labels |
| **Small / caption** | Inter 500 | `12 / 18 px` | `12 / 18 px` | Sentence case; `0.01em` | Metadata, image credits, helper copy |

### Hierarchy and Setting Rules

Create hierarchy through **size, weight, contrast, and space**, in that order. A Poppins headline should usually be Charcoal on Off-White, with Oliver Orange used for a short emphasis, underline, tag, or adjacent graphic device rather than for every word. Keep Poppins to one or two lines in most social assets, and allow Inter paragraphs a comfortable maximum line length of roughly 55–75 characters on desktop pages.

Use **sentence case** as the default. All caps are reserved for compact Poppins eyebrows, navigation labels, and occasional short campaign stamps. Avoid all-caps paragraphs, very light weights, condensed treatment, and scripted display faces; all of these would weaken the open, approachable character of the identity.

### Responsive and Social Guidance

On mobile, retain the relationship between Poppins and Inter rather than shrinking everything uniformly. Display type may step down substantially, but body copy should remain at **16 px** or above. In a feed post, use one Poppins headline plus one Inter support line or CTA; on Stories/Reels covers, leave generous text-safe space and keep any live copy away from platform controls.

Avoid placing type across Oliver’s eyes, nose, tag, or face. If a social post needs copy over illustration, place it in the established Off-White copy-safe field and use Charcoal for the reading text.

## Application Recipes

| Use case | Type treatment | Colour treatment |
| --- | --- | --- |
| **Website hero** | Poppins 800 display + Inter lead + Inter 600 CTA | Charcoal text on Off-White; orange tail-swish/tag as focal accent |
| **Section introduction** | Poppins 700 H2 + Inter 400 body | Charcoal text; Warm Grey background field only when Charcoal remains readable |
| **Primary button** | Inter 600, sentence case | Charcoal background with Off-White label; orange may be used as adjacent tag, hover accent, or keyline |
| **Social feed post** | Poppins 700 headline + optional Inter 500 support line | Off-White copy field, Charcoal copy, one orange highlight or ribbon |
| **Story / Reel cover** | Poppins 700, maximum two lines | Charcoal text on Off-White safe field; orange used as edge movement or tag cue |
| **Quote / testimonial card** | Poppins 600 quote lead + Inter 500 attribution | Charcoal reading text; grey porthole or orange tag cue as supporting element |

## Quality-Control Checklist

Before publishing a new asset, confirm that it uses **Poppins only for display/brand hierarchy** and **Inter only for reading/UI**, retains an obvious Charcoal text path on the final background, includes no more than one dominant orange field or gesture, and leaves Oliver’s face unobstructed. Recheck contrast whenever type is placed on illustration, photography, or a coloured field; the ratios above assume flat, solid backgrounds.

## References

[1]: https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html "W3C: Understanding Success Criterion 1.4.3, Contrast (Minimum)"
