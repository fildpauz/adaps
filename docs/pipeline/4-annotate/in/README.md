# 4-Annotate - Instructions

Highlight various elements of the text that identify certain aspects of its structure and content.

## Abbreviations

Surround abbreviations in the text with the `abbr` element.

```
<abbr>
    <t id="p1-s1-t10">MIT</t>
</abbr>
```

There may be many abbreviations used in academic texts, especially such things as measurement units. However, for the ADAPS mark-up, **only** abbrevations that are explicitly defined in the text should be marked (e.g., "Massachusetts Institute of Technology (MIT)...").

## Technical terms

Surround technical terms with the `term` element.

```
<term>
    <t id="p4-s4-1-t10">Origamizer</t>
</term>
```

Similar to _abbreviations_ above, there may be many technical terms in a text. But for the ADAPS system, only those technical terms which are explicitly defined in the text should be marked (e.g., "Cells (the basic units of an organism)...").

## Connectors

Surround logical connectors with the `connector` element.

```
<connector>
    <t id="p6-s2-t24" type="GSL1">after</t>
</connector>
```

Logical connectors are usually one or two word phrases that connect two larger ideas together in a logical manner (e.g., to indicate similarity between ideas, or cause-and-effect). In the ADAPS system, however, only connectors that connect full sentences (i.e., standalone clauses) should be marked. Thus, an _and_ that connects a couple of nouns (e.g., "apple and orange") is not a connector.

## Anaphors

Anaphors are expressions that directly depend on other parts of the text for their interpretation; for example, pronouns and definite expressions. Surround anaphors with the `anaphor` element.

```
<anaphor>
    <t id="p6-s2-t30" type="GSL1">their</t>
</anaphor>

<anaphor>
    <t id="p5-s1-t9" type="GSL1">the</t>
    <t id="p5-s1-t10">robot</t>
</anaphor>
```

Note that not every noun phrase beginning with "the" is an anaphor. In fact, relatively few are.

## Emphasis

Mark any cases that had some sort of text emphasis in the original article such as italics or bold face. Mark these with an `emph` element.

```
<emph>
    <t id="p1-s3-t1" type="GSL1">Science</t>
</emph>
```
