
<!--- Instantiate the HelloWorld component --->
<cfobject
	component="HelloWorld"
	name="helloWorld" />

<!--- call the sayHello method on the
helloWorld object and pass two arguments --->
<cfoutput>
<p>#helloWorld.sayHello("Scotch On The Rocks", 5)#</p>
</cfoutput>
