<cfcomponent displayname="ColdSpringAdapter" hint="I let Model-Glue use ColdSpring." extends="ModelGlue.unity.ioc.AbstractIOCAdapter">

<cffunction name="init" returntype="ModelGlue.unity.ioc.AbstractIOCAdapter" output="false" access="public">
	<cfset variables._beanFactory = "" />
	<cfreturn this />
</cffunction>

<cffunction name="setFramework" returntype="void" output="false" access="public">
	<cfargument name="framework" type="ModelGlue.unity.framework.ModelGlue" required="true" />
	<cfset variables._framework = arguments.framework />
</cffunction>

<cffunction name="getBeanFactory" returntype="any" output="false" access="public">
	<cfreturn variables._beanFactory />
</cffunction>

<cffunction name="loadBeans" returntype="void" output="false" access="public">
	<cfargument name="beanMappings" type="string" required="true">
	
	<cfset var i = "" />

	<cfif not isObject(variables._beanFactory)>
		<cfset variables._beanFactory = variables._framework.getBeanFactory() />
	</cfif>
	
	<cfloop list="#arguments.beanMappings#" index="i">
		<cfset variables._beanFactory.loadBeans(expandPath(i)) />
	</cfloop>
</cffunction>

<cffunction name="getBean" returntype="any" output="false" access="public">
	<cfargument name="name" type="string" required="true" />
	
	<cfif not isObject(variables._beanFactory)>
		<cfset variables._beanFactory = variables._framework.getBeanFactory() />
	</cfif>
	
	<cfreturn variables._beanFactory.getBean(arguments.name) />
</cffunction>

</cfcomponent>