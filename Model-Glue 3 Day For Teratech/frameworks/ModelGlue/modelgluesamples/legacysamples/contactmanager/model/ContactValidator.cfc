<cfcomponent>
  <cffunction name="Validate">
    <cfargument name="Contact">
    <cfset var val = createObject("component", "ModelGlue.Util.ValidationErrorCollection").init() />

    <cfif not len(contact.getFirstname())>
      <cfset val.addError("firstname", "First name is required.") />
    </cfif>

    <cfif not len(contact.getLastname())>
      <cfset val.addError("lastname", "Last name is required.") />
    </cfif>

    <cfreturn val>
  </cffunction>
</cfcomponent>