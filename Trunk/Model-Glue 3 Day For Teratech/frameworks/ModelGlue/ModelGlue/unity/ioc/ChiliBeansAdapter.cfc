<cfcomponent displayname="ChiliBeansAdapter" hint="I let Model-Glue use ChiliBeans." extends="ModelGlue.unity.ioc.AbstractIOCAdapter">

<cffunction name="init" returntype="ModelGlue.unity.ioc.AbstractIOCAdapter" output="false" access="public">
	<cfargument name="beanMappings" type="string" required="true" />
	<cfset variables._beanFactory = createObject("component", "ModelGlue.unity.ioc.chilibeans.BeanFactory").init(arguments.beanMappings) />
	<cfreturn this />
</cffunction>

<cffunction name="setFramework" returntype="void" output="false" access="public">
	<cfargument name="framework" type="ModelGlue.unity.framework.ModelGlue" required="true" />
	<cfset variables._framework = arguments.framework />
</cffunction>

<cffunction name="getBean" returntype="any" output="false" access="public">
	<cfargument name="name" type="string" required="true" />
	<cfreturn variables._beanFactory.createBean(arguments.name) />
</cffunction>

<cffunction name="setBeanMappings" access="public" returnType="void" output="false">
  <cfargument name="beanMappings" type="string" required="true" hint="Comma-delimited list of mappings holding bean xml files.  I search through the mappings in the order given.">
  <cfset variables._beanFactory.setBeanStore(arguments.beanMappings) />
</cffunction>

</cfcomponent>