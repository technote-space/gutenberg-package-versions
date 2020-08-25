<?php
$plugins_dir = dirname( dirname( __FILE__ ) ) . '/.plugin';
if ( file_exists( "{$plugins_dir}/gutenberg" ) ) {
	$tmp = getenv( 'WP_TESTS_DIR' );
	if ( empty( $tmp ) ) {
		$tmp = rtrim( sys_get_temp_dir(), '/\\' );
	}
	$core = getenv( 'WP_CORE_DIR' );
	if ( empty( $core ) ) {
		$core = $tmp . '/wordpress/';
	}
	$test_plugins_dir = $core . 'wp-content/plugins/';

	if ( ! file_exists( "{$test_plugins_dir}/gutenberg" ) ) {
		if ( ! file_exists( $test_plugins_dir ) ) {
			mkdir( $test_plugins_dir, 0755, true );
		}
		symlink( "{$plugins_dir}/gutenberg", "{$test_plugins_dir}/gutenberg" );
	}
}

function filter_plugin( $item ) {
	if ( 'gutenberg' !== $item ) {
		return true;
	}

	return getenv( 'ACTIVATE_GUTENBERG' );
}
