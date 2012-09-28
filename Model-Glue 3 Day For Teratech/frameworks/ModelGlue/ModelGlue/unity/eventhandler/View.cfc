<cfcomponent displayname="View" output="false" hint="I'm metadata information about an event's views.">
  <cffunction name="Init" returnType="ModelGlue.unity.eventhandler.View" access="public" output="false" hint="I build a new View.">
    <cfset variables.name = "" />
    <cfset variables.template = "" />
    <cfset variables.values = structNew() />
    <cfset variables.append = false />
    <cfreturn this />
  </cffunction>

  <cffunction name="toStruct" access="public" returntype="struct" output="false">
		<cfset var result = structNew() />
		<cfset result.name = variables.name />
		<cfset result.template = variables.template />
		<cfset result.values = variables.values />
		<cfset result.append = variables.append />
		
		<cfreturn result />
	</cffunction>

  <cffunction name="SetName" access="public" returntype="void" output="false" hint="I set the view's name.">
    <cfargument name="name" required="true" type="string" hint="I am the name of the view.">
    <cfset variables.name = arguments.name />
  </cffunction>
  
  <cffunction name="GetName" access="public" returntype="string" output="false" hint="I get the view's name.">
    <cfreturn variables.name />
  </cffunction>

  <cffunction name="AddValue" access="public" returntype="void" output="false" hint="I add a state value to the view.">
    <cfargument name="name" required="true" type="string" hint="I am the name of the state entry.">
    <cfargument name="value" required="true" type="string" hint="I am the value of the state entry.">
    <cfargument name="overwrite" required="true" type="boolean" hint="If I am true, this value overwrites existing values in the viewstate.">
    <cfset variables.values[arguments.name] = structNew() />
    <cfset variables.values[arguments.name].value = arguments.value />
    <cfset variables.values[arguments.name].overwrite = arguments.overwrite />
  </cffunction>
  
  <cffunction name="GetValues" access="public" returntype="struct" output="false" hint="I get the view's additional state values.">
    <cfreturn variables.values />
  </cffunction>

  <cffunction name="SetTemplate" access="public" returntype="void" output="false" hint="I set the view's Template.">
    <cfargument name="Template" required="true" type="string" hint="I am the template of the view.">
    <cfset variables.Template = arguments.Template />
  </cffunction>
  
  <cffunction name="GetTemplate" access="public" returntype="string" output="false" hint="I get the view's Template.">
    <cfreturn variables.Template />
  </cffunction>

  <cffunction name="SetAppend" access="public" returntype="void" output="false" hint="I set the view's Append.">
    <cfargument name="Append" required="true" type="string" hint="Does this view get appended to another of the same name?">
    <cfset variables.Append = arguments.Append />
  </cffunction>
  
  <cffunction name="GetAppend" access="public" returntype="string" output="false" hint="I get the view's Append.">
    <cfreturn variables.Append />
  </cffunction>
</cfcomponent>