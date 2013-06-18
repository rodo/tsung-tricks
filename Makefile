ERL=/usr/bin/erl
ERLC=/usr/bin/erlc

all: ebin/geoserver.beam ebin/percentile.beam ebin/wmsosm.beam ebin/slippymap.beam ebin/randomdate.beam

test: ebin-test/geoserver.beam ebin-test/percentile.beam ebin-test/wmsosm.beam ebin-test/slippymap.beam ebin-test/randomdate.beam ebin-test/geoserver_tests.beam ebin-test/percentile_tests.beam ebin-test/wmsosm_tests.beam ebin-test/slippymap_tests.beam ebin-test/randomdate_tests.beam

dotest:
	$(ERL) -noshell -pa ./ebin-test -s eunit test geoserver -s init stop
	$(ERL) -noshell -pa ./ebin-test -s eunit test percentile -s init stop

clean:
	rm -fr ebin/*.beam
	rm -fr ebin-test/*.beam


ebin/%.beam: %.erl
	erlc -o ebin/ $<

ebin-test/%.beam: %.erl
	erlc -pa ./ebin-test -o ebin-test/ -W0 +export_all $<

