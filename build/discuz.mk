build_discuz: ${PREFIX}/discuz/static

${PREFIX}/discuz/static: ${PREFIX}/discuz ${UI_DIST_DIR}/discuz
	@@echo "Copy static"
	@@cp -r ${UI_DIST_DIR}/discuz ${PREFIX}/discuz/static
	@@echo "	"${PREFIX}/discuz/static

${UI_DIST_DIR}/discuz: ${UI_DIR} 
	@@echo "Build static..."
	$(MAKE) discuz -C ${UI_DIR}

${PREFIX}/discuz:
	@@git submodule update --init discuz

clean_discuz:
	$(MAKE) clean_discuz -C ${UI_DIR}
	@@echo "Removing Distribution directory:" ${PREFIX}/discuz/static
	@@rm -rf ${PREFIX}/discuz/static

