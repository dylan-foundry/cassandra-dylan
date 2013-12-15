all: build

.PHONY: build test clean

build:
	dylan-compiler -build cassandra-protocol

test:
	dylan-compiler -build cassandra-test-suite-app
	_build/bin/cassandra-test-suite-app

clean:
