
<!--- instantiate the example component --->
<cfset example = CreateObject("Component", "example") />

<cfoutput>
	#example.foo()#
</cfoutput>