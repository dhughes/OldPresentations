<cfcomponent displayname="GenericCollection" output="false" hint="I am a generic collection.  Not much better than a struct.">
  <cffunction name="Init" access="public" returnType="GenericCollection" output="false" hint="I build a new GenericCollection.">
		<cfargument name="values" required="false"  default="#arrayNew(1)#" />

    <cfset var i = "" />
    <cfset variables.members = structNew() />

    <cfloop from="#arrayLen(arguments.values)#" to="1" step="-1" index="i">
      <cfset merge(arguments.values[i]) />
    </cfloop>
    
    <cfreturn this />
  </cffunction>

  <cffunction name="GetAll" access="public" returnType="struct" output="false" hint="I get all values using StructCopy().">
    <cfreturn variables.members />
  </cffunction>

  <cffunction name="SetValue" access="public" returnType="void" output="false" hint="I set a value in the collection.">
    <cfargument name="name" hint="I am the name of the value.">
    <cfargument name="value" hint="I am the value.">

    <cfset variables.members[arguments.name] = arguments.value />
  </cffunction>

  <cffunction name="GetValue" access="public" returnType="any" output="false" hint="I get a value from the collection.">
    <cfargument name="name" hint="I am the name of the value.">
    <cfargument name="default" required="false" type="any" hint="I am a default value to set and return if the value does not exist." />

    <cfif exists(arguments.name)>
      <cfreturn variables.members[arguments.name] />
    <cfelseif structKeyExists(arguments, "default")>
      <cfset setValue(arguments.name, arguments.default) />
      <cfreturn arguments.default />
    <cfelse>
      <cfreturn "" />
    </cfif>
  </cffunction>

  <cffunction name="RemoveValue" access="public" returnType="void" output="false" hint="I remove a value from the collection.">
    <cfargument name="name" type="string" required="true" hint="I am the name of the value.">
    <cfset structDelete(variables.members, arguments.name) />
  </cffunction>

  <cffunction name="Exists" access="public" returnType="boolean" output="false" hint="I state if a value exists.">
    <cfargument name="name" type="string" required="true" hint="I am the name of the value.">
    <cfreturn structKeyExists(variables.members, arguments.name)>
  </cffunction>
  
  <cffunction name="Merge" access="public" returnType="void" output="false" hint="I merge an entire struct into the collection.">
    <cfargument name="struct" type="struct" required="true" hint="I am the struct to merge." />
    
    <cfset var i = "" />
    
    <cfloop collection="#arguments.struct#" item="i">
      <cfset setValue(i, arguments.struct[i]) />
    </cfloop>
  </cffunction>
  
</cfcomponent>