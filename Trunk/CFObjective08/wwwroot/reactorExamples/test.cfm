<cfset ReactorFactory = CreateObject("Component", "Reactor.ReactorFactory").init(expandPath("config/Reactor.xml"))  />


<cfset Customergw = ReactorFactory.createGateway("Customer") />

<cfset query = Customergw.createQuery() />
<cfset query.getOrder().setAsc("Customer", "firstName") />

<cfdump var="#Customergw.getByQuery(query)#" />