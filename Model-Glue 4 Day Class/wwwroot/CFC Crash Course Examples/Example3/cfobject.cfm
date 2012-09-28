
<!--- Instantiate the HelloWorld component --->
<cfobject
	component="HelloWorld"
	name="request.helloWorld" />

<!--- call the sayHello method on the
helloWorld object and pass two arguments --->
<cfoutput>
<p>#request.helloWorld.sayHello("Training Class", 5)#</p>
</cfoutput>
