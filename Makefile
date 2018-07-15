.PHONY: help clean dev docs package test

help:
	@echo "This project assumes that an active Python virtualenv is present."
	@echo "The following make targets are available:"
	@echo "	 dev 	install all deps for dev env"
	@echo "  docs	create pydocs for all relveant modules"
	@echo "	 test	run all tests with coverage"

clean:
	rm -rf dist/*

dev:
	pip install setuptools>=38.6.0
	pip install wheel>=0.31.0
	pip install wheel
	pip install coverage
	pip install codecov
	pip install pylint
	pip install twine
	pip install sphinx
	pip install sphinx-autobuild
	pip install sphinx_rtd_theme
	pip install tox
	pip install -e .

docs:
	$(MAKE) -C docs html

package:
	python setup.py sdist
	python setup.py bdist_wheel

test:
	coverage run -m unittest discover --start-directory tests/unit
	coverage html

test_rinkeby:
	coverage run -m unittest discover --start-directory tests/integration/rinkeby
	coverage html

test_request_network_js:
	coverage run -m unittest discover --start-directory tests/integration/request_network_js
	coverage html

lint:
	tox -e lint

prepare_release: clean lint package
