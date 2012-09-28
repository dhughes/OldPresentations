<cfset Fortune = CreateObject("Component", "Fortune").init(datasource, username, password) />

<cfdump var="#Fortune.getCategories()#" />
<cfdump var="#Fortune.getFortune(randRange(1, 10))#" />