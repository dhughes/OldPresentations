<cfcomponent displayname="zip" hint="I provide methods for working with Zip files.">
	<!--- instance variables --->
	<cfset variables.zipFile = "" />

	<!--- init method --->
	<cffunction name="init" returntype="zip" hint="I am a constructor method which configures the object (me) and returns the configured object (myself).">
		<cfargument name="zipFile" required="true" type="string" hint="I am the path to the zip file to work with." />
		
		<!--- set the zip file we're working with --->
		<cfset variables.zipFile = arguments.zipFile />
				
		<cfreturn this />
	</cffunction>
		
	<cffunction name="addFiles" returntype="void" hint="I add an array of files to the current zip file.  I overwrite the zip file if it already exists, I do not append to the zip.">
		<cfargument name="files" required="true" type="array" hint="I am an array of paths to files to add to the zip file." />
		<cfset var FileOutputStream = CreateObject("Java", "java.io.FileOutputStream") />
		<cfset var ZipOutputStream = CreateObject("Java", "java.util.zip.ZipOutputStream") />
		<cfset var FileInputStream = CreateObject("Java", "java.io.FileInputStream") />
		<cfset var ZipEntry = CreateObject("Java", "java.util.zip.ZipEntry") />
		<cfset var ByteArray = getByteArray(1024) />
		<cfset var x = 0 />
		
		<!---
			Init various the output streams
			The ZipOutputStream uses the FileOutputStream which actualy "connects" to the file we're writeing to.
			This will create the file if it dosn't exist.			
		--->
		<cfset FileOutputStream.init(variables.zipFile) />
		<cfset ZipOutputStream.init(FileOutputStream) />
		
		<!--- loop over the array of files we're adding to the zip and add each file --->
		<cfloop from="1" to="#ArrayLen(arguments.files)#" index="x">
			<!--- init a fileInputStream to read the current file we're adding --->
			<cfset FileInputStream.init(arguments.files[x]) />
			<!--- init the ZipEntry and give it the name of the file we're adding --->
			<cfset ZipEntry.init(getFileFromPath(arguments.files[x])) />
	
			<!--- add an entry to our zip file (this dosn't add the data, just creates the placeholder where the data will be stored) --->
			<cfset ZipOutputStream.putNextEntry(ZipEntry) />
			
			<!---
				transfer data from our FileInputStream to our ZipOutputStream
				This works by reading a "buffer" of data from the file we're zipping and adding it to the 
				Current ZipEntry.  This is repeated untill all of the source file has been read and written
				into the current ZipEntry.  This is pretty typical Java stuff.
			--->
			<cfloop condition="FileInputStream.read(ByteArray) IS NOT -1">
				<!--- write the data into the current zip entry --->
				<cfset ZipOutputStream.write(ByteArray, 0, Len(ByteArray)) />
			</cfloop>
	
			<!--- close the zip entry.  IE: mark this point as being the end of a file --->
			<cfset ZipOutputStream.closeEntry() />
			<!--- close the file we're reading --->
			<cfset FileInputStream.close() />
		</cfloop>
				
		<!--- close our connection to our zip file --->
		<cfset ZipOutputStream.close() />		
	</cffunction>
	
	<cffunction name="extractFile" returntype="void" hint="I extract the file specified to the path specified.">
		<cfargument name="name" required="true" type="string" hint="I am the name of the file to extract." />
		<cfargument name="toPath" required="true" type="string" hint="I am the path to the file to add to the current zip file." />
		<cfset var FileInputStream = CreateObject("Java", "java.io.FileInputStream") />
		<cfset var FileOutputStream = CreateObject("Java", "java.io.FileOutputStream") />
		<cfset var ZipInputStream = CreateObject("Java", "java.util.zip.ZipInputStream") />
		<cfset var ByteArray = getByteArray(1024) />
		<cfset var ZipEntry = 0 />
		<cfset var amountRead = 0 />
		<!---
			init various input streams
			The fileInputStream is our connection to the zip file.
			The ZipInputStream uses the FileInputStream to read the file and provides methods for working with data in the zip file
		--->
		<cfset FileInputStream.init(variables.zipFile) />
		<cfset ZipInputStream.init(FileInputStream) />
		
		<!---
			Zip files are composed of various entries.  getNextEntry() moves to the next entry in the zip file.
			this line moves us to the first entry.  We then check to see if this entry exists.  At the end of the 
			loop we grab the next entry.  On the next itteration CF checks to make sure that the entry exists before
			entering the loop again.
		--->
		<cfset ZipEntry = ZipInputStream.getNextEntry() />
		<cfloop condition="ZipInputStream.available() IS 1">
			<!--- check to see if this is the entry we want to extract --->
			<cfif ZipEntry.getName() IS arguments.name>
				<!---
					this is the entry, open a connection to the to file we want to write to.  This will
					create the file if it dosn't exist
				--->
				<cfset FileOutputStream.init(arguments.toPath) />
				
				<!---
					transfer data from the current ZipEntry to our FileOutputStream
					This works by reading a buffer of data out of the current zip entry and writing it into the fileoutput stream.
				--->
				<!--- the .read() method returns the amount of data read --->
				<cfset amountRead = ZipInputStream.read(ByteArray) />
				<cfloop condition="amountRead IS NOT -1">	
					<!--- write the current buffer of data to the fileoutput stream.  This will write from our ByteArray only the amount that we read from the ZipEntry --->
					<cfset FileOutputStream.write(ByteArray, 0, amountRead) />
					<cfset amountRead = ZipInputStream.read(ByteArray) />
				</cfloop>
				
				<!--- close the file we just wrote to --->
				<cfset FileOutputStream.close() />
				
				<!--- exit the loop, we know we've found the entry --->
				<cfbreak />
			</cfif>
			
			<!--- move to the next entry in the zip file --->
			<cfset ZipEntry = ZipInputStream.getNextEntry() />
		</cfloop>
		
		<!--- close the zip file --->
		<cfset ZipInputStream.close() />
	</cffunction>
	
	<cffunction name="getZipContents" returntype="query" hint="I return a query of all the files in the current zip file.">
		<cfset var ZipFile = CreateObject("Java", "java.util.zip.ZipFile").init(variables.zipFile) />
		<cfset var ZipFileEnumeration = ZipFile.entries() />
		<cfset var ZippedFile = 0 />
		<cfset var zipQuery = QueryNew("Name,IsDirectory,Size,CompressedSize,CRC") />
		
		<!--- loop over the zip file, one element at a time --->		
		<cfloop condition="#ZipFileEnumeration.hasMoreElements()#">
			<!--- grab the next element in the zip file --->
			<cfset ZippedFile = ZipFileEnumeration.nextElement() />
			<!--- add a row to our query with some details from that file --->
			<cfset QueryAddRow(zipQuery) />
			<cfset QuerySetCell(zipQuery, "Name", ZippedFile.getName()) />
			<cfset QuerySetCell(zipQuery, "IsDirectory", ZippedFile.isDirectory()) />
			<cfset QuerySetCell(zipQuery, "Size", ZippedFile.getSize()) />
			<cfset QuerySetCell(zipQuery, "CompressedSize", ZippedFile.getCompressedSize()) />
			<cfset QuerySetCell(zipQuery, "CRC", ZippedFile.getCRC()) />
		</cfloop>

		<!--- return the query --->
		<cfreturn zipQuery />		
	</cffunction>

	<!--- created by Christian Cantrell at (http://www.markme.com/cantrell/archives/004186.cfm) --->
	<cffunction name="getByteArray" access="private" returnType="binary" output="no">
		<cfargument name="size" type="numeric" required="true"/>
		<cfset var emptyByteArray = createObject("java", "java.io.ByteArrayOutputStream").init().toByteArray()/>
		<cfset var byteClass = emptyByteArray.getClass().getComponentType()/>
		<cfset var byteArray = createObject("java","java.lang.reflect.Array").newInstance(byteClass, arguments.size)/>
		
		<cfreturn byteArray/>
	</cffunction>
</cfcomponent>