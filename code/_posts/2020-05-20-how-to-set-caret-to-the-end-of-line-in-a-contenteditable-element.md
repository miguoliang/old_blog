---
layout: post
title: How to Set Caret to the End of Line in a Contenteditable Element
description:
image: /assets/2020-05-20-how-to-set-caret-to-the-end-of-line-in-a-contenteditable-element/banner.jpg
categories:
    - code
tags:
    - javascript
    - dom
    - html
    - web
---

When I develop an online rich text editor, I paid much attention to control the caret on a editable element. Therefore, I write this guide to share my experiences on the caret control to an editable element in morden browser.

There are two key points on the caret control to an editable element.

1. Get the offset from an editable element.

2. Set an offset to an editable element.

## Get the offset from an editable element

```javascript
function getSelectionOffset(node: Node) {
  const sel = window.getSelection();
  const currentTextNode = sel.focusNode;
  const textNodes = getTextNodes(node);
  let offset = sel.focusOffset;
  for (const n of textNodes) {
    if (n === currentTextNode) {
      break;
    } else {
      offset += n.textContent.length;
    }
  }
  return offset;
}
```

## Set an offset to an editable element

```javascript
function setSelectionOffset(node: Node, offset: number) {
  const textNodes = getTextNodes(node);
  for (const n of textNodes) {
    if (n.textContent.length >= offset) {
      window.getSelection().setPosition(n, offset);
      break;
    } else {
      offset -= n.textContent.length;
    }
  }
}
```

## Get all positerities of a certain node

```javascript
function getTextNodes(node: Node): Node[] {
  let textNodes = [];
  if (node.hasChildNodes()) {
    node.childNodes.forEach(n => {
      if (n.nodeType !== Node.TEXT_NODE) {
        textNodes = textNodes.concat(getTextNodes(n));
      } else {
        textNodes.push(n);
      }
    });
  }
  return textNodes;
}
```

Therefore, if you want to set caret to the end of an certain editable element, you can just call `setSelectionOffset` with itself as a node object and specify the offset which is same as the length of its text content.
