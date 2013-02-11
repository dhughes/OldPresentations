<cfparam name="url.productid" default="0" />

<cfquery name="products" datasource="hackproof">
	SELECT productID, product
	FROM products
</cfquery>
<h2>Product List</h2>
<ol>
	<cfoutput query="products">
		<li><a href="sql_injection_1.cfm?productID=#products.productID#">#products.product#</a></li>
	</cfoutput>
</ol>	

<cfif url.productID NEQ 0>
	<cfquery name="getProduct" datasource="hackproof">
		SELECT productID, product, description
		FROM products
		<!--- WHERE productID = #url.productID#  --->
		
		 WHERE productID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.productID#"> 
	</cfquery>
	
	<div>
		<h2>Product Information</h2>
		<cfoutput query="getProduct">
			<div>
				<strong>#getProduct.product#</strong>: #getProduct.description#.
			</div>
		</cfoutput>
		
	</div>
</cfif>



<!--- sample SQL Injection attacks -   

;delete form products

OR 1=1

;update%20products%20set%20product%20%3D%20%27Boyzoid%27

;update%20products%20set%20product%20%20%3D%20cast%28%20char%2866%29%2Bchar%28111%29%2Bchar%28121%29%2Bchar%28122%29%2Bchar%28111%29%2Bchar%28105%29%2Bchar%28100%29%20as%20varchar%29 
  
;shutdown --
--->

