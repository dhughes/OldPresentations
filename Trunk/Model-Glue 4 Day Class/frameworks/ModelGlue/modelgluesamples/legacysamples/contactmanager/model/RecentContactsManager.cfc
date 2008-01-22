<cfcomponent hint="RecentContactsManager" output="false">
  <cfset variables.contacts = arrayNew(1) />
  
  <cffunction name="addRecentContact">
    <cfargument name="contact">
    <cfset arrayAppend(variables.contacts, arguments.contact) />
  </cffunction>
  
  <cffunction name="getRecentContacts">
    <cfreturn variables.contacts />
  </cffunction>
</cfcomponent>