<!---

Example 3:

Demonstrates listing the contents of different zip file.

--->

<!--- instantiate the zip component and sets the zip file we're working with. --->
<cfset myZip = CreateObject("Component", "Zip").init(ExpandPath("Example.zip")) />

<!--- dump the listing of file contents --->
<cfdump var="#myZip.getZipContents()#" />

<h1>Contents Listed</h1>