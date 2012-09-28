    

<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset EntryRecord = viewstate.getValue("EntryRecord") />
<cfset keyString = "&entryId=#urlEncodedFormat(EntryRecord.getentryId())#" />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & keyString />
<cfset validation = viewstate.getValue("EntryValidation", structNew()) />

<cfset isNew = true />
		

		<cfif (not isNumeric(EntryRecord.getentryId()) and len(EntryRecord.getentryId())) or (isNumeric(EntryRecord.getentryId()) and EntryRecord.getentryId())>
			<cfset isNew = false />
		</cfif>
	
		
<cfoutput>
<div id="breadcrumb">
		<a href="#listEvent#">Entrys</a> / 
		<cfif isNew>
			Add New Entry
		<cfelse>
			#EntryRecord.gettitle()#
		</cfif>
</div>
</cfoutput>
<br />


								
<cfform action="#commitEvent#" class="edit">
    
<fieldset>
    

    <cfoutput>
    <input type="hidden" name="entryId" value="#EntryRecord.getentryId()#" />
    </cfoutput>
  
        <div class="formfield">
	        <label for="title" <cfif structKeyExists(validation, "title")>class="error"</cfif>><b>Title:</b></label>
	        <div>
					
		        <cfinput 
									type="text" 
									class="input" 
									maxLength="50" 
									id="title" 
									name="title" 
									
										value="#EntryRecord.gettitle()#" 
									
						/>
		      
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="title" validation="#validation#" />
        </div>
    
        <div class="formfield">
	        <label for="body" <cfif structKeyExists(validation, "body")>class="error"</cfif>><b>Body:</b></label>
	        <div>
					
		        <textarea class="input" id="body" name="body"><cfoutput>#EntryRecord.getbody()#</cfoutput></textarea>
		      
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="body" validation="#validation#" />
        </div>
    
        <div class="formfield">
	        <label for="date" <cfif structKeyExists(validation, "date")>class="error"</cfif>><b>Date:</b></label>
	        <div>
					
		        <cfinput 
									type="text" 
									class="input" 
									 
									id="date" 
									name="date" 
									
										value="#dateFormat(EntryRecord.getdate(), "m/d/yyyy")# #timeFormat(EntryRecord.getdate(), "h:mm TT")#" 
									
						/>
		      
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="date" validation="#validation#" />
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
									<cfif isBoolean(EntryRecord.getdeleted()) and EntryRecord.getdeleted()>checked</cfif>
						/>
						<label for="deleted_true"> Yes</label>
		        <input 
									type="radio" 
									id="deleted_false" 
									name="deleted" 
									value="false" 
									<cfif isBoolean(EntryRecord.getdeleted()) and not EntryRecord.getdeleted()>checked</cfif>
						/>
						<label for="deleted_false"> No</label>
						</div>
					
	        </div>
	        <cfmodule template="/ModelGlue/customtags/validationErrors.cfm" property="deleted" validation="#validation#" />
        </div>
    
        <div class="formfield">
        	<label <cfif structKeyExists(validation, "Category")>class="error"</cfif>><b>Category(s):</b></label>
          <cfset valueQuery = viewstate.getValue("CategoryList") />
				

					<cfif viewstate.exists("Category|categoryId")>
						<cfset selectedList = viewstate.getValue("Category|categoryId")/>
					<cfelse>
						<!--- This XSL supports both Reactor and Transfer --->
						<cfif structKeyExists(EntryRecord, "getCategoryStruct")>
							<cfset selected = EntryRecord.getCategoryStruct() />
						<cfelseif structKeyExists(EntryRecord, "getCategoryArray")>
							<cfset selected = EntryRecord.getCategoryArray() />
						<cfelse>
							<cfset selected = EntryRecord.getCategoryIterator().getQuery() />
						</cfif>

						<cfif isQuery(selected)>
							<cfset selectedList = valueList(selected.categoryId) />
						<cfelseif isStruct(selected)>
							<cfset selectedList = structKeyList(selected)>
						<cfelseif isArray(selected)>
							<cfset selectedList = "" />
							<cfloop from="1" to="#arrayLen(selected)#" index="i">
								<cfset selectedList = listAppend(selectedList, selected[i].getcategoryId()) />
							</cfloop>
						</cfif>
					</cfif>
				            
          <!--- 
            hidden makes the field always defined.  if this wasn't here, and you deleted this whole field
            from the control, you'd wind up deleting all child records during a genericCommit...
          --->
          <input type="hidden" name="Category|categoryId" value="" />
	        <div class="formfieldinputstack">
          <cfoutput query="valueQuery">
            <label for="Category_#valueQuery.categoryId#"><input type="checkbox" name="Category|categoryId" id="Category_#valueQuery.categoryId#" value="#valueQuery.categoryId#"<cfif listFindNoCase(selectedList, "#valueQuery.categoryId#")> checked</cfif>/>#valueQuery.name#</label><br />
          </cfoutput>
	        </div>
        </div>
          
      
<cfoutput>
<div class="controls">
 	<input type="submit" value="Save" />
  <input type="button" value="Cancel" onclick="document.location.replace('#listEvent#')" />
</div>
</cfoutput>
</fieldset>
</cfform>
    
	
