
<!--- Invoke the sayHello method
on the HelloWorld component --->
<cfinvoke component="HelloWorld"
	method="sayHello"
	returnvariable="results">
	<!--- Pass in two arguments --->
	<cfinvokeargument name="thing" value="Powered By Detroit" />
	<cfinvokeargument name="times" value="5" />
</cfinvoke>

<!--- Output the results --->
<cfoutput>
	<p>#results#</p>
</cfoutput>