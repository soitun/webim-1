build_wordpress: ${PREFIX}/wordpress/static

${PREFIX}/wordpress/static: ${PREFIX}/wordpress ${UI_DIST_DIR}/service
	@@echo "Copy static"
	@@cp -r ${UI_DIST_DIR}/service ${PREFIX}/wordpress/static
	@@echo "	"${PREFIX}/wordpress/static

${UI_DIST_DIR}/service: ${UI_DIR} 
	@@echo "Build static..."
	$(MAKE) service -C ${UI_DIR}

${PREFIX}/wordpress:
	@@git submodule update --init wordpress

clean_wordpress:
	$(MAKE) clean_service -C ${UI_DIR}
	@@echo "Removing Distribution directory:" ${PREFIX}/wordpress/static
	@@rm -rf ${PREFIX}/wordpress/static

