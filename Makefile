PATH := ./node_modules/.bin:${PATH}

.PHONY : build test

build:
	coffee -c -o build src
	coffee -c -o test test

test: build test-mocha test-coveralls

test-mocha:
	mocha --recursive -R spec test/

test-coveralls:
	@NODE_ENV="test" redis_metrics_COVERAGE=1
	mocha -r blanket -R mocha-lcov-reporter | coveralls
