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

clean_uchome:
	$(MAKE) clean_uchome -C ${UI_DIR}
	@@echo "Removing Distribution directory:" ${PREFIX}/uchome/static
	@@rm -rf ${PREFIX}/uchome/static

