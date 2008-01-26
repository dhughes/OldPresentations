
<!--- Instantiate the HelloWorld component --->
<cfset helloWorld = CreateObject("Component", "HelloWorld") />

<!--- call the sayHello method on the
helloWorld object and pass two arguments --->
<cfoutput>
<p>#helloWorld.sayHello("Training Class", 5)#</p>
</cfoutput>
