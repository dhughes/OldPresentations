
<!--- Invoke the sayHello method
on the HelloWorld component --->
<cfinvoke component="HelloWorld"
	method="sayHello"
	returnvariable="results">
	<cfinvokeargument name="thing" value="Scotch on the Rocks" />
	<cfinvokeargument name="times" value="4" />

</cfinvoke>

<!--- Output the results --->
<cfoutput>
	<p>#results#</p>
</cfoutput>