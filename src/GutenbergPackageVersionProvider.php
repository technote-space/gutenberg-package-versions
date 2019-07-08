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
			$target = 'wp-core';
		}
		$this->target = $target;
	}

	/**
	 * @param array $segments
	 *
	 * @return string
	 */
	public function get_data_path( ...$segments ) {
		if ( ! isset( static::$path ) ) {
			static::$path = dirname( dirname( __FILE__ ) ) . DIRECTORY_SEPARATOR . 'data' . DIRECTORY_SEPARATOR;
		}

		return static::$path . $this->target . DIRECTORY_SEPARATOR . implode( DIRECTORY_SEPARATOR, $segments );
	}

	/**
	 * @param string $key
	 *
	 * @return array
	 */
	private function get_cache( $key ) {
		if ( isset( static::$cache[ $this->target ][ $key ] ) ) {
			return [ true, static::$cache[ $this->target ][ $key ] ];
		}

		return [ false, null ];
	}

	/**
	 * @param string $key
	 * @param mixed $value
	 */
	private function set_cache( $key, $value ) {
		static::$cache[ $this->target ][ $key ] = $value;
	}

	/**
	 * @param string $tag
	 *
	 * @return string
	 */
	public function normalize_tag( $tag ) {
		$tag = preg_replace( '#\Av\.?#', '', $tag );
		while ( substr_count( $tag, '.' ) < 2 ) {
			$tag .= '.0';
		}

		return $tag;
	}

	/**
	 * @return array
	 */
	public function get_tags() {
		list( $result, $tags ) = $this->get_cache( 'tags' );
		if ( ! $result ) {
			$tags = json_decode( $this->get_fs()->get_contents( $this->get_data_path( 'tags.json' ) ), true );
			$this->set_cache( 'tags', $tags );
		}

		return $tags;
	}

	/**
	 * @param string|null $tag
	 *
	 * @return array|null
	 */
	public function get_versions( $tag = null ) {
		list( $result, $versions ) = $this->get_cache( 'versions' );
		if ( ! $result ) {
			$versions = json_decode( $this->get_fs()->get_contents( $this->get_data_path( 'versions.json' ) ), true );
			$this->set_cache( 'versions', $versions );
		}

		if ( ! isset( $tag ) ) {
			return $versions;
		}

		$tag = $this->normalize_tag( $tag );
		if ( isset( $versions[ $tag ] ) ) {
			return $versions[ $tag ];
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
		$versions = $this->get_versions( $tag );

		if ( isset( $versions[ $package ] ) ) {
			return $versions[ $package ];
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
		$versions = $this->get_versions( $tag );

		return isset( $versions[ $package ] );
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
