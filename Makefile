#
# Makefile to build erland module in 2 ways
#
# - traditionnal way in ebin/
# - with export_all to do unit test in ebin-test/
#
ERL=/usr/bin/erl
ERLC=/usr/bin/erlc

all: ebin/htmlconv.beam ebin/jsonurls.beam ebin/percentile.beam ebin/randomdate.beam ebin/typeahead.beam

dial: ebin-debug/htmlconv.dial ebin-debug/jsonurls.dial ebin-debug/percentile.dial ebin-debug/randomdate.dial ebin-debug/typeahead.dial

test: ebin-test/test_all.beam ebin-test/jsonurls.beam ebin-test/jsonurls_tests.beam ebin-test/htmlconv.beam ebin-test/htmlconv_tests.beam ebin-test/percentile.beam ebin-test/randomdate.beam ebin-test/percentile_tests.beam ebin-test/randomdate_tests.beam ebin-test/typeahead_tests.beam ebin-test/typeahead.beam

dotest: test
	$(ERL) -noshell -pa ./ebin-test -s eunit test test_all -s init stop

clean:
	rm -f *.beam
	rm -fr ebin/*.beam
	rm -fr ebin-test/*.beam
	rm -fr ebin-debug/*.dial
	rm -fr ebin-debug/*.beam

ebin/%.beam: %.erl
	erlc -o ebin/ $<

ebin-test/%.beam: %.erl
	erlc -pa ./ebin-test -o ebin-test/ -W0 +export_all $<

ebin-debug/%.beam: %.erl
	erlc -pa ./ebin-debug -o ebin-debug/ -W0 +debug_info $<

ebin-debug/%.dial: ebin-debug/%.beam
	dialyzer --build_plt -pa ./ebin-debug -o $@ $<


