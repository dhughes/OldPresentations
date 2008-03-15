<cfcomponent displayName="Event" output="false" hint="I am metadata about rss scaffold." extends="ModelGlue.unity.eventhandler.EventHandler">
	<cffunction name="init" returnType="ModelGlue.unity.eventhandler.EventHandler" output="false" hint="I build a new event.">
		<cfargument name="objectMetadata" type="struct" required="true" />
		<cfargument name="viewGenerator" type="ModelGlue.unity.view.ViewGenerator" required="true" />
		<cfargument name="generatedViews" type="array" required="true" />
		
		<cfset var view = "" />
		<cfset var i = "" />
		<cfset var file = "" />
		
		<cfset super.init() />
		
		<!--- Set info we'll need for further config --->
		<cfset variables.objectName = arguments.objectMetadata.xml.object.alias.xmlText />  	
		
		<!--- Set name --->
		<cfset setName(variables.objectName & ".rss") />

	 	<!--- Add Views --->
	 	<cfloop from="1" to="#arrayLen(arguments.generatedViews)#" index="i">
	 		<cfset file = arguments.generatedViews[i].getPrefix() & variables.objectName & arguments.generatedViews[i].getSuffix() />
	  	<cfset arguments.viewGenerator.generate(file, arguments.objectMetadata, arguments.generatedViews[i].getXsl()) />
	  	<cfset view = createObject("component", "ModelGlue.unity.eventhandler.View").init() />
	  	<cfset view.setName("body") />
	  	<cfset view.setTemplate(file) />
	  	<cfset view.setAppend(true) />
	  	<cfswitch expression="#arguments.generatedViews[i].getName()#">
	  		<cfcase value="rss">
				<cfset view.addValue("xe.view", variables.objectName & ".view", true) />
	  		</cfcase>
	  	</cfswitch>
	  	<cfset addView(view) />
	 	</cfloop>
	 	
	   <cfreturn this />
  </cffunction>

  <cffunction name="doPostConfiguration" returnType="void" output="false" hint="I add the scaffold's implicit messages and result mappings.">
		<cfset var msg = "" />

		<!--- Add Messages --->
		<cfset msg = createObject("component", "ModelGlue.unity.eventhandler.Message").init() />
		<cfset msg.setName("ModelGlue.genericList") />
		<cfset msg.addArgument("object", variables.objectName) />
		<cfset msg.addArgument("queryName", variables.objectName & "Query") />
		<cfset msg.addArgument("ascending", "false") />
		<cfset msg.addArgument("criteria", "") />
		<cfset addMessage(msg) />

	</cffunction>
</cfcomponent>
