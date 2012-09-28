    

<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset CustomerRecord = viewstate.getValue("CustomerRecord") />
<cfset keyString = "&customerId=#urlEncodedFormat(CustomerRecord.getcustomerId())#" />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & keyString />
<cfset validation = viewstate.getValue("CustomerValidation", structNew()) />

<cfset isNew = true />
		

		<cfif (not isNumeric(CustomerRecord.getcustomerId()) and len(CustomerRecord.getcustomerId())) or (isNumeric(CustomerRecord.getcustomerId()) and CustomerRecord.getcustomerId())>
			<cfset isNew = false />
		</cfif>
	
		
<cfoutput>
<div id="breadcrumb">
		<a href="#listEvent#">Customers</a> / 
		<cfif isNew>
			Add New Customer
		<cfelse>
			#CustomerRecord.getfirstName()#
		</cfif>
</div>
</cfoutput>
<br />


								
<cfform action="#commitEvent#" class="edit">
    
<fieldset>
    

    <cfoutput>
    <input type="hidden" name="customerId" value="#CustomerRecord.getcustomerId()#" />
    </cfoutput>
  
        <div class="formfield">
	        <label for="firstName" <cfif structKeyExists(validation, "firstName")>class="error"</cfif>><b>First Name:</b></label>
	        <div>
					
		        <cfinput 
									type="text" 
									class="input" 
									maxLength="50" 
									id="firstName" 
									name="firstName" 
									
										value="#CustomerRecord.getfirstName()#" 
									
						/>
		      
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="firstName" validation="#validation#" />
        </div>
    
        <div class="formfield">
	        <label for="lastName" <cfif structKeyExists(validation, "lastName")>class="error"</cfif>><b>Last Name:</b></label>
	        <div>
					
		        <cfinput 
									type="text" 
									class="input" 
									maxLength="50" 
									id="lastName" 
									name="lastName" 
									
										value="#CustomerRecord.getlastName()#" 
									
						/>
		      
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="lastName" validation="#validation#" />
        </div>
    
        <div class="formfield">
	        <label for="addressId" <cfif structKeyExists(validation, "addressId")>class="error"</cfif>><b>Address Id:</b></label>
	        <div>
					
		        <cfinput 
									type="text" 
									class="input" 
									 
									id="addressId" 
									name="addressId" 
									
										value="#CustomerRecord.getaddressId()#" 
									
						/>
		      
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="addressId" validation="#validation#" />
        </div>
    
        <div class="formfield">
	        <label for="deleted" <cfif structKeyExists(validation, "deleted")>class="error"</cfif>><b>Deleted:</b></label>
	        <div>
					
		        <div class="formfieldinputstack">
		        <input 
									type="radio" 
									id="deleted_true" 
									name="deleted" 
									value="true" 
									<cfif isBoolean(CustomerRecord.getdeleted()) and CustomerRecord.getdeleted()>checked</cfif>
						/>
						<label for="deleted_true"> Yes</label>
		        <input 
									type="radio" 
									id="deleted_false" 
									name="deleted" 
									value="false" 
									<cfif isBoolean(CustomerRecord.getdeleted()) and not CustomerRecord.getdeleted()>checked</cfif>
						/>
						<label for="deleted_false"> No</label>
						</div>
					
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="deleted" validation="#validation#" />
        </div>
    
<cfoutput>
<div class="controls">
 	<input type="submit" value="Save" />
  <input type="button" value="Cancel" onclick="document.location.replace('#listEvent#')" />
</div>
</cfoutput>
</fieldset>
</cfform>
    
	
