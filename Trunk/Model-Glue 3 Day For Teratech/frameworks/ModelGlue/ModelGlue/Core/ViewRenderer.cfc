<cfcomponent displayName="ViewRenderer" output="false" hint="I am the container in which a view is rendered.">
  <cffunction name="Init" access="public" returnType="ModelGlue.Core.ViewRenderer" output="false" hint="I build a new view renderer.">
    <cfargument name="stateContainer" type="ModelGlue.Util.GenericCollection" required="true" hint="State container available to rendered views.">
    <cfargument name="viewCollection" type="ModelGlue.Core.ViewCollection" required="true" hint="View collection available to rendered views.">
    <cfset variables.viewState = arguments.stateContainer />
    <cfset variables.viewCollection = arguments.viewCollection />
    <cfreturn this />
  </cffunction>
  
  <cffunction name="RenderView" output="false" hint="I render a view and return the resultant HTML.">
    <cfargument name="IncludeUrl" type="string" required="true" hint="I am the template to CFInclude.">
    <cfargument name="StateValues" type="struct" required="true" hint="I am the additional view state values.">
    <cfset var result = "" />
    <cfset var v = "" />
    
    <cfloop collection="#arguments.StateValues#" item="i">
      <cfif arguments.StateValues[i].overwrite or not variables.viewState.exists(i)>
    	  <cfset variables.viewState.SetValue(i,arguments.StateValues[i].value) />
      </cfif>
    </cfloop>
    
    <cfsavecontent variable="result"><cfinclude template="#arguments.includeUrl#"></cfsavecontent>
    
    <cfreturn result />
  </cffunction>
</cfcomponent>