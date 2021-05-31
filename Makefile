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
	@echo make install-debian
	@echo 
	@echo make resample MODULE=G0
	@echo or
	@echo make resample-g0
	@echo make resample-g0v2
	@echo make resample-c1
	@echo 
	@echo make concat MODULE=G0
	@echo or
	@echo make concat-g0
	@echo make concat-c1
	@echo 
	@echo make clean
	@echo make remove

resample:
	mkdir -p $(OUTPUT)
	. $(VENV)/bin/activate && $(PYTHON) $(MUNGO_UTILS_BIN) -I $(INPUT) -O $(OUTPUT) -T $(MODULE)

resample-g0: MODULE=G0
resample-g0: resample

resample-g0: MODULE=G0V2
resample-g0: resample

resample-c1: MODULE=C1
resample-c1: resample

concat:
	mkdir -p $(OUTPUT)
	. $(VENV)/bin/activate && $(PYTHON) $(MUNGO_UTILS_BIN) -I $(INPUT) -O $(OUTPUT) -T $(MODULE) -c

concat-g0: MODULE=G0
concat-g0: concat

concat-c1: MODULE=C1
concat-c1: concat

install-debian:
	sudo apt install python-tk ffmpeg -y

install:
	virtualenv -p /usr/bin/$(PYTHON) $(VENV)
	. $(VENV)/bin/activate && pip install -r requirements.txt

remove:
	rm -rf $(VENV)

clean:
	rm -rf $(OUTPUT)/*
	rm -f *.pyc
