PREFIX = .
UI_DIR = ${PREFIX}/ui
UI_DIST_DIR = ${UI_DIR}/dist

all: build_uchome build_discuzX build_discuz build_phpwind

clean: clean_uchome clean_discuzX clean_discuz clean_phpwind

${UI_DIR}:
	@@git submodule update --init ui

include build/uchome.mk
include build/discuzX.mk
include build/discuz.mk
include build/phpwind.mk
