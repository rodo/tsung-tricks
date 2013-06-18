ERL=/usr/bin/erl
ERLC=/usr/bin/erlc

all: ebin/geoserver.beam ebin/percentile.beam

test: ebin/geoserver.beam ebin/percentile.beam
	$(ERL) -noshell -pa ./ebin -s eunit test geoserver -s init stop
	$(ERL) -noshell -pa ./ebin -s eunit test percentile -s init stop

clean:
	rm -fr ebin/*.beam


ebin/geoserver.beam: geoserver.erl
	erlc -o ebin/ $?

ebin/percentile.beam: percentile.erl
	erlc -o ebin/ $?
