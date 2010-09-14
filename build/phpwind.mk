build_phpwind: ${PREFIX}/phpwind/static

${PREFIX}/phpwind/static: ${PREFIX}/phpwind ${UI_DIST_DIR}/phpwind
	@@echo "Copy static"
	@@cp -r ${UI_DIST_DIR}/phpwind ${PREFIX}/phpwind/static
	@@echo "	"${PREFIX}/phpwind/static

${UI_DIST_DIR}/phpwind: ${UI_DIR} 
	@@echo "Build static..."
	$(MAKE) phpwind -C ${UI_DIR}

${PREFIX}/phpwind:
	@@git submodule update --init phpwind

clean_phpwind:
	$(MAKE) clean_phpwind -C ${UI_DIR}
	@@echo "Removing Distribution directory:" ${PREFIX}/phpwind/static
	@@rm -rf ${PREFIX}/phpwind/static

