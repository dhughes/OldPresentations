
<!--- create a cat --->
<cfset myCat = CreateObject("Component", "Cat") />

<!--- output the cat's description --->
<cfoutput>
	#myCat.describe()#
</cfoutput>