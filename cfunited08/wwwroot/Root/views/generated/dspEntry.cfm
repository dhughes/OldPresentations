    
<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & "&EntryId=" & urlEncodedFormat(viewstate.getValue("EntryId")) />
<cfset EntryRecord = viewstate.getValue("EntryRecord") />
<cfset validation = viewstate.getValue("EntryValidation", structNew()) />

<cfoutput>
<div id="breadcrumb"><a href="#listEvent#">Entrys</a> / View Entry</div>
</cfoutput>
<br />
  
<cfform class="edit">
    
<fieldset>
    

        <div class="formfield">
          <cfoutput>
	        <label for="title"><b>Title:</b></label>
	        <span class="input">#EntryRecord.gettitle()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
          <cfoutput>
	        <label for="body"><b>Body:</b></label>
	        <span class="input">#EntryRecord.getbody()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
          <cfoutput>
	        <label for="date"><b>Date:</b></label>
	        <span class="input">#EntryRecord.getdate()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
          <cfoutput>
	        <label for="deleted"><b>Deleted:</b></label>
	        <span class="input">#EntryRecord.getdeleted()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
        	<label><b>name(s):</b></label>

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
						<div class="formfieldinputstack">
						<cfoutput query="selected">
							#selected.name#<br />
						</cfoutput>
						</div>
					<cfelseif isStruct(selected)>
						<cfoutput>
						<div class="formfieldinputstack">
						<cfloop collection="#selected#" item="i">
							#selected[i].getname()#<br />
						</cfloop>
						</div>
						</cfoutput>
					<cfelseif isArray(selected)>
						<cfoutput>
						<div class="formfieldinputstack">
						<cfloop from="1" to="#arrayLen(selected)#" index="i">
							#selected[i].getname()#<br />
						</cfloop>
						</div>
						</cfoutput>
					</cfif>

        </div>
          
      
</fieldset>
</div>
</cfform>
    
	
