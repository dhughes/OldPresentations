
<!--- Invoke the sayHello method
on the HelloWorld component --->
<cfinvoke component="HelloWorld"
	method="sayHello"
	returnvariable="results" />

<!--- Output the results --->
<cfoutput>
	<p>#results#</p>
</cfoutput>