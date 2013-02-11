<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" indent="no"  />

	<xsl:template match="/">
&lt;cfset <xsl:value-of select="object/alias"/>Query = viewstate.getValue("<xsl:value-of select="object/alias"/>Query") /&gt;
&lt;cfset viewEvent = viewstate.getValue("myself") &amp; viewstate.getValue("xe.view") /&gt;

&lt;cfcontent reset="true"/&gt;&lt;?xml version="1.0" encoding="iso-8859-1"?&gt;

&lt;rss version="2.0" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"&gt;

	&lt;channel&gt;
	    &lt;title&gt;An RSS Feed&lt;/title&gt;
	    &lt;link&gt;http://#cgi.server_name#&lt;/link&gt;
	    &lt;description&gt;Rss Feed&lt;/description&gt;

		&lt;cfoutput query="<xsl:value-of select="object/alias"/>Query"&gt;
			&lt;cfset keyString = "<xsl:for-each select="object/properties/property"><xsl:if test="primarykey = 'true'">&amp;<xsl:value-of select="alias"/>=#urlEncodedFormat(<xsl:value-of select="/object/alias"/>Query.<xsl:value-of select="alias"/>)#</xsl:if></xsl:for-each>" />
			
			&lt;item&gt;
				&lt;title&gt;#<xsl:value-of select="object/alias"/>Query.Title#&lt;/title&gt;
				&lt;link&gt;http://#cgi.server_name#/#viewevent##replace(keyString, "&amp;", "&amp;amp;", "all")#&lt;/link&gt;
				&lt;description&gt;#left(<xsl:value-of select="object/alias"/>Query.body, "500")#...&lt;/description&gt;
				
				
				&lt;dc:date&gt;#DateFormat(<xsl:value-of select="object/alias"/>Query.Date, "yyyy-mm-dd")#T#TimeFormat(<xsl:value-of select="object/alias"/>Query.Date, "hh:mm:ss-04:00")#&lt;/dc:date&gt;
			&lt;/item&gt;
			
			
		&lt;/cfoutput&gt;
		
	&lt;/channel&gt;
&lt;/rss&gt;&lt;cfabort /&gt;       
	</xsl:template>
</xsl:stylesheet>