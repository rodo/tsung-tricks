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

* typeahead.erl : **MOVED** See https://github.com/rodo/tsung-typeahead

Tools
=====

* tsung.el : some functions to use with emacs

* jmeter2tsung.xsl : xsl sheet to transform a jmeter's scenario in
  .jmx format to a tsung .xml file

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

Dependencies
============

geoserver.erl uses
[proj4erl](https://github.com/greenelephantlabs/proj4erl)
