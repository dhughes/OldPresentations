

<!--- create a cat and call it's constructor --->
<cfset myCat = CreateObject("Component", "Cat").init("Grey", "Sam", 18) />

<!--- dump the cat --->
<cfdump var="#GetMetaData(myCat)#" />