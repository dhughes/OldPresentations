<!--- create a bean that holds datasource configuration information --->
<cfset Datasource = CreateObject("Component", "Datasource").init("Fortune") />

<!--- create the Record --->
<cfset FortuneRecord = CreateObject("Component", "FortuneRecord").init(Datasource) />

<!--- read a random fortune --->
<cfset FortuneRecord.setFortuneId(53) />
<cfset FortuneRecord.read() />

<cfdump var="#FortuneRecord.getFortune()#" />