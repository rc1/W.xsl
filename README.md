# w.xsl &mdash; XSL utilities #

A collection of XSL utilities for Symphony CMS.   
Created by The Workers unless otherwise stated.

@todo: move this to the wiki

## W.template-engine 

(aka: an XSL Ninja to for use with HTML Templates)

Default import of all W.template-engine utilities:

1. W.template-engine.ninja.xsl 
2. W.template-engine.helpers.xsl

To selective include W.template-engine create your own include file.

### Suggested Style Guidelines

Include an HTML file:

     <cms include="template.html" />
	 <cms include="news.story.html" />
	
Replace with information form symphony:

	<cms select="navigation" />
	<cms select="title" />


## W.template-engine.email

Email Obfuscation  
turns user@domain.com into domain.com[at]user

@todo: include .js exa.ple




## W.data-time.xsl

* Created by Nick Dunn *
  
### Description:  
  
This is a date formatting utility. The named template "format-date" takes 2 parameters:  

1. date - [required] takes an ISO date (2005-12-01)  
2. format - [optional] takes a format string.  

### Format options:  
  
Y - year in 4 digits e.g. 1981, 1992, 2008  
y - year in 2 digits e.g. 81, 92, 08  
M - month as a full word e.g. January, March, September  
m - month in 3 letters e.g. Jan, Mar, Sep  
N - month in digits without leading zero  
n - month in digits with leading zero  
D - day with suffix and no leading zero e.g. 1st, 23rd  
d - day in digits with leading zero e.g. 01, 09, 12, 25  
x - day in digits with no leading zero e.g. 1, 9, 12, 25  
T - time in 24-hours e.g. 18:30  
t - time in 12-hours e.g. 6:30pm  
W - weekday as a full word e.g. Monday, Tuesday  
w - weekday in 3 letters e.g. Mon, Tue, Wed  

### Examples:  
  
M       => January  
d M     => 21 September  
m D, y  => Sep 21st, 81  
n-d-y   => 09-21-81  
d/n/y   => 21/09/81  
d/n/y t => 21/09/81 6:30pm  


## W.jit-image

From: [http://github.com/tmslnz/Magical-JIT-Resizer](http://github.com/tmslnz/Magical-JIT-Resizer)

Magical image resizer and <img/> tag generator, with fallback to [DummyImage generator][dummy].

[dummy]: https://github.com/robphilp/Symphony-2-Dummyimage

### Required params:
- `upload`: takes an xPath of Symphony's `<upload>` node
- if `upload` is omitted, it will generate a dummy image with the specified dimensions (`w` and `h` dimensions required in that case)

### Optional params:
- `'w'`: the requested width
- `'h'`: the requested height (both can be set)
- (standard `<img/>` attributes. `class`, `id`, `title`, `name`, `longdesc`, etc.)
- `value-only`: if set to either `'w'` or `'h'` will return only the result number not the whole `<img/>` tag.
- `mode`: `'normal'`, `'fit'`, `'max'`
- normal: none, `'w'`, `'h'`, `'w'` and `'h'`
- fit: `'w'` and `'h'`
- max: `'w'`, `'h'`, `'w'` and `'h'`
In normal mode the scaler takes whatever `h` and/or `w` is passed and scales the specified dimensions to whatever value was passed.  
If either `w` or `h` are passed, then the missing value is derived proportionally. If both values are passed then both are applied, effectively constraining the image to a specified size.  
In fit mode both h and w are required. The two values define the area within which the scaler has to proportionally fit the image.            
- `JITmode`: JIT modes (see docs on Symphony-CMS.com) 
- `JITcenter`: JIT center `1` to `9`
- `JITexternal`: `0` or `url` (without the `http://` part)

### Examples

#### Output original size

_No explicit size = original size_

	<xsl:call-template name="img">  
    	<xsl:with-param name="upload" select="$upload"/>  
	</xsl:call-template>

#### Force a specific size

_Specifying both dimensions, using no explicit mode, will output exactly what you asked for._

	<xsl:call-template name="img">  
		<xsl:with-param name="upload" select="$upload"/>  
		<xsl:with-param name="w" select="300"/>  
		<xsl:with-param name="h" select="200"/>  
	</xsl:call-template>

#### Scale proportionally based on width or height constraint

_To trigger this simply omit one dimension_

	<xsl:call-template name="img">  
		<xsl:with-param name="upload" select="$upload"/>  
		<xsl:with-param name="w" select="300"/>  
	</xsl:call-template>

#### Scale proportionally within a set bounding box (square or not)

_This is useful if you want to proportinally constrain your images to set dimensions._

	<xsl:call-template name="img">  
		<xsl:with-param name="upload" select="$upload"/>  
		<xsl:with-param name="mode" select="'fit'"/>  
		<xsl:with-param name="w" select="400"/>  
		<xsl:with-param name="h" select="400"/>  
	</xsl:call-template>

#### Set a grid and trim exceeding values from automatically calculated dimensions

_Makes sure that any automatically calculated value will be a (nearest neighbor) multiple of the grid you set._

	<xsl:call-template name="img">  
		<xsl:with-param name="upload" select="$upload"/>  
		<xsl:with-param name="mode" select="'trim'"/>  
		<xsl:with-param name="gridsize" select="50"/><!-/- This will set a 50px grid -/->
		<xsl:with-param name="w" select="400"/>  
		<!-/- i.e.: 'h' will be trimmed to the nearest neighbor grid -/->
	</xsl:call-template>

#### Set a grid and use multipliers

_Straighforward. W and H values are used as multiplier in this case._

	<xsl:call-template name="img">  
	    <xsl:with-param name="upload" select="$upload"/>  
	    <xsl:with-param name="gridsize" select="50"/><!-/- This will set a 50px grid -/->
	    <xsl:with-param name="w" select="3"/> <!-/- When in 'pure' grid mode, these values act as multipliers -/->
	    <xsl:with-param name="h" select="2"/>  
	</xsl:call-template>

#### Use and external image

_w and h needed as we don't have XML metadata on the fetched image_

	<xsl:call-template name="img">   
	    <xsl:with-param name="upload" select="'images.apple.com/home/images/mbp_hero20110224.png'"/>  
	    <xsl:with-param name="w" select="400"/>  
	    <xsl:with-param name="h" select="200"/>  
	</xsl:call-template>

#### Generate a dummy image (needs Dummy Image extension)

_Note that we are not passing any upload param in this case._

	<xsl:call-template name="img">
	    <xsl:with-param name="w" select="200"/>   
	    <xsl:with-param name="h" select="150"/>  
	</xsl:call-template>

#### Use it as a MATCHED template

	<xsl:apply-templates match="upload">  
	    <xsl:with-param name="w" select="300"/>  
	</xsl:apply-templates>

#### Add attributes (works in all modes)

	<xsl:call-template name="img">  
	    <xsl:with-param name="upload" select="$upload"/>  
	    <xsl:with-param name="w" select="500"/>  
	    <xsl:with-param name="class" select="'someclass anotherclass'"/>  
	    <xsl:with-param name="id" select="'myID'"/>  
	    <xsl:with-param name="title" select="'Herr Title'"/>  
	</xsl:call-template>

### Notes

When this template is used as a match rather than called by name, the DummyImage mode is effectively inaccessible.  
Besides, it wouldn't make sense since you if have a match, then you have an upload.