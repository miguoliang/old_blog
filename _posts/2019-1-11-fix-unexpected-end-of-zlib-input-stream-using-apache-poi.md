---
layout: post
title:  "Fix Unexpected end of ZLIB input stream using Apache POI"
date:   2019-1-11 16:53:00 +0800
categories: code
---

Pretty sure the problem is you overwriting the file. Try to save to a different path. If you still want to overwrite the file, save to something else, delete the original, then rename the file you wrote into place:

```java
    String tempFilename = createTempFile(template);
    String outputFilename = StringUtils.removeEndIgnoreCase(tempFilename, ".temp");
    FileUtils.forceDelete(new File(outputFilename));
    System.out.println(outputFilename);
    try (
            XWPFDocument document = new XWPFDocument(OPCPackage.open(tempFilename));
            OutputStream outputStream = FileUtils.openOutputStream(new File(outputFilename))
    ) {
        replaceInParagraphs(document);
        replaceInTables(document);
        document.write(outputStream);
        filenames.add(outputFilename);
    }
    FileUtils.forceDelete(new File(tempFilename));
```

A similar issue in Stackoverflow:[https://stackoverflow.com/questions/52389798/java-io-eofexception-unexpected-end-of-zlib-input-stream-using-apache-poi](https://stackoverflow.com/questions/52389798/java-io-eofexception-unexpected-end-of-zlib-input-stream-using-apache-poi
)
