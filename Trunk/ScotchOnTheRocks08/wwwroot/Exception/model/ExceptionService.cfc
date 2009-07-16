<cfcomponent name="ExceptionService" hint="I am a service for handling exception">

	<cfset variables.Email = "" />
	<cfset variables.debug = "" />
	
	<cffunction name="handleException" access="public" hint="I handle an exception" output="false" returntype="void">
		<cfargument name="exception" hint="I am the exception information" required="yes" type="struct" />
		<cfset var Email = getBeanFactory().getBean("ExceptionEmail") />
		<cfset var data = StructNew() />
		<cfset data.exception = "" />
		
		<cfsavecontent variable="data.exception">
			<cfdump var="#exception#" />
		</cfsavecontent>
		
		<cfset Email.setData(data) />
		<cfset Email.send() />		 
	</cffunction>
	
	<cffunction name="getDebug" access="public" hint="Getter for debug" output="false" returnType="boolean">
		<cfreturn variables.debug />
	</cffunction>

	<cffunction name="setDebug" access="public" hint="Setter for debug" output="false" returnType="void">
		<cfargument name="debug" hint="I indicate if we're in debug mode" required="yes" type="boolean" />
		<cfset variables.debug = arguments.debug />
	</cffunction>
	
	<!--- BeanFactory --->
	<cffunction name="setBeanFactory" access="public" output="false" returntype="void" hint="I set a BeanFactory (Spring-interfaced IoC container) to inject into all created objects)." >
		<cfargument name="beanFactory" type="coldspring.beans.beanFactory" _type="coldspring.beans.beanFactory" required="true" />
		<cfset variables.BeanFactory = arguments.beanFactory />
	</cffunction>
	<cffunction name="getBeanFactory" access="private" output="false" returntype="any" _returntype="any">
		<cfreturn variables.BeanFactory />
	</cffunction>

</cfcomponent>	