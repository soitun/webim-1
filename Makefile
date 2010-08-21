PREFIX = .
UI_DIR = ${PREFIX}/ui
UI_DIST_DIR = ${UI_DIR}/dist

all: build_uchome

build_uchome: ${PREFIX}/uchome/static

${PREFIX}/uchome/static: ${PREFIX}/uchome ${UI_DIST_DIR}/uchome
	@@echo "Copy static"
	@@cp -r ${UI_DIST_DIR}/uchome ${PREFIX}/uchome/static
	@@echo "	"${PREFIX}/uchome/static

${UI_DIST_DIR}/uchome: ${UI_DIR} 
	@@echo "Build static..."
	$(MAKE) uchome -C ${UI_DIR}

${PREFIX}/uchome:
	@@git submodule update --init uchome

${UI_DIR}:
	@@git submodule update --init ui

clean: clean_uchome

clean_uchome:
	$(MAKE) clean_uchome -C ${UI_DIR}
	@@echo "Removing Distribution directory:" ${PREFIX}/uchome/static
	@@rm -rf ${PREFIX}/uchome/static

