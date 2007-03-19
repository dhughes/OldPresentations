<!---

This file resets all of the examples.  

--->

<!--- delete files --->
<cfif FileExists(ExpandPath("chicago.png"))>
	<cffile action="delete"
		file="#ExpandPath("chicago.png")#" />
</cfif>

<cfif FileExists(ExpandPath("newImage.png"))>
	<cffile action="delete"
		file="#ExpandPath("newImage.png")#" />
</cfif>

<cfif FileExists(ExpandPath("bridge-small.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("bridge-small.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("catAndCup-text.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("catAndCup-text.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("collin-logo.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("collin-logo.jpg")#" />
</cfif>


<h1>Examples Reset</h1>