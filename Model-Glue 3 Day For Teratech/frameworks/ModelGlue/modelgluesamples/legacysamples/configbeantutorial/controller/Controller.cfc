<cfcomponent displayname="SampleController" output="false" hint="I am a sample model-glue controller." extends="ModelGlue.Core.Controller">

<cffunction name="Init" access="Public" returnType="Controller" output="false" hint="I build a new SampleController">
  <cfargument name="ModelGlue">
  <cfset super.Init(arguments.ModelGlue) />
  <cfset variables.dateTimeFormat = GetModelGlue().GetConfigBean("DateTimeFormat.xml") />

  <cfreturn this />
</cffunction>

<cffunction name="OnRequestStart" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">

	<cfset var currentTime = timeFormat(now(), variables.dateTimeFormat.getTimeFormat()) />
	<cfset var currentDateLong = dateFormat(now(), variables.dateTimeFormat.getDateFormat().long) />
	<cfset var currentDateShort = dateFormat(now(), variables.dateTimeFormat.getDateFormat().short) />

	<cfset arguments.event.setValue("currentTime", currentTime) />
	<cfset arguments.event.setValue("currentDateLong", currentDateLong) />
	<cfset arguments.event.setValue("currentDateShort", currentDateShort) />

  <cfreturn arguments.event />
</cffunction>

<cffunction name="OnRequestEnd" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">
  <cfreturn arguments.event />
</cffunction>

</cfcomponent>

