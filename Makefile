PATH := ./node_modules/.bin:${PATH}

.PHONY : build test

build:
	coffee -c -o build src
	coffee -c -o test test

test: build
	mocha --recursive -R spec test/
