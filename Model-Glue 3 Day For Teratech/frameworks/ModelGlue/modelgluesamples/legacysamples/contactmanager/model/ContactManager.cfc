<cfcomponent hint="ContactManager" output="false">

	<cfset variables.contacts = StructNew() />
	
  <cffunction name="newContact">
    <cfreturn createObject("component", "modelgluesamples.legacysamples.contactmanager.model.Contact").init() />
  </cffunction>

  <cffunction name="commitContact">
    <cfargument name="contact">
    
    <cfset var validator = createObject("component", "modelgluesamples.legacysamples.contactmanager.model.ContactValidator") />
    <cfset var val = "" />
    
    <cfset val = validator.validate(arguments.contact) />
    
    <cfif not val.hasErrors()>
      <cfif not len(arguments.contact.getId())>
        <cfset arguments.contact.setId(createUuid())>
      </cfif>
      <cfset variables.contacts[arguments.contact.getId()] = contact />
    </cfif>
    
    <cfreturn val />
  </cffunction>
  
	<cffunction name="getContact" returntype="modelgluesamples.legacysamples.contactmanager.model.Contact">
		<cfargument name="id" type="string" required="true" />
		
		<cfif StructKeyExists(variables.contacts, arguments.id)>
			<cfreturn variables.contacts[arguments.id] />
		<cfelse>
			<cfthrow message="Contact with ID #arguments.id# does not exist." />
		</cfif>
	</cffunction>

	<cffunction name="getAllContacts" returntype="struct">
		<cfreturn variables.contacts />
	</cffunction>
</cfcomponent>