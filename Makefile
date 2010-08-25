PREFIX = .
UI_DIR = ${PREFIX}/ui
UI_DIST_DIR = ${UI_DIR}/dist

all: build_uchome build_discuzX

clean: clean_uchome clean_discuzX

${UI_DIR}:
	@@git submodule update --init ui

include build/uchome.mk
include build/discuzX.mk
