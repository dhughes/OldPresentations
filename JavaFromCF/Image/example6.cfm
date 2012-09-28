
<!---

Example 6:

The following example draws a company logo into the upper left corner of an image. 
The logo has an alpha channel which is used to composite the two images so that the
image shows through the transparent portions of the logo.  Additionally, the logo is
made to be slightly transparent.

--->

<!--- create the object --->
<cfset myImage = CreateObject("Component", "Image") />

<!--- open a new image --->
<cfset myImage.readImage(ExpandPath("collin.jpg")) />

<!--- set the transparency used when drawing into the image --->
<cfset myImage.setTransparency(50) />

<!--- draw an image into the image --->
<cfset myImage.drawImage(ExpandPath("logo.png"), 5, 5) />

<!--- output the new image --->
<cfset myImage.writeImage(ExpandPath("collin-logo.jpg"), "jpg") />

<!--- output both images --->
<p>
<b>collin.jpg:</b><br>
<img src="collin.jpg">
</p>

<p>
<b>collin-logo.jpg:</b><br>
<img src="collin-logo.jpg">
</p>
