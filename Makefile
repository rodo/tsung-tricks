ERL=/usr/bin/erl
ERLC=/usr/bin/erlc

all: ebin/geoserver.beam ebin/percentile.beam ebin/wmsosm.beam ebin/slippymap.beam ebin/randomdate.beam

test: ebin/geoserver.beam ebin/percentile.beam
	$(ERL) -noshell -pa ./ebin -s eunit test geoserver -s init stop
	$(ERL) -noshell -pa ./ebin -s eunit test percentile -s init stop

clean:
	rm -fr ebin/*.beam


ebin/geoserver.beam: geoserver.erl
	erlc -o ebin/ $?

ebin/percentile.beam: percentile.erl
	erlc -o ebin/ $?

ebin/wmsosm.beam: wmsosm.erl
	erlc -o ebin/ $?

ebin/slippymap.beam: slippymap.erl
	erlc -o ebin/ $?

ebin/randomdate.beam: randomdate.erl
	erlc -o ebin/ $?
