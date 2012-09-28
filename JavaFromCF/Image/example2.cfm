
<!---

Example 2:

The following source code demonstrates how to create colors, set the
background color of the image, create a new image, and draw filled
and stroked shapes and images into the image.

--->

<!--- create the object --->
<cfset myImage = CreateObject("Component", "Image") />

<!--- create some colors --->
<cfset red = myImage.getColorByName("red") />
<cfset yellow = myImage.getColorByName("yellow") />
<cfset green = myImage.getColorByName("green") />
<cfset blue = myImage.getColorByName("blue") />
<cfset orange = myImage.getColorByName("orange") />
<cfset white = myImage.getColorByName("white") />

<!--- set the background color --->
<cfset myImage.setBackgroundColor(red) />

<!--- create a new image --->
<cfset myImage.createImage(400, 400) />

<!--- draw a few shapes into the new image --->

<!--- draw a square --->
<cfset myImage.setFill(yellow) />
<cfset myImage.setStroke(2, green) />
<cfset myImage.drawRectangle(10, 10, 180, 180) />

<!--- draw a circle --->
<cfset myImage.setFill(green) />
<cfset myImage.setStroke(4, blue) />
<cfset myImage.drawOval(210, 10, 180, 180) />

<!--- draw two arcs --->
<cfset myImage.setStroke(2) />
<cfset myImage.setFill(blue) />
<cfset myImage.drawArc(10, 210, 180, 180, 0, 270) />
<cfset myImage.setFill(orange) />
<cfset myImage.drawArc(10, 210, 180, 180, 270, 90) />

<!--- draw another image into this image --->
<cfset myImage.drawImage(ExpandPath("chicago.jpg"), 210, 210, 180, 180)/>

<!--- output the image in PNG format --->
<cfset myImage.writeImage(ExpandPath("newImage.png"), "png") />

<!--- the new image --->
<p>
<b>newImage.png:</b><br>
<img src="newImage.png">
</p>
