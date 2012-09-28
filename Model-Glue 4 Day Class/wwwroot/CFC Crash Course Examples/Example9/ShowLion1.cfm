
<!--- create a lion and call it's constructor --->
<cfset myLion = CreateObject("Component", "Lion").init("Orange", "Fred", 300) />

<cfoutput>
	<!--- describe the lion --->
	#myLion.describe()#

	<!--- make the lion roar a few times--->
	<cfloop from="10" to="35" index="x" step="5">
		#myLion.roar(x)#
	</cfloop>
</cfoutput>
