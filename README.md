tsung-tricks
============

tricks and module to use with tsung.

Modules
=======

* randomdate.erl : generate random date 

  * get_date/1 : return url encode date as byte string like <<"7%2F1%2F2013">>

* samplemod.erl : a sample module to show how to use ts_dynvars:lookup

* wmsosm.erl : generate random tile number to use with OpenStreetMap

* wms_randomcoord.erl : 

  * url/0 : generate random url with coordinates, return a string in form lat=X.XX&lon=Y.YY

Tools
=====

* tsung.el : some functions to use with emacs

See also
========

* tsung2graphite https://gitorious.org/tsung2graphite
