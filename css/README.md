# CSS Files

This directory contains the CSS stylesheets used by the EPUB Viewer plugin.

## Files

### epubViewer.css
- **Purpose**: Styles for the EPUB viewer interface
- **License**: GPL-3.0
- **Contents**:
  - Viewer container layout
  - Reading area styles
  - Navigation controls (previous/next buttons)
  - Responsive design styles

## Style Customization

To customize the appearance of the EPUB viewer, edit `epubViewer.css`.

### Key Selectors

- `#epub-viewer` - Main viewer container
- `#epub-area` - Reading area where EPUB content is displayed
- `#epub-controls` - Navigation controls container
- `#epub-controls button` - Navigation buttons (Previous/Next)

### Example Customizations

```css
/* Change control button colors */
#epub-controls button {
    background: #007bff;
    color: #fff;
}

/* Adjust viewer height */
#epub-viewer {
    height: 90vh; /* Default is 97vh */
}

/* Change controls position */
#epub-controls {
    bottom: 30px; /* Default is 20px */
}
```
