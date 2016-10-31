# 5-Detail-and-Finish Instructions

This step involves completing the details of the annotation from the previous step in preparation for final output of the `html` file for use by users. The output from Step 4 adds the following attributes to the nodes that were tagged.

* `abbr` - `id`, `info`
* `term` - `id`, `info`
* `anaphor` - `id`, `info`
* `connector` - `id`, `type`, `info`

The `id` nodes should not be changed. bu the remainder should be filled in as follows.

## `info` attribute

The `info` attribute is used to describe a range of text that corresponds to the annotation type. For abbreviations, technical terms, and anaphors, the range of text (usually earlier in the text) which explains or defines the abbreviation, term, or anaphor should be identified and then the id of the first token and the id of the last token should be written in the `info` attribute separated by a colon `:`.

```
<anaphor id="p04-s01-a01" info="p04-s01-t02:p04-s01-t14">
  <t id="p04-s01-t19" type="GSL-1">they</t>
</anaphor>

<term id="p05-s01-e01" info="p05-s01-t03:p05-s01-t19">
  <t id="p05-s01-t01">Histamine</t>
</term>

<abbr id="p1-s1-b2" info="p1-s1-t37:p1-s1-t38">
  <t id="p1-s1-t36">3D</t>
</abbr>
```

For connectors, however, two ranges need to be given: one range corresponding to each of the two ideas being connected, separated by a comma `,`.

```
<connector id="p2-s1-c1" type="elaboration" info="p1-s3-t1:p1-s3-t6,p2-s1-t2:p2-s1-t23">
  <t id="p2-s1-t1" type="GSL1">Also</t>
</connector>
```

## `type` attribute

The `type` attribute refers to the type of logical connector
