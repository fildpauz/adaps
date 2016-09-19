# 2-Attach-IDs: Instructions

Files in the `in` directory should be copied from the `1-tokenize/out` directory and should be manually revised as follows so that they will be properly processed by the `attach-ids.xsl` script.

1. Review content of file to ensure that sentences have been categorized correctly. Some typical problem cases include:

* Abbreviations ending in a period (e.g., "Mr.", "St. Francis") are marked as sentence endings.
* A footnote symbol or number appears after a sentence and prevents the sentence from being correctly marked.

2. Check that words have been tokenized correctly. The tokenize process uses spacing to decide tokens and may incorrectly characterize the following.

* Math equations and expressions (e.g., "Pi = 3.1415", "2x + y"). Format them as one whole token.
* Use of long dash might cause two unrelated words to be connected together in one token. Separate words as individual tokens and make the dash a `punc` element.
