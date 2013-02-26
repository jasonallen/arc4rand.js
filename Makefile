MOCHA := ${CURDIR}/node_modules/.bin/mocha
COFFEE := ${CURDIR}/node_modules/.bin/coffee

main: lib/arc4rand.js

lib/arc4rand.js: src/arc4rand.coffee
	$(COFFEE) -b -o ${CURDIR}/lib/ -c src/*.coffee

clean:
	rm ${CURDIR}/lib/*

.PHONY: test
test: lib/arc4rand.js
	$(MOCHA) -r should --compilers coffee:coffee-script test/*

