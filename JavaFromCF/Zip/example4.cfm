<!---

Example 4:

Demonstrates extracting the contents of our zip file into another directory.

--->


<!--- instantiate the zip component and creates a new zip archive --->
<cfset myZip = CreateObject("Component", "Zip").init(ExpandPath("example1.zip")) />

<!--- create the extract directory --->
<cfset directory = GetDirectoryFromPath(GetCurrentTemplatePath()) & "extract" />
<cfif NOT DirectoryExists(directory)>
	<cfdirectory action="create"
		directory="#directory#" />
</cfif>

<!--- loop over the query of file contents --->
<cfset contents = myZip.getZipContents() />
<cfloop query="contents">
	<!--- extract the file --->
	<cfset myZip.extractFile(name, "#directory#\#name#") />
</cfloop>

<h1>Contents Extracted</h1>