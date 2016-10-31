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

The `type` attribute refers to the type of logical connector. This should be filled in with one of the following types, accordingly.

* `similarity` - Idea 1 and idea 2 are similar to each other: 1 Cats are good companions. *Similarly*, 2 dogs are good companions.
* `contrast` - Idea 1 and idea 2 are different from each other: 1 Birds fly in the air, *while* 2 fish swim in water.
* `elaboration` - Idea 2 provides extra information or detail related to idea 1: 1 Dolphins make whistle and clicking noises to each other. *Furthermore*, 2 dolphins communicate by jumping above the water's surface.
* `generalization` - Idea 2 is a more general idea that includes idea 1: 1 Koko the gorilla uses some sign language with her trainer. *In general*, 2 many animals have learned human communication systems.
* `example` - Idea 2 is a specific example or instance of idea 1: 1 Elephants are social animals. *To illustrate*, 2 Indian elephants live in family units.
* `cause - Event 1 is a cause of event 2: 1 Mary worked more than 15 hours a day for two weeks. *As a result*, 2 she had a heart attack and went to the hospital.
* `explanation` - Event 2 explains event 1 in some way: 1 Brian became a millionaire instantly *because* 2 he won the grand prize in the year-end lottery.
* `condition` - One event is a condition that must be true for the other event to become true: 1 John will enter the university *if* 2 he manages to pass the entrance exam.
* `violated expectation` - One event contradicts an expectation that the other event typically causes: 1 *Although* the construction worker slipped and fell 12 floors, 2 he walked away with only a broken arm.
* `temporal sequence` - Idea 1 is in some kind of temporal (time-based) relation with idea 2: 1 The surveys were distributed to the students *and then* 2 they filled in the survey sheets at their own pace.
* `attribution` - The content of idea 2 is being attributed to the person or organization in idea 1: 1 The experimenters *reported* that 2 the results were very new and hadn't been properly analyzed yet.
