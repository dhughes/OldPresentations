<cfcomponent displayName="ViewRenderer" output="false" hint="I am the container in which a view is rendered.">
  <cffunction name="Init" access="public" returnType="any" output="false" hint="I build a new view renderer.">
    <cfreturn this />
  </cffunction>
  

  <cffunction name="RenderView" output="false" hint="I render a view and return the resultant HTML.">
    <cfargument name="stateContainer" type="any" hint="State container available to rendered views.">
    <cfargument name="viewCol" type="any" hint="View collection available to rendered views.">
    <cfargument name="IncludeUrl" type="any" hint="I am the template to CFInclude.">
    <cfargument name="StateValues" type="any" hint="I am the additional view state values.">

    <cfset var result = "" />
    <cfset var v = "" />
    <cfset var i = "" />
		<cfset var viewstate = arguments.stateContainer />
		<cfset var viewCollection = arguments.viewCol />
    
    <cfloop collection="#arguments.StateValues#" item="i">
      <cfif arguments.StateValues[i].overwrite or not viewstate.exists(i)>
    	  <cfset viewstate.SetValue(i,arguments.StateValues[i].value) />
      </cfif>
    </cfloop>
    
    <cfsavecontent variable="result"><cfmodule template="/ModelGlue/unity/view/ViewRenderer.cfm" includepath="#arguments.includeUrl#" viewstate="#viewstate#" viewcollection="#viewcollection#"></cfsavecontent>

    <cfreturn result />
  </cffunction>
</cfcomponent>