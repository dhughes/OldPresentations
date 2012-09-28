    
<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & "&CustomerId=" & urlEncodedFormat(viewstate.getValue("CustomerId")) />
<cfset CustomerRecord = viewstate.getValue("CustomerRecord") />
<cfset validation = viewstate.getValue("CustomerValidation", structNew()) />

<cfoutput>
<div id="breadcrumb"><a href="#listEvent#">Customers</a> / View Customer</div>
</cfoutput>
<br />
  
<cfform class="edit">
    
<fieldset>
    

        <div class="formfield">
          <cfoutput>
	        <label for="firstName"><b>First Name:</b></label>
	        <span class="input">#CustomerRecord.getfirstName()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
          <cfoutput>
	        <label for="lastName"><b>Last Name:</b></label>
	        <span class="input">#CustomerRecord.getlastName()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
          <cfoutput>
	        <label for="addressId"><b>Address Id:</b></label>
	        <span class="input">#CustomerRecord.getaddressId()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
          <cfoutput>
	        <label for="deleted"><b>Deleted:</b></label>
	        <span class="input">#CustomerRecord.getdeleted()#</span>
	        </cfoutput>
        </div>
    
</fieldset>
</div>
</cfform>
    
	
