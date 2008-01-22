<cfcomponent displayName="Event" output="false" hint="I am metadata about Commit scaffold." extends="ModelGlue.unity.eventhandler.EventHandler">
  <cffunction name="init" returnType="ModelGlue.unity.eventhandler.EventHandler" output="false" hint="I build a new event.">
		<cfargument name="objectMetadata" type="struct" required="true" />
		<cfargument name="viewGenerator" type="ModelGlue.unity.view.ViewGenerator" required="true" />
		<cfargument name="generatedViews" type="array" required="true" />

  	<cfset super.init() />

		<!--- Set info we'll need for further config --->
		<cfset variables.objectMetadata = arguments.objectMetadata />  	
		<cfset variables.objectName = arguments.objectMetadata.xml.object.alias.xmlText />  	
  	
  	<!--- Set name --->
  	<cfset setName(variables.objectName & ".Commit") />
  	
    <cfreturn this />
  </cffunction>

  <cffunction name="doPostConfiguration" returnType="void" output="false" hint="I add the scaffold's implicit messages and result mappings.">
		<cfset var msg = "" />
		<cfset var keyList = arrayToList(variables.objectMetadata.primaryKeys) />

  	<!--- Add Messages --->
  	<cfset msg = createObject("component", "ModelGlue.unity.eventhandler.Message").init() />
  	<cfset msg.setName("ModelGlue.genericCommit") />
  	<cfset msg.addArgument("object", variables.objectName) />
		<cfset msg.addArgument("criteria", keyList) />
  	<cfset msg.addArgument("recordName", variables.objectName & "Record") />
  	<cfset msg.addArgument("validationName", variables.objectName & "Validation") />
  	<cfset addMessage(msg) />
  	
  	<!--- Add Results --->
		<cfif not resultMappingExists("commit")>
	  	<cfset addResultMapping("commit", variables.objectName & ".list", true, "", "", false, false) />
	  </cfif>
		<cfif not resultMappingExists("validationError")>
	  	<cfset addResultMapping("validationError", variables.objectName & ".edit", false, keyList, "", false, false) />
	  </cfif>
	</cffunction>

</cfcomponent>
