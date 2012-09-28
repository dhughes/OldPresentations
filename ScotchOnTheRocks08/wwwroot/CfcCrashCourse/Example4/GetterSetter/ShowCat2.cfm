
<!--- create a cat --->
<cfset myCat = CreateObject("Component", "Cat") />

<!--- set the cat properties --->
<!--- Throws errors!!! --->
<cfset myCat.setColor("Grey") />
<cfset myCat.setWeight(40) />
<cfset myCat.setName("Sam") />

<!--- output the cat's description --->
<cfoutput>
	#myCat.describe()#
</cfoutput>