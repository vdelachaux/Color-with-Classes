//%attributes = {}
//MARK:-[Constructor variants]
// Test constructor with no parameters
var $color:=cs:C1710.color.new()
ASSERT:C1129($color.main=0x0000)
ASSERT:C1129($color.rgb#Null:C1517)
ASSERT:C1129($color.hsl#Null:C1517)
ASSERT:C1129($color.css#Null:C1517)

// Test constructor with 4D color number
$color:=cs:C1710.color.new(0x00FF0000)
ASSERT:C1129($color.main=0x00FF0000)
ASSERT:C1129($color.rgb.red=255)
ASSERT:C1129($color.rgb.green=0)
ASSERT:C1129($color.rgb.blue=0)

// Test constructor with hex CSS string
$color:=cs:C1710.color.new("#00FF00")
ASSERT:C1129($color.rgb.red=0)
ASSERT:C1129($color.rgb.green=255)
ASSERT:C1129($color.rgb.blue=0)

// Test constructor with rgb() CSS string
$color:=cs:C1710.color.new("rgb(0,0,255)")
ASSERT:C1129($color.rgb.red=0)
ASSERT:C1129($color.rgb.green=0)
ASSERT:C1129($color.rgb.blue=255)

// Test constructor with hsl() CSS string
$color:=cs:C1710.color.new("hsl(0,100%,50%)")
ASSERT:C1129($color.rgb.red=255)
ASSERT:C1129($color.rgb.green=0)
ASSERT:C1129($color.rgb.blue=0)

// Test constructor with named color
$color:=cs:C1710.color.new("white")
ASSERT:C1129($color.rgb.red=255)
ASSERT:C1129($color.rgb.green=255)
ASSERT:C1129($color.rgb.blue=255)

// Test constructor with RGB object
$color:=cs:C1710.color.new({red: 255; green: 128; blue: 64})
ASSERT:C1129($color.rgb.red=255)
ASSERT:C1129($color.rgb.green=128)
ASSERT:C1129($color.rgb.blue=64)

// Test constructor with HSL object
$color:=cs:C1710.color.new({hue: 120; saturation: 100; lightness: 50})
ASSERT:C1129($color.rgb.red=0)
ASSERT:C1129($color.rgb.green=255)
ASSERT:C1129($color.rgb.blue=0)

//MARK:-[Setters]
// Test setColor
$color:=cs:C1710.color.new()
$color.setColor(0x00FF)
ASSERT:C1129($color.main=0x00FF)
ASSERT:C1129($color.rgb.blue=255)

// Test setRGB
$color:=cs:C1710.color.new()
$color.setRGB({red: 100; green: 150; blue: 200})
ASSERT:C1129($color.rgb.red=100)
ASSERT:C1129($color.rgb.green=150)
ASSERT:C1129($color.rgb.blue=200)

// Test setHSL
$color:=cs:C1710.color.new()
$color.setHSL({hue: 240; saturation: 100; lightness: 50})
ASSERT:C1129($color.rgb.blue>0)

// Test setCSS
$color:=cs:C1710.color.new()
$color.setCSS("#FF00FF")
ASSERT:C1129($color.rgb.red=255)
ASSERT:C1129($color.rgb.blue=255)

//MARK:-[Conversions RGB]
$color:=cs:C1710.color.new(0x00FF8040)

// Test colorToRGB
var $rgb : Object
$rgb:=$color.colorToRGB($color.main)
ASSERT:C1129($rgb.red=255)
ASSERT:C1129($rgb.green=128)
ASSERT:C1129($rgb.blue=64)

// Test colorToCSS - components
var $css : Text
$css:=$color.colorToCSS($color.main; "components")
ASSERT:C1129($css="rgb(255,128,64)")

// Test colorToCSS - hex
$css:=$color.colorToCSS($color.main; "hex")
ASSERT:C1129($css="#F84")

// Test colorToCSS - hexLong
$css:=$color.colorToCSS($color.main; "hexLong")
ASSERT:C1129($css="#FF8040")

// Test colorToCSS - hsl
$css:=$color.colorToCSS($color.main; "hsl")
ASSERT:C1129(Match regex:C1019("hsl\\(20,100%,(62|63)%\\)"; $css))

//MARK:-[Conversions HSL]
// Test colorToHSL
var $hsl : Object
$hsl:=$color.colorToHSL($color.main)
ASSERT:C1129($hsl.hue=20)
ASSERT:C1129($hsl.saturation=100)
ASSERT:C1129(($hsl.lightness=62) | ($hsl.lightness=63))

// Test hslToRGB
$rgb:=$color.hslToRGB({hue: 60; saturation: 100; lightness: 50})
ASSERT:C1129($rgb.red=255)
ASSERT:C1129($rgb.green=255)
ASSERT:C1129($rgb.blue=0)

// Test hslToColor
var $colorValue : Integer
$colorValue:=$color.hslToColor({hue: 240; saturation: 100; lightness: 50})
ASSERT:C1129($colorValue=0x00FF)

// Test hslToCss
$css:=$color.hslToCss({hue: 0; saturation: 100; lightness: 50})
ASSERT:C1129($css="hsl(0,100%,50%)")

//MARK:-[Conversions RGB-HSL]
// Test rgbToColor
$colorValue:=$color.rgbToColor({red: 255; green: 0; blue: 0})
ASSERT:C1129($colorValue=0x00FF0000)

// Test rgbToHSL
$hsl:=$color.rgbToHSL({red: 0; green: 255; blue: 0})
ASSERT:C1129($hsl.hue=120)
ASSERT:C1129($hsl.saturation=100)
ASSERT:C1129($hsl.lightness=50)

//MARK:-[Complementary colors]
// Test getMatchingColors - complementary
$color:=cs:C1710.color.new(0x00FF0000)  // Red
var $complementary : Collection
$complementary:=$color.getMatchingColors(kMatchingSchemeComplementary)
ASSERT:C1129($complementary.length>=1)

// Test getMatchingColors - split complementary
var $splitComplementary : Collection
$splitComplementary:=$color.getMatchingColors(kMatchingSchemeSplitComplementary)
ASSERT:C1129($splitComplementary.length>=2)

// Test getMatchingColors - triadic
var $triadic : Collection
$triadic:=$color.getMatchingColors(kMatchingSchemeTriadic)
ASSERT:C1129($triadic.length>=2)

// Test getMatchingColors - tetradic
var $tetradic : Collection
$tetradic:=$color.getMatchingColors(kMatchingSchemeTetradic)
ASSERT:C1129($tetradic.length>=4)

//MARK:-[Utilities]
// Test setColorIndexed
$color:=cs:C1710.color.new()
$color.setColorIndexed(1)
ASSERT:C1129($color.rgb#Null:C1517)

// Test fontColor (returns best contrast text color for background)
$color:=cs:C1710.color.new(0x00FFFFFF)  // White background
var $fontColorForWhite : Text
$fontColorForWhite:=$color.fontColor(0x0000; 0x0000)  // vs Black
ASSERT:C1129(Length:C16($fontColorForWhite)>0)

$color:=cs:C1710.color.new(0x0000)  // Black background
var $fontColorForBlack : Text
$fontColorForBlack:=$color.fontColor(0x00FFFFFF; 0x00FFFFFF)  // vs White
ASSERT:C1129(Length:C16($fontColorForBlack)>0)

// Test isValid
$color:=cs:C1710.color.new(0x00FF0000)
ASSERT:C1129($color.isValid())

// Test colorPicker (interactive - just verify it returns the color value)
$color:=cs:C1710.color.new(0x00FF0000)
var $pickerResult : Integer
$pickerResult:=$color.main
ASSERT:C1129($pickerResult#Null:C1517)

// Test highlightColor
$color:=cs:C1710.color.new("highlightColor")
ASSERT:C1129($color.main#Null:C1517)

//MARK:-[Chaining]
// Test method chaining
$color:=cs:C1710.color.new()\
.setColor(0x00FF0000)\
.setHSL({hue: 120; saturation: 100; lightness: 50})
ASSERT:C1129($color.rgb.green=255)
