Widget Central example.

This directory contains the same application implemented with both the Reactor 
and Transfer ORMs.  The /install directory contains a .SQL script to create
the database on MySQL 5.0:  it's only four tables, so changing this to suit
your DB of choice should be fairly straightforward.

The example application itself shows how to scaffold, represent one-to-many,
many-to-one, and many-to-many relationships, as well as use Generic Database
Messages to fire custom gateway methods.

To install:

1.  Create a database and run the install script against it.
2.  Create a datasource named "Widget" pointed to the database
3.  Run either the /reactor or /transfer version of the application.

BETA 2 Warning:

All of the issues with attempting to distribute Reactor and Transfer based
applications that already contain ORM-generated code are not known.  I expect
some of the first people trying this will be posting Trac tickets at 
http://trac.model-glue.com.  Thanks.

Even more thanks if you post the fix to whatever goes wrong ;).

-Joe
