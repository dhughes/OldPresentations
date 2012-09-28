<cfcomponent name="TestingServiceTest_Service" extends="cfcunit.service.TestingService" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="createTestRunner" returntype="org.cfcunit.service.TestRunner" access="private" output="false">
		<cfargument name="listener" type="org.cfcunit.framework.TestListener" required="false"/>
		<cfargument name="runTestArguments" type="struct" required="true"/>
		
		<cfset var runnerArgs = structNew()>
		
		<cfif structKeyExists(arguments, "listener")>
			<cfset runnerArgs.listener = arguments.listener>
		</cfif>
		
		<cfif structKeyExists(arguments.runTestArguments, "parameters")>
			<cfset runnerArgs.parameters = arguments.runTestArguments.parameters>
		</cfif>
		
		<cfreturn createObject("component", "TestingServiceTest_Runner").init(argumentCollection=runnerArgs)/>
	</cffunction>


	<!------------------------------------------------------------------------------------>

</cfcomponent>