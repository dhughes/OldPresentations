    

<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset CategoryRecord = viewstate.getValue("CategoryRecord") />
<cfset keyString = "&categoryId=#urlEncodedFormat(CategoryRecord.getcategoryId())#" />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & keyString />
<cfset validation = viewstate.getValue("CategoryValidation", structNew()) />

<cfset isNew = true />
		

		<cfif (not isNumeric(CategoryRecord.getcategoryId()) and len(CategoryRecord.getcategoryId())) or (isNumeric(CategoryRecord.getcategoryId()) and CategoryRecord.getcategoryId())>
			<cfset isNew = false />
		</cfif>
	
		
<cfoutput>
<div id="breadcrumb">
		<a href="#listEvent#">Categorys</a> / 
		<cfif isNew>
			Add New Category
		<cfelse>
			#CategoryRecord.getname()#
		</cfif>
</div>
</cfoutput>
<br />


								
<cfform action="#commitEvent#" class="edit">
    
<fieldset>
    

    <cfoutput>
    <input type="hidden" name="categoryId" value="#CategoryRecord.getcategoryId()#" />
    </cfoutput>
  
        <div class="formfield">
	        <label for="name" <cfif structKeyExists(validation, "name")>class="error"</cfif>><b>Name:</b></label>
	        <div>
					
		        <cfinput 
									type="text" 
									class="input" 
									maxLength="50" 
									id="name" 
									name="name" 
									
										value="#CategoryRecord.getname()#" 
									
						/>
		      
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="name" validation="#validation#" />
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
									<cfif isBoolean(CategoryRecord.getdeleted()) and CategoryRecord.getdeleted()>checked</cfif>
						/>
						<label for="deleted_true"> Yes</label>
		        <input 
									type="radio" 
									id="deleted_false" 
									name="deleted" 
									value="false" 
									<cfif isBoolean(CategoryRecord.getdeleted()) and not CategoryRecord.getdeleted()>checked</cfif>
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
    
	
