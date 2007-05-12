
<!--- Instantiate the HelloWorld component --->
<cfobject
	component="HelloWorld"
	name="helloWorld" />

<!--- call the sayHello method on the
helloWorld object and pass two arguments --->
<cfoutput>
<p>#helloWorld.sayHello("Powered By Detroit", 5)#</p>
</cfoutput>
