<cfoutput>
<h1>Sample Model-Glue Application</h1>

#viewCollection.getView("body")#

<p>
Model-Glue is copyright #datePart("yyyy", now())#, Joe Rinehart, http://clearsoftware.net.
</p>
</cfoutput>

<!---

<h2>Some Basics about Views</h2>

<em>
When in a view, you have two collections available to you.  
</em>

<p>
<strong>ViewState</strong> contains everything from FORM, URL, or any value set by using arguments.event.SetStateValue() in a controller.
</p>
<p>
<strong>ViewCollection</strong> contains contains rendered HTML from views that have rendered before the current view.
</p>
<p>CFDumps of the current values of both, and then the public interface of both follow.</p>
<cfdump var="#viewState.getAll()#" label="Everything in the viewstate">
<br />
<cfdump var="#viewCollection.getAll()#" label="Everything in the viewcollection">
<br />
<cfdump var="#viewState#" expand="false">
<br />
<cfdump var="#viewCollection#" expand="false">
--->
