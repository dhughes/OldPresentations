
<!--- create a cat --->
<cfset myCat = CreateObject("Component", "Cat") />

<!--- set the cat properties --->
<cfset myCat.color = "Black" />
<cfset myCat.weight = "10 pounds" />
<cfset myCat.name = "Mia" />

<!--- output the cat's description --->
<cfoutput>
	#myCat.describe()#
</cfoutput>