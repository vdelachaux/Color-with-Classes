<!-- cs.bmp.new(picture) -->
## bmp

This class is dedicated to reading and analyzing BMP (Bitmap) image files. It provides methods to extract color information and access pixel data from bitmap images.

### Summary

|Properties|Type|Description|
|---------|:----:|------|
|**.data**| Blob | Raw bitmap data in BLOB format |
|**.header**| Object | BMP header information including width, height, pixel size, etc. |
|**.success**| Boolean | Status of the last operation |
|**.error**| Text | Error message if operation failed |
|**.codec**| Text | Codec used (default: "com.microsoft.bmp") |
|**.map**| Object | Pixel data as collections with RGBA channels |

|Function|Action|
|--------|------|
|.**setPicture** ( picture : `Picture` ) | Load and initialize a BMP image from a Picture object |
|.**getMediumColor** () → `Integer` | Returns the average color of the bitmap as a 4D color value |
|.**getDominantColor** ( {accuracy : `Integer`} ) → `Integer` | Returns the dominant (most frequent) color in the bitmap |
|.**getBitmap** () → `Object` | Returns the pixel data with separate RGBA channel collections |
|.**getHeader** () → `Object` | Returns detailed BMP header information |
|.**getPixel** ( x : `Integer` ; y : `Integer` ) → `Object` | Returns the RGBA values of a pixel at coordinates (x, y) |
|.**getPixelOffset** ( x : `Integer` ; y : `Integer` ) → `Integer` | Returns the array index for a pixel at coordinates (x, y) |

### 🔸cs.bmp.new()

The class constructor `cs.bmp.new()` can be called without parameters to create an empty BMP object.

>`cs.bmp.new()`

The class constructor also accepts an optional `Picture` parameter to load and analyze a bitmap image.

>`cs.bmp.new(picture)`

### Image Processing

When a `Picture` is loaded via `setPicture()` or the constructor:
- White pixels (0xFFFFFF) are removed
- Black pixels (0x000000) are removed
- The image is resized to 128×128 pixels
- The image is converted to BMP format

### Color Analysis

**getMediumColor()** calculates the average RGB values of all opaque pixels and converts the result to HSL for color adjustments (enforces minimum saturation and lightness bounds).

**getDominantColor()** analyzes the bitmap to find the most frequently occurring color, filtering out white, black, and grey values. It accepts an optional `accuracy` parameter (default 4) to control sampling density.

### Pixel Data Structure

The `getBitmap()` function returns an object with the following structure:

```
{
  red: Collection,      // Array of red values (0-255)
  green: Collection,    // Array of green values (0-255)
  blue: Collection,     // Array of blue values (0-255)
  alpha: Collection     // Array of alpha values (0-255), only if pixelSize=4
}
```

Pixel indices are calculated as: `y * width + x`

### BMP Header Information

The `header` object contains:
- **width**, **height**: Image dimensions
- **colorDepth**: 24 or 32 bits per pixel
- **pixelSize**: Bytes per pixel (3 or 4)
- **topToBottom**: Whether image is stored top-to-bottom
- **startOffset**: Byte offset where pixel data begins

### Error Handling

Check the `success` property and `error` message if operations fail:

```
var $bmp : cs.bmp
$bmp:=cs.bmp.new($picture)

If (Not $bmp.success)
  ALERT("Error: "+$bmp.error)
End if
```
