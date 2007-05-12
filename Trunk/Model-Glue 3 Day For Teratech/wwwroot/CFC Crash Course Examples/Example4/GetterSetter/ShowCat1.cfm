
<!--- create a cat --->
<cfset myCat = CreateObject("Component", "Cat") />

<!--- set the cat properties --->
<cfset myCat.setColor("Black") />
<cfset myCat.setWeight(10) />
<cfset myCat.setName("Mia") />

<!--- output the cat's description --->
<cfoutput>
	#myCat.describe()#
</cfoutput>