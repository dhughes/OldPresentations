
<!---

Example 3:

The following source code demonstrates how to resize an image to a specific width
and height using the scalePixels() method.  The Image Component provides several
additional methods for resizing images.  

--->

<!--- create the object --->
<cfset myImage = CreateObject("Component", "Image") />

<!--- open the image to resize --->
<cfset myImage.readImage(ExpandPath("bridge.jpg")) />

<!--- resize the image to a specific width and height --->
<cfset myImage.scalePixels(100, 75) />

<!--- output the image in JPG format --->
<cfset myImage.writeImage(ExpandPath("bridge-small.jpg"), "jpg") />

<!--- the new images --->
<p>
<b>bridge.jpg:</b><br>
<img src="bridge.jpg">
</p>

<p>
<b>bridge-small.jpg:</b><br>
<img src="bridge-small.jpg">
</p>
