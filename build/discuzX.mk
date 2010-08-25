build_discuzX: ${PREFIX}/discuzX/static

${PREFIX}/discuzX/static: ${PREFIX}/discuzX ${UI_DIST_DIR}/discuzX
	@@echo "Copy static"
	@@cp -r ${UI_DIST_DIR}/discuzX ${PREFIX}/discuzX/static
	@@echo "	"${PREFIX}/discuzX/static

${UI_DIST_DIR}/discuzX: ${UI_DIR} 
	@@echo "Build static..."
	$(MAKE) discuzX -C ${UI_DIR}

${PREFIX}/discuzX:
	@@git submodule update --init discuzX

clean_discuzX:
	$(MAKE) clean_discuzX -C ${UI_DIR}
	@@echo "Removing Distribution directory:" ${PREFIX}/discuzX/static
	@@rm -rf ${PREFIX}/discuzX/static

