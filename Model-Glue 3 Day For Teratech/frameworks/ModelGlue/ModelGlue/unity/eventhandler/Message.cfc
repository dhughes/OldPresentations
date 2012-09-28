<cfcomponent displayname="Message" output="false" hint="I'm metadata information about a message that can be broadcast.">
  <cffunction name="init" returnType="ModelGlue.unity.eventhandler.Message" access="public" output="false" hint="I build a new Message.">
    <cfset variables.name = "" />
    <cfset variables.arguments = createObject("component", "ModelGlue.Util.GenericCollection").init() />
    <cfreturn this />
  </cffunction>

  <cffunction name="toStruct" access="public" returntype="struct" output="false">
		<cfset var result = structNew() />
		<cfset result.name = variables.name />
		<cfset result.arguments = getArguments() />
		<cfreturn result />
	</cffunction>

  <cffunction name="setName" access="public" returntype="void" output="false" hint="I set the message's name (is what listeners listen for).">
    <cfargument name="name" type="string" required="true" hint="I am the name.">
    <cfset variables.name = arguments.name />
  </cffunction>
  
  <cffunction name="getName" access="public" returntype="string" output="false" hint="I get the message's name (is what listeners listen for).">
    <cfreturn variables.name />
  </cffunction>
  
  <cffunction name="addArgument" access="public" returntype="void" output="false" hint="I add an argument.">
    <cfargument name="name" type="string" required="true" hint="I am the name of the argument to add.">
    <cfargument name="value" type="string" required="true" hint="I am the value of the argument to add.">
    
    <cfset variables.arguments.setValue(arguments.name, arguments.value) />
  </cffunction>
  
  <cffunction name="getArguments" access="public" output="false" hint="I return the message's arguments (by value)">
    <cfreturn variables.arguments.getAll() />
  </cffunction>
</cfcomponent>