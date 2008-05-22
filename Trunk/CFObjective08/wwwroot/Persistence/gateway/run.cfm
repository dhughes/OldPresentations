<!--- create a bean that holds datasource configuration information --->
<cfset Datasource = CreateObject("Component", "Datasource").init("Fortune") />

<!--- create a gateway --->
<cfset FortuneGateway = CreateObject("Component", "FortuneGateway").init(Datasource) />

<!--- get data --->
<cfset data = FortuneGateway.getFortunes(5, 'dog') />

<!--- dump the data --->
<cfdump var="#data#" />