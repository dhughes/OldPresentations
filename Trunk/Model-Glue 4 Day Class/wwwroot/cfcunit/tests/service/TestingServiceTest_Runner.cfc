<cfcomponent name="TestingServiceTest_Runner" extends="org.cfcunit.service.TestRunner" output="false">

	<!------------------------------------------------------------------------------------>


	<cffunction name="init" returntype="TestingServiceTest_Runner" access="public" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="false" hint=""/>
		<cfargument name="parameters" type="org.cfcunit.service.TestParameters" required="true"/>
		
		<cfset var params = "">
		
		<cfset super.init(arguments.listener)>
		
		<cfset params = arguments.parameters.getParameters()>

		<cfif structKeyExists(params, "exceptionToThrow")>
			<cfset variables.exceptionToThrow = params.exceptionToThrow>
		</cfif>

		<cfreturn this/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>


	<cffunction name="execute" returntype="void" access="public" output="true">
		<cfargument name="testCaseClass" type="string" required="true"/>
		
		<cfif structKeyExists(variables, "exceptionToThrow")>
			<cfthrow type="#variables.exceptionToThrow#"/>
		</cfif>
		
		<cfset super.execute(arguments.testCaseClass)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>