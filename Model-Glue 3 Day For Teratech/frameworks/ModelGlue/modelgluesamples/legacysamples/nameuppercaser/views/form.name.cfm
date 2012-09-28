<cfform action="index.cfm?event=UpperCaseTheName">
<cfoutput>
<input type="text" name="name" value="#viewState.getValue("name")#">
<input type="submit" value="go">
</cfoutput>
</cfform>
