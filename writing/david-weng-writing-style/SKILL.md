---
name: david-weng-writing-style
description: |
  Write or review text in David Weng's personal style — direct, factual, no fluff.
  Combines voice & structure rules (ai-writing-style-guide) with bilingual
  typography & punctuation rules (tingtalk-style-guide). Use when the user
  asks to write, draft, review, or polish any Chinese/English mixed prose
  including blog posts, guides, DP timelines, 扫盲 articles, or social posts.
  Also use when the user asks for a "style check" or says "按我的风格".
  Do NOT use for technical documentation, code comments, or formal reports
  that require an impersonal tone.
---

# David Weng Writing Style

Generate or review text matching David Weng's personal writing style.
Two layers: **Voice & Structure** + **Typography & Punctuation**.

## Workflow

1. **Identify the genre**: Is it a guide/DP/扫盲 article, a narrative blog post, or a social/media piece? This determines which rules are strictest.

2. **Draft or review** following the rules below. For drafts, write the content. For reviews, flag violations and rewrite offending passages.

3. **Run the Revision Checklist** (at the bottom) before delivering.

## Core Voice

- Direct, no filler. Say what needs saying, stop.
- Cold humor only as rare garnish — never forced friendliness.
- First person primary. Second person "你" OK for direct address.
  Avoid "我们", "大家", "小伙伴们".
- Not academic, not bureaucratic, not flattering.
- Emotion through facts, not adjective piles.
- **解释即止**: Define a term in 1–2 sentences max. No tangents, no showing off.

## Attitude Boundaries

- Criticism/sarcasm OK if grounded in facts.
- No empty negativity — anger needs a specific cause.
- No ad hominem, no group attacks.

## Structure & Flow

**Opening:**
- Guides/DP/articles: Start with a plain fact statement or "以下是我根据……整理出的……"
- No vague introductions. Cut straight to the point.

**Sections:**
- Simple heading hierarchy (`##` primary, `###` secondary). No deep nesting.
- Guide/DP headings: objective nouns or short phrases only.
  e.g. "基础概念", "背景", "英澳 HSBC 的开户顺序"
- Date entries: `## 日期 · 简短描述`
- Parallel structure: basic → advanced, or background → process → result.
- Blank line between paragraphs. No blank line between heading and body.

**Paragraphs:**
- Short paragraphs (1–3 sentences) for scannability.
- Term definition format: `**术语（全称，中文译名）** + 解释` — 1–2 sentences, no operational detail.

**DP / Timeline Rules:**
- Date entries contain **only** action + result. No judgment ("DP 充分"), no evaluation ("过程顺利").
- Background: list only prerequisites for reproducing the operation.
- External references: link directly, don't explain what the link is.
- End immediately after the result statement. **Never** summarize, prospect, or evaluate.

## Sentence Level

**Length & Rhythm:**
- Short sentences primary, medium secondary, long rare.
- Use commas to connect clauses.
- **Strictly ban em dash (—)** and em-dash-connected clauses. Sentences stand alone.
- **Ban semicolons** as connectors.

**Bilingual Spacing:**
- Chinese + English/number: add half-width space.
  `通过 Global Transfer 转账` ✓ | `通过Global Transfer转账` ✗
- Number + unit: add space. `A$9,000` ✓
- Technical term first appearance: give Chinese translation.
  e.g. `DD（Direct Deposit，直接存款）`

**Colloquialism:**
- Ban: "完事", "清净了", "说白了", "这里顺便说一句", performative wit.
- Allow: mild colloquial explanations, neutral connectors ("而", "但", "因此") as logic lubrication only.
- **Hard ban**: cheesy metaphors, internet slang, pseudo-intimate exclamations, "大家", "小伙伴们".

**Data & References:**
- Precision first: specific numbers, names, dates, thresholds.
- Uncertain: use "据称", "多数情况下" etc.
- Links inline (not footnotes). Use `[text](URL)`.

## Guide / DP / 扫盲 Special Rules

1. **解释即止**: Definition only. No operational advice, no examples (unless essential), no evaluation.
2. **No color**: No personification or subjective judgment of terms.
3. **No padding**: Don't repeat explanations. Ban "顾名思义", "简单来说" and other low-signal phrases.
4. **Section naming**: Objective labels only. No marketing tone.
5. **Date entries**: Fixed format `日期 · 动作`. Below: actor, target, amount (if applicable), result. Never decision rationale or external validation.
6. **Background**: Only prerequisites (identity, existing accounts, address). Delete "我提前准备了……" and similar.

## Visual & Formatting

**Code blocks:**
- Allowed for technical content. Add explanatory text below each block.
- **DP/timeline/guide articles go entirely in one code block** (frontmatter + body) for easy copy-paste.

**Images/Media:**
- Inline with brief caption. Bold title OK.

**Blockquotes:**
- Use `>` for quotes. Long quotes as separate paragraph with source.

