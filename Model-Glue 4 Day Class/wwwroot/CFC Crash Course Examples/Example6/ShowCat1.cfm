
<!--- create a cat and call it's constructor --->
<cfset myCat = CreateObject("Component", "Cat").init("Grey", "Sam", 18) />

<!--- output the cat's description --->
<cfoutput>
	#myCat.describe()#
</cfoutput>