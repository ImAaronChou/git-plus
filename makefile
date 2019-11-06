GIT_PORCELAIN_STATUS=$(shell git status --porcelain)

check-all-commited:
	if [ -n "$(GIT_PORCELAIN_STATUS)" ]; \
	then \
	    echo 'YOU HAVE UNCOMMITED CHANGES'; \
	    git status; \
	    exit 1; \
	fi
pypi-upload: check-all-commited
	python setup.py register
	twine upload dist/*
ctags:
	ctags -R .
clean:
	rm -Rf build
	rm -Rf dist
	rm -Rf MANIFEST
pyflakes:
	pyflakes $(grep -r -l "/usr/bin/python" * */*) $(find . -name "*py")
