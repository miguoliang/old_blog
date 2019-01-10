---
layout: post
title:  "Close multiple resources with AutoCloseable (try-with-resources)"
date:   2019-1-10 19:40:00 +0800
categories: java
---
You could use `;` to separate statements. Demo is below:
```java
try (
        XWPFDocument document = new XWPFDocument(OPCPackage.open(outputFilename));
        OutputStream outputStream = FileUtils.openOutputStream(new File(outputFilename))
) {

    replaceInParagraphs(document);

    replaceInTables(document);

    document.write(outputStream);

    filenames.add(outputFilename);
}
```