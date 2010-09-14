build_phpbb: ${PREFIX}/phpbb/static

${PREFIX}/phpbb/static: ${PREFIX}/phpbb ${UI_DIST_DIR}/phpbb
	@@echo "Copy static"
	@@cp -r ${UI_DIST_DIR}/phpbb ${PREFIX}/phpbb/static
	@@echo "	"${PREFIX}/phpbb/static

${UI_DIST_DIR}/phpbb: ${UI_DIR} 
	@@echo "Build static..."
	$(MAKE) phpbb -C ${UI_DIR}

${PREFIX}/phpbb:
	@@git submodule update --init phpbb

clean_phpbb:
	$(MAKE) clean_phpbb -C ${UI_DIR}
	@@echo "Removing Distribution directory:" ${PREFIX}/phpbb/static
	@@rm -rf ${PREFIX}/phpbb/static

