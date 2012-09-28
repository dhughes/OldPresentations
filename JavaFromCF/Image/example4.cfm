
<!---

Example 4:

The following source code demonstrates how to open an image and get its width and height.

--->

<!--- create the object --->
<cfset myImage = CreateObject("Component", "Image") />

<!--- open the image to inspect --->
<cfset myImage.readImage(ExpandPath("vw.jpg")) />

<!--- get the width --->
<cfset width = myImage.getWidth() />
<!--- get the height --->
<cfset height = myImage.getHeight() />

<!--- output the image size --->
<p>
<b>vw.jpg:</b><br>
<img src="vw.jpg"><br>
<cfoutput>
	Width: #width#<br>
	Height: #height#
</cfoutput>
</p>
