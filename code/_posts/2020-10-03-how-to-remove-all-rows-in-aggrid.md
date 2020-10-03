---
layout: post
title: How to remove all rows in AgGrid
description:
image: /assets/2020-10-03-how-to-remove-all-rows-in-aggrid/banner.jpg
categories:
    - code
tags:
    - angular
    - ag-grid
---

There is no data API in AgGrid, therefore we use Grid API instead.

```typescript
// .ts file, and variable *grid* is declared like:
// @ViewChild('grid', { static: true }) grid: AgGridAngular;
this.grid.gridOptions.api.setColumnDefs([]);
const oldData = [];
this.grid.gridOptions.api.forEachNode(r => oldData.push(r.data));
this.grid.gridOptions.api.applyTransaction({ remove: oldData });
```

## Conclusion

If we want to clear grid properly, we need do step by step:

1. Reset `columnDefs` to an empty array.
2. Fetch all existing raw data.
3. Remove all existing raw data by `applyTransaction`.
