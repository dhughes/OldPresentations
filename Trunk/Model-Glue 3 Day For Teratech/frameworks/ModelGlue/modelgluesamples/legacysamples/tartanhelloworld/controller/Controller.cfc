<cfcomponent displayname="SampleController" output="false" hint="I am a sample model-glue controller." extends="ModelGlue.Core.Controller">

<cffunction name="Init" access="Public" returnType="Controller" output="false" hint="I build a new SampleController">
  <cfargument name="ModelGlue">
  <cfset var temp = "" />

  <cfset super.Init(arguments.ModelGlue) />
  
  <!--- Load the config params for the Tartan app we're talking to --->
  <cfset temp = getModelGlue().getConfigBean("Tartan.xml") />
  
  <!--- Load the Tartan proxy --->
  <cfset variables.tartanProxy = createObject("component", "ModelGlue.Util.TartanProxy").init(temp) />
  
  <!--- We're going to need the HelloWorld service universally --->
  <cfset variables.hwService = getTartan().CreateService("helloWorld") />  
  
  <cfreturn this />
</cffunction>


<cffunction name="GetHelloService" access="private" output="false">
  <cfreturn variables.hwService  />
</cffunction>

<cffunction name="GetTartan" access="private" output="false">
  <cfreturn variables.tartanProxy  />
</cffunction>

<cffunction name="OnRequestStart" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">
  <cfreturn arguments.event />
</cffunction>

<cffunction name="OnRequestEnd" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">
  <cfreturn arguments.event />
</cffunction>

<cffunction name="GetGreeting" access="Public" returnType="ModelGlue.Core.Event" output="false">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">

  <cfset var proxy = GetTartan() />
  <cfset var service = getHelloService() />
  <cfset var args = structNew() />
  <cfset var greeting = "" />
  <cfset args.lang = arguments.event.getValue("lang", "English") />
  
  <cfset greeting = proxy.invokeCommand(service, "GetGreeting", args) />
  <cfset arguments.event.setValue("greeting", greeting) />
  <cfreturn arguments.event />
</cffunction>

</cfcomponent>