**Links:**
- Inline (not footnotes). No extra spaces between English links.

**Tables:**
- Preferred for multi-dimensional comparisons.

## Signature Moves (Adjusted by Genre)

| Move | Narrative | Guide | DP/Timeline |
|------|-----------|-------|-------------|
| Direct stance | ✓ | ✓ | ✓ |
| Cold humor | ✓ | Minimal | ✗ |
| Insider tip | ✓ | If fits | ✗ |
| 中英术语对照 | ✓ | ✓ (fixed format) | ✓ |
| Rhetorical questions | ✓ | ✗ | ✗ |
| Cross-cultural refs | ✓ | ✗ | ✗ |
| Colloquial asides | ✓ | ✗ | ✗ |
| Closing quote/ref | ✓ | At start/background only | ✗ (end immediately) |

## Anti-Patterns (Blacklist)

Apply to all genres, strictest for Guide/DP:

- **Cheesy closing**: "希望这篇对你有帮助", "最后祝大家……" — DP ends at the arrival date.
- **Pseudo-intimate**: "大家", "小伙伴们", "朋友们"
- **Redundant filler**: "简单来说", "顾名思义", "这里给大家解释一下"
- **Over-metaphor**: Only use established Chinese slang (e.g. "骑车"). No invented metaphors.
- **Summary ban**: No "以上就是……", "至此，你已经掌握了……" at end of guides/DP.
- **Process commentary**: No "不是盲猜", "过程顺利", "确认有效".
- **Link explanation**: When referencing, just link. Don't explain what the reference is.

## Typography (Tingtalk Rules)

**Spacing:**
- Chinese + English: `通过 Google 搜索引擎` ✓
- Chinese + number: `2016 年 4 月 29 日` ✓
- Number + unit: `458 ppi` ✓ (except Apple design conventions)
- Chinese + link: `庭说的[博客](https://tingtalk.me/)于 2017 年运营` ✓

**Proper Nouns (correct casing):**
- `GitHub` (not Github, github)
- `iOS` (not IOS)
- `Wi-Fi` (not WIFI, WiFi, wifi)
- `macOS` (not MacOS)
- `YouTube` (not Youtube)
- `4K`, `1080p` (preserve case)
- `WeChat`, `WhatsApp`, `App`, `OK`, `P.S.`

**Punctuation:**
- Full-width Chinese punctuation: `，。？！「」…`
- Half-width for English sentences: `. , ? !`
- **Ban em dash (—)**. Use hyphen (-) or en dash (–) if needed.

**Quotations & Titles:**
- Chinese titles: 《大醉侠》, 《加拿大留学生银行账户指南》
- English works: *Super Mario Clouds* (italic)
- Chinese quotes: 「引号」, English quotes: "quotes"

**Term Preferences:**
- 登录 (not 登陆)
- 账号 (not 帐号/账户/帐户)

**Other:**
- lowercase `internet` preferred over `Internet`
- `I` always capitalized
- Roman numerals: Ⅰ, Ⅱ, Ⅲ (as units)
- Multiplication sign: ×

## Revision Checklist

Before delivering text, verify:

- [ ] **Date entries**: Only action + result? No evaluation or explanation?
- [ ] **Background**: Every listed condition necessary for reproduction? No "我还准备了……"?
- [ ] **Closing**: Ends immediately after result? No commentary or outlook?
- [ ] **Em dash check**: Zero em dashes in entire text?
- [ ] **Code block**: Complete DP/guide article in one code block (frontmatter + all links)?
- [ ] **Colloquial check**: Any cheesy closing, pseudo-intimate language, over-metaphor? Delete or neutralize.
- [ ] **Bilingual spacing**: Half-width spaces between Chinese and English/numbers throughout?
- [ ] **Proper nouns**: Correct casing (GitHub, iOS, Wi-Fi, macOS, YouTube)?
- [ ] **Blacklist scan**: No "大家", "简单来说", "顾名思义", "以上就是", semicolons as connectors?

## Examples

**DP Timeline (positive):**
> **8.1 · Wells Fargo → U.S. Bank**
> 从 Wells Fargo 发起一笔 ACH 转账 $3,000 到刚开好的 U.S. Bank 账户，到账后被识别为直接存款。第一笔 Fake DD 达成。

Only action, amount, result. No "DOC 上充分验证过".

**Term Definition (positive):**
> **SUB（Sign-Up Bonus，开卡奖励）**
> 办新卡后在规定时间内完成消费要求，获取积分、里程或现金。

One-sentence definition. No examples, no evaluation.

**Negative Example:**
> 大家一定对 DD 不陌生吧？简单来说，它就是工资直接存进银行卡里。很多银行开户都会送奖励，但要求你必须要有直接存款，所以大家要特别注意哦~

Pseudo-intimate + verbose + zero information density + particle abuse.
