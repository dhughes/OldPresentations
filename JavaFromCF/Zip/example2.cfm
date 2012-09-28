<!---

Example 2:

Demonstrates listing the contents of the zip file we just created.

--->

<!--- instantiate the zip component and creates a new zip archive --->
<cfset myZip = CreateObject("Component", "Zip").init(ExpandPath("example1.zip")) />

<!--- dump the listing of file contents --->
<cfdump var="#myZip.getZipContents()#" />

<h1>Contents Listed</h1>