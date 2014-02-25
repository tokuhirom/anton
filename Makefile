all:
	pod2markdown < anton > README.md

test:
	prove -lrv t

.PHONY: all test
