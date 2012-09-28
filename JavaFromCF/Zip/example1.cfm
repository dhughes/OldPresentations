
<!---

Example 1:

Demonstrates instantiating the zip component and adds a file into the zip.

--->

<!--- instantiate the zip component and creates a new zip archive --->
<cfset myZip = CreateObject("Component", "Zip").init(ExpandPath("example1.zip")) />

<!--- create an array of files to zip --->
<cfset filesToZip = ArrayNew(1) />
<cfset ArrayAppend(filesToZip, ExpandPath("collin.jpg")) />
<cfset ArrayAppend(filesToZip, ExpandPath("chicago.jpg")) />
<cfset ArrayAppend(filesToZip, ExpandPath("vw.jpg")) />
<cfset ArrayAppend(filesToZip, ExpandPath("bridge.jpg")) />

<!--- add a file into the zip archive --->
<cfset myZip.addFiles(filesToZip) />

<h1>Zip File Created</h1>