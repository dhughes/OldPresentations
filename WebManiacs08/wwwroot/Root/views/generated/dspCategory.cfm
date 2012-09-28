    
<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & "&CategoryId=" & urlEncodedFormat(viewstate.getValue("CategoryId")) />
<cfset CategoryRecord = viewstate.getValue("CategoryRecord") />
<cfset validation = viewstate.getValue("CategoryValidation", structNew()) />

<cfoutput>
<div id="breadcrumb"><a href="#listEvent#">Categorys</a> / View Category</div>
</cfoutput>
<br />
  
<cfform class="edit">
    
<fieldset>
    

        <div class="formfield">
          <cfoutput>
	        <label for="name"><b>Name:</b></label>
	        <span class="input">#CategoryRecord.getname()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
          <cfoutput>
	        <label for="deleted"><b>Deleted:</b></label>
	        <span class="input">#CategoryRecord.getdeleted()#</span>
	        </cfoutput>
        </div>
    
</fieldset>
</div>
</cfform>
    
	
