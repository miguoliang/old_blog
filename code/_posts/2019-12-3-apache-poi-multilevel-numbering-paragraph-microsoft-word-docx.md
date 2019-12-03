---
layout: post
title: "Apache POI: Set the level of a paragraph in a multilevel numbering list in Microsoft Word Docx File"
description: How to et the level of a paragraph in a multilevel numbering list in microsoft word docx file by Apache POI
date: 2019-12-3 00:00:00 +08:00
image: /assets/2019-12-3-apache-poi-multilevel-numbering-paragraph-microsoft-word-docx/banner.jpg
categories:
    - code
tags:
    - apache poi
---

Multilevel Numbering List is a useful function to Word users to structure the whole document.

Apache POI provides APIs to read and write docx file in XWPF module. You can find APIs about numbering list operation to paragraphs in XWPFParagraph. However, you can find a function named `getNumILvl` to get the level of the paragraph in the mulitlevel numbering list, but you can not find a function named like `setNumILvl` to set the level of the paragraph in the mulitlevel numbering list. However, you can set the level of the paragraph in the mulitlevel numbering list in your own utility class like this:

```java
public static void setParagraphILvlID(XWPFParagraph paragraph, int lvlId) {

    if (lvlId >= 0) {
        if (paragraph.getCTP().getPPr().getNumPr().getIlvl() == null) {
            paragraph.getCTP().getPPr().getNumPr().addNewIlvl();
        }
        paragraph.getCTP().getPPr().getNumPr().getIlvl().setVal(BigInteger.valueOf(lvlId));
    }
}
```

**Notes Here**: The numbering information of a paragraph can be get and set by getters and setters in XWPFParagraph. But in some complex scenarios, numbering information is placed in styles for compression purpose in docx file, so these APIs do not work.
