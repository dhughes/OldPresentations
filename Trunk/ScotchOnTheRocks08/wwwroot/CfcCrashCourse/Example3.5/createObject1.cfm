<cfinvoke component="HelloWorld" method="setValue">
	<cfinvokeargument name="value" value="4" />
</cfinvoke>

<cfinvoke component="HelloWorld" method="getValue" returnvariable="result" />

<cfoutput>#result#</cfoutput>


<!--- 
<!--- Instantiate the HelloWorld component --->
<cfset helloWorld = CreateObject("Component", "HelloWorld") />

<cfset helloWorld.setValue(1000000000000) />

<cfoutput>
	#helloWorld.getValue()#
</cfoutput>
 --->
<!--- 
<!--- call the sayHello method on the
helloWorld object and pass two arguments --->
<cfoutput>
<p>#helloWorld.sayHello(times= 5, thing="Scotch On The Rocks")#</p>
</cfoutput>
 --->