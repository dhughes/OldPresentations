
<!--- setup the config bean --->
<cfset ColdSpring = CreateObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
<cfset ColdSpring.loadBeans("ColdSpring.xml") />
	
<!--- create the reactor factory --->
<cfset Reactor = ColdSpring.getBean("ReactorFactory") />

<!--- create a gateway --->
<cfset CustomerGateway = Reactor.createGateway("Customer") />

<cfset customers = CustomerGateway.getAll() />

<p>
All Customers:
<cfdump var="#customers#" />
</p>

<cfset customers = CustomerGateway.getByFields(lastName="Hughes") />

<p>
All Customers with the lastname Hughes:
<cfdump var="#customers#" />
</p>