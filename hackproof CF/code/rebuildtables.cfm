<cfquery name="rebuild" datasource="hackproof" result="test">
	TRUNCATE TABLE users;
	INSERT INTO max_preso.dbo.users( username, password, firstName, lastName) VALUES ( N'boyzoid', N'password', N'Scott', N'Stroz');
	INSERT INTO max_preso.dbo.users( username, password, firstName, lastName) VALUES ( N'manninge', N'password', N'Eli', N'Manning');
	INSERT INTO max_preso.dbo.users( username, password, firstName, lastName) VALUES ( N'jacobsb', N'password', N'Brandon', N'Jacobs');
	INSERT INTO max_preso.dbo.users( username, password, firstName, lastName) VALUES ( N'tuckj', N'password', N'Justin', N'Tuck');
	INSERT INTO max_preso.dbo.users( username, password, firstName, lastName) VALUES ( N'phillipsk', N'password', N'Kenny', N'Phillips');
	INSERT INTO max_preso.dbo.users( username, password, firstName, lastName) VALUES ( N'buressp', N'password', N'Plaxico', N'Buress');
</cfquery>

<cfquery name="rebuild" datasource="hackproof" result="test">
	TRUNCATE TABLE products;
	INSERT INTO max_preso.dbo.products( product, description) VALUES ( N'Thing-a-ma-bob', N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in ');
	INSERT INTO max_preso.dbo.products( product, description) VALUES ( N'Whos-a-whats-it', N'Epsum factorial non deposit quid pro quo hic escorol. Olypian quarrels et gorilla congolium sic ad nauseum. Souvlaki ignitus carborundum e pluribus unum. Defacto lingo est igpay atinlay. Marquee selectus non provisio incongruous feline nolo contendre. Gratuitous octopus niacin, sodium glutimate. Quote meon an estimate et non interruptus stadium. Sic ');
	INSERT INTO max_preso.dbo.products( product, description) VALUES ( N'Hornswaggle', N'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc., li tot Europa usa li sam vocabularium. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilit de un nov lingua franca: on ');
</cfquery>

<cfquery name="getProducts" datasource="hackproof">
	Select * from products;
</cfquery>

<cfquery name="truncate" datasource="hackproof">
	TRUNCATE TABLE products2;
</cfquery>

<cfloop query="getPRoducts">
	<cfquery datasource="hackproof">
		INSERT INTO products2 values('#createUUID()#', '#getPRoducts.product#', '#getProducts.description#')
	</cfquery>
</cfloop>


Tables have been rebuilt!

