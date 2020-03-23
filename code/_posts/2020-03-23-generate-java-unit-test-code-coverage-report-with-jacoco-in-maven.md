---
layout: post
title: Generate Java Unit Test Code Coverage Report with JaCoCo in Maven
description: This is a starter guide for Java developers to generate and read a unit test code coverage report with JaCoCo in Maven. People will learn the entire development workflow that includes starting a new Java project with Maven, writing a simple unit test, running unit tests, generating unit tests, and reading the code coverage report.
image: /assets/2020-03-23-generate-java-unit-test-code-coverage-report-with-jacoco-in-maven/banner.jpg
categories:
    - code
tags:
    - java
    - jacoco
    - unit test
    - code coverage
    - maven
---

## Introduction

This guide is a sister to [Generate Java Unit Test Code Coverage Report with JaCoCo in Gradle](/generate-java-unit-test-code-coverage-report-with-jacoco-in-gradle.html). This guide shows you how to do the same in [Maven](https://maven.apache.org/). Maven is a software project management and comprehension tool. Based on the concept of a project object model (POM), Maven can manage a project's build, reporting and documentation from a central piece of information. Both Gradle and Maven are widely tools.

## Install Maven

If you are working on macOS, you must know about a famous package management tool named [Homebrew](https://brew.sh/), and you can install the latest version of Maven globally in one line and without any extra settings.

```shell
brew install maven
```

Then, verify your installation.

```shell
$ mvn
Apache Maven 3.6.2 (40f52333136460af0dc0d7232c0dc0bcf0d9e117; 2019-08-27T23:06:16+08:00)
Maven home: /usr/local/Cellar/maven/3.6.2/libexec
Java version: 11.0.6, vendor: AdoptOpenJDK, runtime: /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
Default locale: zh_CN_#Hans, platform encoding: UTF-8
OS name: "mac os x", version: "10.15.3", arch: "x86_64", family: "mac"
```

That's it!

## Setup an empty Java Project

Firstly, make an empty folder named *maven-jacoco* and we will work in it.

```shell
mkdir maven-jacoco
cd maven-jacoco
```

Secondly, run Maven setup command in interactive mode.

```shell
$ mvn archetype:generate

[INFO] Scanning for projects...
[INFO]
[INFO] ------------------< org.apache.maven:standalone-pom >-------------------
[INFO] Building Maven Stub Project (No POM) 1
[INFO] --------------------------------[ pom ]---------------------------------
[INFO]
[INFO] >>> maven-archetype-plugin:3.0.1:generate (default-cli) > generate-sources @ standalone-pom >>>
[INFO]
[INFO] <<< maven-archetype-plugin:3.0.1:generate (default-cli) < generate-sources @ standalone-pom <<<
[INFO]
[INFO]
[INFO] --- maven-archetype-plugin:3.0.1:generate (default-cli) @ standalone-pom ---
[INFO] Generating project in Interactive mode
[WARNING] No archetype found in remote catalog. Defaulting to internal catalog
[INFO] No archetype defined. Using maven-archetype-quickstart (org.apache.maven.archetypes:maven-archetype-quickstart:1.0)

Choose archetype:
1: internal -> org.apache.maven.archetypes:maven-archetype-archetype (An archetype which contains a sample archetype.)
2: internal -> org.apache.maven.archetypes:maven-archetype-j2ee-simple (An archetype which contains a simplifed sample J2EE application.)
3: internal -> org.apache.maven.archetypes:maven-archetype-plugin (An archetype which contains a sample Maven plugin.)
4: internal -> org.apache.maven.archetypes:maven-archetype-plugin-site (An archetype which contains a sample Maven plugin site.
      This archetype can be layered upon an existing Maven plugin project.)
5: internal -> org.apache.maven.archetypes:maven-archetype-portlet (An archetype which contains a sample JSR-268 Portlet.)
6: internal -> org.apache.maven.archetypes:maven-archetype-profiles ()
7: internal -> org.apache.maven.archetypes:maven-archetype-quickstart (An archetype which contains a sample Maven project.)
8: internal -> org.apache.maven.archetypes:maven-archetype-site (An archetype which contains a sample Maven site which demonstrates
      some of the supported document types like APT, XDoc, and FML and demonstrates how
      to i18n your site. This archetype can be layered upon an existing Maven project.)
9: internal -> org.apache.maven.archetypes:maven-archetype-site-simple (An archetype which contains a sample Maven site.)
10: internal -> org.apache.maven.archetypes:maven-archetype-webapp (An archetype which contains a sample Maven Webapp project.)
Choose a number or apply filter (format: [groupId:]artifactId, case sensitive contains): 7: 7

Define value for property 'groupId': com.muchencute.demo
Define value for property 'artifactId': maven-jacoco
Define value for property 'version' 1.0-SNAPSHOT: :
Define value for property 'package' com.muchencute.demo: :

Confirm properties configuration:
groupId: com.muchencute.demo
artifactId: maven-jacoco
version: 1.0-SNAPSHOT
package: com.muchencute.demo
 Y: :
[INFO] ----------------------------------------------------------------------------
[INFO] Using following parameters for creating project from Old (1.x) Archetype: maven-archetype-quickstart:1.1
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: basedir, Value: /Users/miguoliang/Documents/Github
[INFO] Parameter: package, Value: com.muchencute.demo
[INFO] Parameter: groupId, Value: com.muchencute.demo
[INFO] Parameter: artifactId, Value: maven-jacoco
[INFO] Parameter: packageName, Value: com.muchencute.demo
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] project created from Old (1.x) Archetype in dir: /Users/miguoliang/Documents/Github/maven-jacoco
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  41.634 s
[INFO] Finished at: 2020-03-23T12:23:07+08:00
[INFO] ------------------------------------------------------------------------
```

**Note:** I generate the empty project by *org.apache.maven.archetypes:maven-archetype-quickstart*, because it's simplify to focus on my topic.

Finally, a simple Java application project is generated.

![Directory Structure](/assets/2020-03-23-generate-java-unit-test-code-coverage-report-with-jacoco-in-maven/directory-structure.jpg)

{%- include google-adsense-amp.html max-height="100" -%}

## Setup Compiler Plugin **IMPORTANT**

We need set the source and target to 1.6 or higher in *Maven Compiler Plugin*, otherwise we can not compile our code in the next. Append following codes into *pom.xml*

```xml
<build>
    <plugins>
        <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <configuration>
            <source>11</source>
            <target>11</target>
        </configuration>
        <version>3.6.1</version>
        </plugin>
    </plugins>
</build>
```

**Note:** *build* tag is a children of *project* tag.

## Use JUnit 4

By default, Maven uses JUnit 3, but JaCoCo supports JUnit 4 and higher. Therefore, we update JUnit to the version 4.

Firstly, update the version of JUnit to 4.13 in *pom.xml*.

```xml
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.13</version>
    <scope>test</scope>
</dependency>
```

## Setup JaCoCo Maven Plugin

Import *maven-jacoco-plugin* by pasting the following codes into *plugins* tag.

```xml
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.5</version>
    <executions>
        <execution>
            <goals>
                <goal>prepare-agent</goal>
            </goals>
        </execution>
        <execution>
            <id>report</id>
            <phase>prepare-package</phase>
            <goals>
                <goal>report</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

## Write a Simple Function to be Tested Later

Open and edit *App.java*.

```java
package com.muchencute.demo;

/**
 * Hello world!
 *
 */
public class App {

    // To be tested!
    public String getAnAnimal(String animal) {

        if ("cat".equalsIgnoreCase(animal)) {
            return "Garfield";
        } else if ("dog".equalsIgnoreCase(animal)) {
            return "Odie";
        } else {
            return "Opps!";
        }
    }

    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}
```

## Update the Unit Test Class

Open and update *AppTest.java*.

```java
package com.muchencute.demo;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Unit test for simple App.
 */
public class AppTest {

    // Our test here!
    @Test
    public void testGetAnAnimal() {
        assertEquals("Garfield", new App().getAnAnimal("cat"));
    }
}
```

## Run and Generate Code Coverage Report

Use the following command to clean the previous build result, run unit tests, and generate a code coverage report.

```shell
mvn clean test jacoco:report
```

The final code coverage report is saved in *target/site/jacoco*. Developers can open *index.html* to open the report in a browser.

![Index of Code Coverage Report](/assets/2020-03-23-generate-java-unit-test-code-coverage-report-with-jacoco-in-maven/index-code-coverage-report.jpg)

{%- include google-adsense-amp.html max-height="100" -%}

Besides, developers can locate to uncovered lines in a specific file easily.

![Uncovered Lines](/assets/2020-03-23-generate-java-unit-test-code-coverage-report-with-jacoco-in-maven/uncovered-lines.jpg)

{%- include google-adsense-amp.html max-height="100" -%}

**Note:** The Code Coverage Report is generated when all unit tests pass, in another words, you can not find the code coverage report if any unit test fails.

## Conclusion

In the method of using JaCoCo, there is no difference in principle between Maven and Gradle. The only obvious difference is that Maven looks more complicated than Gradle.

Like I said at the end of [Generate Java Unit Test Code Coverage Report with JaCoCo in Gradle](/generate-java-unit-test-code-coverage-report-with-jacoco-in-gradle.html):

> Developers should know how to measure their work, including progress, quality, and efficent. The code coverage report is useful, because it can make developers' review more effecient and effective. Therefore, developers can control their code completely with a code coverage report. However, 100% code coverage is ideal, especially it is impossible when you use some third-party library in your project, so that developers do not to be demanding.
