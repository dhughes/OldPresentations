<cfcomponent displayname="ChiliBeansLoader" output="false">
	
<cffunction name="init" returntype="ChiliBeansLoader" output="false">
	<cfreturn this />
</cffunction>

<cffunction name="load" returntype="ModelGlue.Bean.BeanFactory" output="false">
	<cfargument name="beanMappings" type="string" required="true" />
	<cfreturn createObject("component", "ModelGlue.Bean.BeanFactory").init(arguments.beanMappings) />
</cffunction>

</cfcomponent>