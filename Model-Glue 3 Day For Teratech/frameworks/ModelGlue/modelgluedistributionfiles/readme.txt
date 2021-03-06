Model-Glue
Joe Rinehart (joe.rinehart@gmail.com)
Model-Glue @versionLabel@ (@versionNumber@.@revisionNumber@).

Well, now you've gone and done it.  

You're probably thinking "Ok, I've downloaded it, what next?"

As the good book says:  "Don't Panic"

** URLS TO KNOW ** 

http://www.model-glue.com - The official Model-Glue web site.
http://svn.model-glue.com - The Subversion repository where you can get the latest Model-Glue code.
http://trac.model-glue.com - Model-Glue defect and feature request tracking.

** FULL DOCUMENTATION **

There are detailed installation instructions in the ModelGlue/Docs/index.html file.  Seriously.  Check it out.  About 10x more docs than were ever written for Model-Glue 1.x.

** QUICK INSTALLATION INSTRUCTIONS **

If you're impatient, this should get you started:

1. Download and install ColdSpring from http://www.coldspringframework.org.  

You may need to point a mapping named /coldspring to the directory that *contains* a folder named "beans".

2. Copy the /Reactor/reactor folder to whatever ColdFusion sees as "/Reactor".  The framework is now installed.  

You may need to point a mapping named /reactor to the directory (/Reactor/reactor) that contains reactorFactory.cfc.

3. Copy the ModelGlue folder to whatever ColdFusion sees as "/ModelGlue".  The framework is now installed.  

You may need to point a mapping named /ModelGlue to the directory (/ModelGlue) that contains ModelGlue.cfm.

4. Copy the modelgluesamples folder to /modelgluesamples.  The samples are now installed.

5. Run some samples - try http://[host]/modelgluesamples/legacysamples/nameuppercaser or http://[host]/modelgluesamples/legacysamples/contactmanager.

** WHEN THINGS BREAK **

Visit http://trac.model-glue.com, click the "New Ticket" button, and fill out the form.  For anything you fill out, put the following, or it'll likely wind up at the bottom of the queue:

1.  Exactly what you did
2.  What happened (include exceptions, stack traces, sample code, etc.!)
3.  What you thought should of happened

** BETA DISCLOSURE **

This is beta software.  It's going to break down here and there.  There's even a few features (like request pool size control and hierarchial bean factories) that aren't even implemented.

If something doesn't work, please follow the 'WHEN THINGS BREAK' directions:  it will get fixed.


** LICENSE INFORMATION **

Until Thursday, January 4, 2007, Model-Glue was released under for Lesser GPL (LGPL).

In order to maintain clean licensure of generated code, it has been moved to the 
Apache Software License 2.0 (ASL2).

Use of any third party frameworks, such as ColdSpring, Transfer, or Reactor falls
under the respecitve framework's license.

