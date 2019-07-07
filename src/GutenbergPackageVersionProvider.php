<?php
/**
 * @author Technote
 * @copyright Technote All Rights Reserved
 * @license http://www.opensource.org/licenses/gpl-2.0.php GNU General Public License, version 2
 * @link https://technote.space
 */

namespace Technote;

use WP_Filesystem_Direct;

// @codeCoverageIgnoreStart
if ( ! defined( 'ABSPATH' ) ) {
	exit;
}
// @codeCoverageIgnoreEnd

/**
 * Class GutenbergPackageVersionProvider
 * @package Technote
 */
class GutenbergPackageVersionProvider {

	/** @var array $cache */
	protected static $cache;

	/** @var WP_Filesystem_Direct $fs_cache */
	protected static $fs_cache;

	/** @var string $path */
	protected static $path;

	/** @var string $target */
	protected $target;

	/**
	 * GutenbergPackageVersionProvider constructor.
	 *
	 * @param string $target
	 */
	public function __construct( $target = 'gutenberg' ) {
		$target = strtolower( $target );
		if ( 'gutenberg' !== $target ) {
			$target = 'wp';
		}
		$this->target = $target;
	}

	/**
	 * @return string
	 */
	public function get_data_path() {
		if ( ! isset( static::$path ) ) {
			static::$path = dirname( dirname( __FILE__ ) ) . DIRECTORY_SEPARATOR . 'data' . DIRECTORY_SEPARATOR;
		}

		return static::$path;
	}

	/**
	 * @param string|null $tag
	 *
	 * @return array|null
	 */
	public function get_packages( $tag = null ) {
		if ( ! isset( static::$cache[ $this->target ] ) ) {
			static::$cache[ $this->target ] = json_decode( $this->get_fs()->get_contents( static::get_data_path() . $this->target . '-versions.json' ), true );
		}

		if ( ! isset( $tag ) ) {
			return static::$cache[ $this->target ];
		}

		if ( isset( static::$cache[ $this->target ][ $tag ] ) ) {
			return static::$cache[ $this->target ][ $tag ];
		}

		return null;
	}

	/**
	 * @param string $tag
	 * @param string $package
	 *
	 * @return string|false
	 */
	public function get_package_version( $tag, $package ) {
		$packages = $this->get_packages( $tag );

		if ( isset( $packages[ $package ] ) ) {
			return $packages[ $package ];
		}

		return false;
	}

	/**
	 * @param string $tag
	 * @param string $package
	 *
	 * @return bool
	 */
	public function package_exists( $tag, $package ) {
		$packages = $this->get_packages( $tag );

		return isset( $packages[ $package ] );
	}

	/**
	 * @return WP_Filesystem_Direct
	 */
	protected function get_fs() {
		if ( ! static::$fs_cache ) {
			// @codeCoverageIgnoreStart
			if ( ! class_exists( '\WP_Filesystem_Base' ) ) {
				/** @noinspection PhpIncludeInspection */
				require_once ABSPATH . 'wp-admin/includes/class-wp-filesystem-base.php';
			}
			if ( ! class_exists( '\WP_Filesystem_Direct' ) ) {
				/** @noinspection PhpIncludeInspection */
				require_once ABSPATH . 'wp-admin/includes/class-wp-filesystem-direct.php';
			}

			// @see ABSPATH . 'wp-admin/includes/file.php' WP_Filesystem
			if ( ! defined( 'FS_CHMOD_DIR' ) ) {
				define( 'FS_CHMOD_DIR', file_exists( ABSPATH ) ? ( fileperms( ABSPATH ) & 0777 | 0755 ) : 0755 );
			}
			if ( ! defined( 'FS_CHMOD_FILE' ) ) {
				define( 'FS_CHMOD_FILE', file_exists( ABSPATH . 'index.php' ) ? ( fileperms( ABSPATH . 'index.php' ) & 0777 | 0644 ) : 0644 );
			}
			// @codeCoverageIgnoreEnd

			static::$fs_cache = new WP_Filesystem_Direct( false );
		}

		return static::$fs_cache;
	}
}
