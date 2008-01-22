<cfcomponent displayname="ViewGenerator" output="false">

<cffunction name="init" returntype="ModelGlue.unity.view.ViewGenerator" output="false">
	<cfargument name="modelGlueConfiguration" type="ModelGlue.unity.framework.ModelGlueConfiguration" required="true">
	
	<cfset variables._outDir = expandPath(arguments.modelGlueConfiguration.getGeneratedViewMapping()) />
	
	<cfif not directoryExists(variables._outDir)>
		<cftry>
			<cfdirectory action="create" directory="#variables._outDir#" />
			<cfcatch>
				<cfthrow message="Model-Glue:  Couldn't create #variables._outDir#." />
			</cfcatch>
		</cftry>
	</cfif>
	<cfreturn this />
</cffunction>

<cffunction name="getOutputDirectory" returntype="string" access="private" output="false">
	<cfreturn variables._outDir />
</cffunction>

<cffunction name="generate" returntype="void" access="public" output="false">
	<cfargument name="filename" type="string" required="true" />
	<cfargument name="objectMetadata" type="struct" required="true" />
	<cfargument name="xslTemplate" type="string" required="true" />
	
	<cfset var md = arguments.objectMetadata.xml />
	<cfset var content = "" />
	<cfset var xsl = "" />
	<cfset var dir = getOutputDirectory() />
	
	<cffile action="read" variable="xsl" file="#expandPath(arguments.xslTemplate)#" />
	
	<cfset content = xmlTransform(md, xsl) />
	
	<cfif not directoryExists(dir)>
		<cfdirectory action="create" directory="#dir#" />
	</cfif>
	
	<cffile action="write" file="#dir & "/" & arguments.filename#" output="#content#" />
</cffunction>

</cfcomponent>