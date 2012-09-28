<cfcomponent displayname="AbstractORMAdapter.cfc" hint="I am a marker for Model-Glue ORM adapters.">

<cffunction name="init" returntype="ModelGlue.unity.orm.AbstractORMAdapter" output="false" access="public">
	<cfreturn this />
</cffunction>

<cffunction name="getObjectMetadata" returntype="struct" output="false" access="public">
	<cfargument name="table" type="string" required="true" />
	<cfreturn createObject("component", "ModelGlue.unity.orm.ObjectMetadata").init() />
</cffunction>

<cffunction name="getCriteriaProperties" returntype="string" output="false" access="public">
	<cfreturn "" />
</cffunction>

<cffunction name="list" returntype="any" output="false" access="public">
	<cfargument name="table" type="string" required="true" />
	<cfargument name="criteria" type="struct" required="false" />
	<cfargument name="orderColumn" type="string" required="false" />
	<cfargument name="orderAscending" type="boolean" required="false" default="true" />
	<cfargument name="gatewayMethod" type="string" required="false" />
	<cfargument name="gatewayBean" type="string" required="false" />
</cffunction>

<cffunction name="new" returntype="any" output="false" access="public">
	<cfargument name="table" type="string" required="true" />
</cffunction>

<cffunction name="read" returntype="any" output="false" access="public">
	<cfargument name="table" type="string" required="true" />
	<cfargument name="primaryKeys" type="struct" required="true" />
</cffunction>

<cffunction name="validate" returntype="ModelGlue.Util.ValidationErrorCollection" output="false" access="public">
	<cfargument name="table" type="string" required="true" />
	<cfargument name="record" type="string" required="true" />
</cffunction>

<cffunction name="assemble" returntype="void" output="false" access="public">
	<cfargument name="eventContext" type="ModelGlue.unity.eventrequest.EventContext" required="true" />
	<cfargument name="target" type="any" required="true" />
</cffunction>

<cffunction name="commit" returntype="any" output="false" access="public">
	<cfargument name="table" type="string" required="true" />
	<cfargument name="record" type="string" required="true" />
</cffunction>

<cffunction name="delete" returntype="any" output="false" access="public">
	<cfargument name="table" type="string" required="true" />
	<cfargument name="primaryKeys" type="struct" required="true" />
</cffunction>

</cfcomponent>