# JavaScript Files

This directory contains the JavaScript files used by the EPUB Viewer plugin.

## Files

### epubViewer.js
- **Purpose**: Main EPUB viewer initialization and control logic
- **License**: GPL-3.0
- **Dependencies**: JSZip, Epub.js, jQuery

### Third-Party Libraries

#### JSZip v3.10.1
- **File**: `jszip.min.js`
- **Source**: https://cdn.jsdelivr.net/npm/jszip@3.10.1/dist/jszip.min.js
- **Purpose**: ZIP file decompression for EPUB files
- **License**: MIT or GPLv3
- **Homepage**: https://stuk.github.io/jszip/

#### Epub.js v0.3.93
- **File**: `epub.min.js`
- **Source**: https://cdn.jsdelivr.net/npm/epubjs@0.3.93/dist/epub.min.js
- **Purpose**: EPUB rendering and display
- **License**: BSD-2-Clause
- **Homepage**: https://github.com/futurepress/epub.js

## Updating Libraries

To update the third-party libraries to newer versions:

```bash
cd /path/to/plugins/generic/epubViewer/js

# Update JSZip
curl -L -o jszip.min.js https://cdn.jsdelivr.net/npm/jszip@VERSION/dist/jszip.min.js

# Update Epub.js
curl -L -o epub.min.js https://cdn.jsdelivr.net/npm/epubjs@VERSION/dist/epub.min.js
```

