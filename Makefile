#
# Makefile to build erland module in 2 ways
#
# - traditionnal way in ebin/
# - with export all to do unit test in ebin-test/
#
ERL=/usr/bin/erl
ERLC=/usr/bin/erlc

all: ebin/htmlconv.beam ebin/jsonurls.beam ebin/geoserver.beam ebin/percentile.beam ebin/randomdate.beam ebin/slippymap.beam ebin/wmsosm.beam

test: ebin-test/test_all.beam ebin-test/jsonurls.beam ebin-test/jsonurls_tests.beam ebin-test/htmlconv.beam ebin-test/htmlconv_tests.beam ebin-test/geoserver.beam ebin-test/percentile.beam ebin-test/wmsosm.beam ebin-test/slippymap.beam ebin-test/randomdate.beam ebin-test/geoserver_tests.beam ebin-test/percentile_tests.beam ebin-test/wmsosm_tests.beam ebin-test/slippymap_tests.beam ebin-test/randomdate_tests.beam

dotest: test
	$(ERL) -noshell -pa ./ebin-test -s eunit test test_all -s init stop

clean:
	rm -fr ebin/*.beam
	rm -fr ebin-test/*.beam


ebin/%.beam: %.erl
	erlc -o ebin/ $<

ebin-test/%.beam: %.erl
	erlc -pa ./ebin-test -o ebin-test/ -W0 +export_all $<
