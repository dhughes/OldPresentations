<cfcomponent displayname="AbstractIOCAdapter.cfc" hint="I am a marker for Model-Glue Ioc adapters.">

<cffunction name="init" returntype="ModelGlue.unity.ioc.AbstractIOCAdapter" output="false" access="public">
	<cfreturn this />
</cffunction>

<cffunction name="setFramework" returntype="void" output="false" access="public">
	<cfargument name="framework" type="ModelGlue.unity.framework.ModelGlue" required="true" />
</cffunction>

<cffunction name="getBean" returntype="any" output="false" access="public">
	<cfargument name="name" type="string" required="true" />
</cffunction>

</cfcomponent>