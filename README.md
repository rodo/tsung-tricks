tsung-tricks
============

tricks and module to use with tsung.

Modules
=======

* htmlconv.erl : decode htmlentities
  
  * decode_entites/1 : replace html entities

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

Unit test
=========

Unit tests are done in CI process with Jenkins, the Makefile target
'test' builds the module in ebin-test/ and build associate
module_tests all with option export_all. The file jenkins.escript
is used by Jenkins to launch all tests using the Surefire module to
generate report in Maven style usable by Jenkins.

Ref : http://jenkins.quiedeville.org/view/Tsung/job/TsungTricks/
