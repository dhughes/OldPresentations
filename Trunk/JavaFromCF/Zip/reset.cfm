<!---

This file resets all of the examples.  

--->

<!--- delete example1.zip --->
<cfif FileExists(ExpandPath("example1.zip"))>
	<cffile action="delete"
		file="#ExpandPath("example1.zip")#" />
</cfif>
	
<!--- delete the extract folder --->
<cfset directory = "#GetDirectoryFromPath(GetCurrentTemplatePath())#extract" />
<cfif DirectoryExists(directory)>
	<!--- delete all the files in this directory --->
	<cfdirectory action="list"
		directory="#directory#"
		name="files" />
	
	<cfoutput query="files">
		<cffile action="delete"
			file="#directory#\#files.name#" />
	</cfoutput>
	
	<!--- delete the directory --->
	<cfdirectory action="delete"
		directory="#GetDirectoryFromPath(GetCurrentTemplatePath())#extract" />
</cfif>
	
<h1>Examples Reset</h1>