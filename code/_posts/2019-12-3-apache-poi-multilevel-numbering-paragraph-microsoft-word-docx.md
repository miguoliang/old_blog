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

## Introduction to Multilevel Numbering List

Multilevel Numbering List is a useful function to Word users to structure the whole document. A simple multilevel numbering list looks like this:

![Mulitlevel Numbering List](assets/2019-12-3-apache-poi-multilevel-numbering-paragraph-microsoft-word-docx/multilevel-numbering-list.jpg)

*You can learn how to define a mulilevel numbering list in Word on the official guide [here](https://support.office.com/en-us/article/define-new-bullets-numbers-and-multilevel-lists-6c06ef65-27ad-4893-80c9-0b944cb81f5f#multilevel).*

## Introduction to Apache POI

*The Apache POI Project's mission is to create and maintain Java APIs for manipulating various file formats based upon the Office Open XML standards (OOXML) and Microsoft's OLE 2 Compound Document format (OLE2). In short, you can read and write MS Excel files using Java. In addition, you can read and write MS Word and MS PowerPoint files using Java. Apache POI is your Java Excel solution (for Excel 97-2008). We have a complete API for porting other OOXML and OLE2 formats and welcome others to participate.*

For more detail about Apache POI on its [official website](http://poi.apache.org/index.html).

## Custom a setter to the level of a numbering list

Apache POI provides APIs to read and write docx file in XWPF module. You can find APIs about numbering list operation to paragraphs in XWPFParagraph. However, you can find a function named `getNumILvl` to get the level of the paragraph in the mulitlevel numbering list, but you can not find a function named like `setNumILvl` to set the level of the paragraph in the mulitlevel numbering list. So that's why I wrote this article.

However, you can set the level of the paragraph in the mulitlevel numbering list in your own utility class like this:

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

## Conclusion

The numbering information of a paragraph can be get and set by getters and setters in XWPFParagraph. But in some complex scenarios, numbering information is placed in styles for compression purpose in docx file, so these APIs do not work.
