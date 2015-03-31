LJITColors

A Repository of routines related to dealing with colors.

Some words on the subject
https://williamaadams.wordpress.com/2015/03/31/ljitcolors-theres-a-name-for-that/

allcolors.lua - A database of various colors
**Crayola**
**Hollasch**
**Resene**
**SGI**

colorman.lua - Some routines to perform actions using the database of colors:

looking up a color name, based on the component values:

	local found = colorman.getColorByValue({255,255,255})



looking up a color by name:

	local found = getColorLikeName("cornsilk")
