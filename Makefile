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


help:
	@echo make install
	@echo make g0v2
	@echo make c1
	@echo make all
	@echo make clean
	@echo make remove

g0v2:
	mkdir -p $(OUTPUT)
	source $(VENV)/bin/activate && $(PYTHON) $(MUNGO_UTILS_BIN) -I $(INPUT) -O $(OUTPUT) -T GV02

c1:
	source $(VENV)/bin/activate && $(PYTHON) $(MUNGO_UTILS_BIN) -I $(INPUT) -O $(OUTPUT) -T C1

all: g0v2 c1

c1-normalize:
	mkdir -p $(OUTPUT)-norm
	source $(VENV)/bin/activate && \
	$(PYTHON) $(MUNGO_UTILS_BIN) -I $(INPUT) -O $(OUTPUT)-norm -T C1 -n \
	&& \
	$(PYTHON) $(MUNGO_UTILS_BIN) -I $(OUTPUT)-norm -O $(OUTPUT) -T C1
	rm -rf $(OUTPUT)-norm

install:
	virtualenv -p /usr/bin/$(PYTHON) $(VENV)
	source $(VENV)/bin/activate && pip install -r requirements.txt

remove:
	rm -rf $(VENV)

clean:
	rm -rf $(OUTPUT)/*