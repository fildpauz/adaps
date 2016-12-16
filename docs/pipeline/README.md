![ADAPS logo](https://fildpauz.github.io/adaps/adaps_logo_sm.png "Academic Document Annotation and Presentation Schema")

# ADAPS processing pipeline

This README document gives an overview of the pipeline for processing documents according to the ADAPS scheme. The end product of the entire procedure can be viewed at the public page for ADAPS documents: <https://fildpauz.github.io/adaps/>

Documents are processed in five steps alternately by human editors and machine scripts, and pass through the five subfolders in this folder as each respective step is completed. After editing a file, editors will place the file in the `in` subfolder at each step. The files will be processed by a machine script and the output will go to the `out` folder. The `out` file can then be used by the editor for editing at the next step. The five steps are summarized below.

1. *Tokenize* - The editor formats a text into a minimal `xml` document. The machine script adds `xml` mark-up to show paragraphs, sentences, and tokens (i.e., words).
2. *Attach IDs* - The editor cleans up any problems from the output of Step 1. The machine script adds IDs to all of the paragraphs, sentences, and tokens.
3. *Classify words* - The output of Step 2 is immediately processed by a machine script in Step 3 (no editing work by the editor). The machine script tags all words in the text that are GSL or AWL words.
4. *Annotate* - The editor marks various features of the text: technical terms, abbreviations, logical connectors, and anaphors. The machine script gives these elements IDs and provides placeholders for the Step 5 editing task.
5. *Detail and finish* - The editor inputs details on many of the text features marked in Step 4. The machine script processes the final result into an `html` page for web viewing.

The final output is added to the public page for viewing ADAPS texts.
