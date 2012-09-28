
<!--- create a cat --->
<cfset myCat = CreateObject("Component", "Cat") />

<!--- set the cat properties --->
<!--- Does not throw errors!!! --->
<cfset myCat.color = "Black" />
<cfset myCat.weight = "10 gallons" />
<cfset myCat.name = "Mia" />

<!--- output the cat's description --->
<cfoutput>
	#myCat.describe()#
</cfoutput>