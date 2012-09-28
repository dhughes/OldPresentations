<cfcomponent displayname="Controller" output="false" hint="I am a sample model-glue controller." extends="ModelGlue.Core.Controller">

<!--- Constructor --->
<cffunction name="Init" access="Public" returnType="Controller" output="false" hint="I build a new SampleController">
  <cfargument name="ModelGlue" required="true" type="ModelGlue.ModelGlue" />
  <cfargument name="InstanceName" required="true" type="string" />
  <cfset super.Init(arguments.ModelGlue) />

	<!--- Controllers are in the application scope:  Put any application startup code here. --->
  <cfreturn this />
</cffunction>

<!--- Functions specified by <message-listener> tags --->
<cffunction name="OnRequestStart" access="Public" returntype="void" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">

  <cfset var sessionDump = "" />

  <cfset session.parentAppMessage = "Hello, I'm a value from the parent application!" />

  <cfsavecontent variable="sessionDump"><cfdump var="#session#" label="Session Dump From Parent App"></cfsavecontent>

  <cfset arguments.event.setValue("sessionDump", sessionDump) />
</cffunction>

<cffunction name="OnRequestEnd" access="Public" returntype="void" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">
</cffunction>

</cfcomponent>

