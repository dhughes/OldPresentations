<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="EventBeanCommand" 
	extends="cfcunit.machii.framework.EventCommand"
	output="false"
	hint="An EventCommand for creating and populating a bean in the current event.">

	<!--- PROPERTIES --->
	<cfset variables.beanName = "" />
	<cfset variables.beanType = "" />
	<cfset variables.beanFields = "" />
	<cfset variables.beanUtil = "" />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="beanName" type="string" required="true" />
		<cfargument name="beanType" type="string" required="true" />
		<cfargument name="beanFields" type="string" required="true" />
		
		<cfset setBeanName(arguments.beanName) />
		<cfset setBeanType(arguments.beanType) />
		<cfset setBeanFields(arguments.beanFields) />
		
		<cfset setBeanUtil( CreateObject('component','cfcunit.machii.util.BeanUtil') ) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="execute" access="public" returntype="boolean">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		
		<cfset var bean = "" />
		
		<cfif isBeanFieldsDefined()>
			<cfset bean = getBeanUtil().createBean(getBeanType()) />
			<cfset getBeanUtil().setBeanFields(bean, getBeanFields(), arguments.event.getArgs()) />
		<cfelse>
			<cfset bean = getBeanUtil().createBean(getBeanType(), arguments.event.getArgs()) />
		</cfif>
		
		<cfset arguments.event.setArg(getBeanName(), bean, getBeanType()) />
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="setBeanName" access="private" returntype="void" output="false">
		<cfargument name="beanName" type="string" required="true" />
		<cfset variables.beanName = arguments.beanName />
	</cffunction>
	<cffunction name="getBeanName" access="private" returntype="string" output="false">
		<cfreturn variables.beanName />
	</cffunction>
	
	<cffunction name="setBeanType" access="private" returntype="void" output="false">
		<cfargument name="beanType" type="string" required="true" />
		<cfset variables.beanType = arguments.beanType />
	</cffunction>
	<cffunction name="getBeanType" access="private" returntype="string" output="false">
		<cfreturn variables.beanType />
	</cffunction>
	
	<cffunction name="setBeanFields" access="private" returntype="void" output="false">
		<cfargument name="beanFields" type="string" required="true" />
		<cfset variables.beanFields = arguments.beanFields />
	</cffunction>
	<cffunction name="getBeanFields" access="private" returntype="string" output="false">
		<cfreturn variables.beanFields />
	</cffunction>
	<cffunction name="isBeanFieldsDefined" access="public" returntype="boolean" output="false">
		<cfreturn NOT getBeanFields() EQ '' />
	</cffunction>
	
	<!--- PROTECTED FUNCTIONS --->
	<cffunction name="setBeanUtil" access="private" returntype="void" output="false">
		<cfargument name="beanUtil" type="cfcunit.machii.util.BeanUtil" required="true" />
		<cfset variables.beanUtil = arguments.beanUtil />
	</cffunction>
	<cffunction name="getBeanUtil" access="private" returntype="cfcunit.machii.util.BeanUtil" output="false">
		<cfreturn variables.beanUtil />
	</cffunction>

</cfcomponent>