
<cfset EntryQuery = viewstate.getValue("EntryQuery") />
<cfset viewEvent = viewstate.getValue("myself") & viewstate.getValue("xe.view") />

<cfcontent reset="true"/><?xml version="1.0" encoding="iso-8859-1"?>

<rss version="2.0" 
    xmlns:dc="http://purl.org/dc/elements/1.1/">

	<channel>
	    <title>An RSS Feed</title>
	    <link>http://#cgi.server_name#</link>
	    <description>Rss Feed</description>

		<cfoutput query="EntryQuery">
			<cfset keyString = "&entryId=#urlEncodedFormat(EntryQuery.entryId)#" />
			
			<item>
				<title>#EntryQuery.Title#</title>
				<link>http://#cgi.server_name#/#viewevent##replace(keyString, "&", "&amp;", "all")#</link>
				<description>#left(EntryQuery.body, "500")#...</description>
				
				
				<dc:date>#DateFormat(EntryQuery.Date, "yyyy-mm-dd")#T#TimeFormat(EntryQuery.Date, "hh:mm:ss-04:00")#</dc:date>
			</item>
			
			
		</cfoutput>
		
	</channel>
</rss><cfabort />       
	
