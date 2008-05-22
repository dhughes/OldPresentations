<!--- create a bean that holds datasource configuration information --->
<cfset Datasource = CreateObject("Component", "Datasource").init("Fortune") />

<!--- create the Dao --->
<cfset Dao = CreateObject("Component", "FortuneDao").init(Datasource) />

<!--- create a bean (which will be our transfer object) --->
<cfset Fortune = CreateObject("Component", "FortuneBean") />

<!--- read a random fortune --->
<cfset Fortune.setFortuneId(42) />
<cfset Dao.read(Fortune) />
		
<cfdump var="#Fortune.getFortune()#" />