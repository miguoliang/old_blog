---
layout: post
title:  "Get the background color of a cell with solid pattern fill by POI"
date:   2019-1-9 21:56:00 +0800
categories: webpack
---
1\. Add dependency in Maven

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.muchencute</groupId>
  <artifactId>report-generator</artifactId>
  <version>1.0-SNAPSHOT</version>
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <configuration>
          <source>7</source>
          <target>7</target>
        </configuration>
      </plugin>
    </plugins>
  </build>

  <dependencies>
    <dependency>
      <groupId>org.apache.poi</groupId>
      <artifactId>poi-ooxml</artifactId>
      <version>4.0.1</version>
    </dependency>
  </dependencies>

</project>
```

2\. In Java, use `cell.getCellStyle().getFillForegroundColorColor()` instead of `cell.getCellStyle().getFillBackgroundColorColor()`, is it strange? Yes, you need get the background color with the method which name looks like get the foreground color. The reason is that only the foreground tag (`fgColor`) is used if the fill pattern is solid. More detail about that is in the OpenXML Standard, and you could read a tiny document here [https://docs.microsoft.com/en-us/previous-versions/office/developer/office-2010/cc796846%28v%3Doffice.14%29](https://docs.microsoft.com/en-us/previous-versions/office/developer/office-2010/cc796846%28v%3Doffice.14%29).
```java
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFColor;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

public class Main {

    public static void main(String[] args) throws IOException {

        final String filename = args[0];

        final File file = new File(filename);

        try (final Workbook workbook = WorkbookFactory.create(file)) {

            final Sheet sheet = workbook.getSheetAt(0);

            Iterator<Row> rowIterable = sheet.rowIterator();
            while (rowIterable.hasNext()) {
                Row row = rowIterable.next();
                Cell cell = row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                Color fillColor = cell.getCellStyle().getFillForegroundColorColor();
                System.out.println(((XSSFColor) fillColor).getARGBHex());
            }
        }
    }
}
```