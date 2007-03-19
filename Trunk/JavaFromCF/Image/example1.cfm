
<!---

Example 1:

Demonstrates instantiating the Image component converting from a JPEG file to a PNG file.

--->

<!--- create the object --->
<cfset myImage = CreateObject("Component", "Image") />

<!--- read the source JPEG image --->
<cfset myImage.readImage(ExpandPath("chicago.jpg")) />

<!--- output the image in PNG format --->
<cfset myImage.writeImage(ExpandPath("chicago.png"), "png") />

<!--- output both images --->
<p>
<b>chicago.jpg:</b><br>
<img src="chicago.jpg">
</p>

<p>
<b>chicago.png:</b><br>
<img src="chicago.png">
</p>
