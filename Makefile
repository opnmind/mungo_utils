.PHONY: help, g0v2, c1, all, install, clean, remove

VENV=./.venv
PYTHON=python2
MUNGO_UTILS_BIN=./mungo_utils.py

ifndef INPUT:
INPUT=./input
endif

ifndef OUTPUT:
OUTPUT=./output
endif

ifndef MODULE:
MODULE=G0
endif

help:
	@echo make install
	@echo make g0v2
	@echo make c1
	@echo make all
	@echo make clean
	@echo make remove

resample:
	mkdir -p $(OUTPUT)
	. $(VENV)/bin/activate && $(PYTHON) $(MUNGO_UTILS_BIN) -I $(INPUT) -O $(OUTPUT) -T $(MODULE)

resample-c1: MODULE=C1
resample-c1: resample

concat:
	mkdir -p $(OUTPUT)
	. $(VENV)/bin/activate && $(PYTHON) $(MUNGO_UTILS_BIN) -I $(INPUT) -O $(OUTPUT) -T $(MODULE) -c

concat-c1: MODULE=C1
concat-c1: concat

install-debian:
	sudo apt install python-tk ffmpeg gcc -y

install:
	virtualenv -p /usr/bin/$(PYTHON) $(VENV)
	. $(VENV)/bin/activate && pip install -r requirements.txt

remove:
	rm -rf $(VENV)

clean:
	rm -rf $(OUTPUT)/*
