# 1-Tokenize: Instructions

Files in the `in` directory should adhere to the following formatting conventions so that they will be properly processed by the `tokenize.xsl` script.

1. Filename can be anything, but should end with `.xsl`. However, a simple file name that reflects the content of the would be optimal.

2. The file must have the following header, according to `xml` conventions.

```
<?xml version="1.0" encoding="UTF-8"?>
```

3. Then the file should have the following basic structure.

```
<document>
<title>The title of the article/text</title>
<citation>Full reference information for the article (e.g., author, year, title, where published, url, when downloaded, etc.)</citation>
<url>A url for the article or its abstract page if the article itself is not openly available</url>
<body>
The body of the article.

With a blank line between paragraphs.
</body>
</document>
```

4. Various characters need to be replaced with entity strings, as follows.

* left and right double quotes: “ &#8220; and ”&#8221;
* left and right single quotes: ‘ &#8216; and ’ &#8217;
* apostrophe: ' &apos;
* less-than or greater-than signs: < &lt; and > &gt;

