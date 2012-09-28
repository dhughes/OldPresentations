<cfset myImage = CreateObject("component", "Image") />

<cfset myImage.readImage(expandPath("collin.jpg")) />

<cfoutput>
	#myImage.getSize("jpg", 50)#
</cfoutput>

<cfset myImage.writeImage(expandPath("testCollin.jpg"), "jpg", 50) />
