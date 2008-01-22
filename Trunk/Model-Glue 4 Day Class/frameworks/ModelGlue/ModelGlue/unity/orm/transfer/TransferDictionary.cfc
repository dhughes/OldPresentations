<!--- Document Information -----------------------------------------------------

Title:      TransferDictionary.cfc

Author:     Sean Corfield, based on the Reactor ORM dictionary by Joe Rinehart
Email:      sean@corfield.org

Website:    http://corfield.org

Purpose:    Model-Glue dictionary object for Transfer

Usage:

Modification Log:

Name			Date			Description
================================================================================
Sean Corfield	12/09/2006		Created

------------------------------------------------------------------------------->
<cfcomponent>
	
	<cffunction name="init" returntype="any" access="public" output="false">
		<cfargument name="transfer" type="any" required="true" />
		<cfargument name="table" type="string" required="true" />
	
		<cfset var skeleton = arguments.transfer.getTransferMetadata(arguments.table) />
		<cfset var props = skeleton.getPropertyIterator() />
		<cfset var prop = 0 />
		<cfset var pk = skeleton.getPrimaryKey() />

		<cfset keys = structNew() />
		
		<cfset keys[arguments.table & "." & pk.getName() & ".label"] = pk.getName() />
		
		<cfloop condition="#props.hasNext()#">
			<cfset prop = props.next() />
			
			<cfset keys[arguments.table & "." & prop.getName() & ".label"] = determineLabel(prop.getName()) />
			<cfset keys[arguments.table & "." & prop.getName() & ".required"] = keys[arguments.table & "." & prop.getName() & ".label"] & " is required." />
			
			<cfswitch expression="#prop.getType()#">
				<cfcase value="numeric">
					<cfset keys[arguments.table & "." & prop.getName() & ".type"] = keys[arguments.table & "." & prop.getName() & ".label"]  & " must be a number." />
				</cfcase>
				<cfcase value="date">
					<cfset keys[arguments.table & "." & prop.getName() & ".type"] = keys[arguments.table & "." & prop.getName() & ".label"]  & " must be a date." />
				</cfcase>
				<cfcase value="boolean">
					<cfset keys[arguments.table & "." & prop.getName() & ".type"] = keys[arguments.table & "." & prop.getName() & ".label"]  & " must be true or false." />
				</cfcase>
				<cfdefaultcase>
					<cfset keys[arguments.table & "." & prop.getName() & ".type"] = keys[arguments.table & "." & prop.getName() & ".label"]  & " must be text." />
				</cfdefaultcase>
			</cfswitch>				
		</cfloop>
	
		<cfreturn this />
	
	</cffunction>
	
	<!--- getValue --->
	<cffunction name="getValue" access="public" hint="I get a value from the dictionary" output="false" returntype="string">
		<cfargument name="element" hint="I am the path to the element to get from the dictionary.  IE: foo.bar to get dictionary/foo/bar" required="yes" type="string" />
		
		<cfif structKeyExists(variables.keys,arguments.element)>
			<cfreturn variables.keys[arguments.element] />
		</cfif>		

		<cfreturn arguments.element />

	</cffunction>	

	<cffunction name="determineLabel" returntype="string" output="false" access="private">
		<cfargument name="label" type="string" required="true" />
		
		<cfset var i = "" />
		<cfset var char = "" />
		<cfset var result = "" />
		
		<cfloop from="1" to="#len(arguments.label)#" index="i">
			<cfset char = mid(arguments.label, i, 1) />
			
			<cfif i eq 1>
				<cfset result = result & ucase(char) />
			<cfelseif asc(lCase(char)) neq asc(char)>
				<cfset result = result & " " & ucase(char) />
			<cfelse>
				<cfset result = result & char />
			</cfif>
		</cfloop>
	
		<cfreturn result />	
	</cffunction>

</cfcomponent>