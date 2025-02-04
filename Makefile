MOCHA_OPTS= --check-leaks
VERSION = $(shell node -e 'console.log(require("./package.json").version)')
PACKAGE_NAME = $(shell node -e 'console.log(require("./package.json").name)')

all: build test

check: test

build:
	npm install

test: jshint test-unit

test-unit:
	@NODE_ENV=test ./node_modules/.bin/mocha \
	  $(MOCHA_OPTS)

jshint:
	@./node_modules/.bin/jshint index.js

package: clean test
	npm pack

clean:
	rm -rf node_modules
	rm -f $(PACKAGE_NAME)*.tgz

.PHONY: all check build test test-unit jshint package clean
