<?php
/**
 * @author Technote
 * @copyright Technote All Rights Reserved
 * @license http://www.opensource.org/licenses/gpl-2.0.php GNU General Public License, version 2
 * @link https://technote.space
 */

use /** @noinspection PhpUndefinedClassInspection */
	PHPUnit\Framework\TestCase;
use Technote\GutenbergPackageVersionProvider;

// @codeCoverageIgnoreStart
if ( ! defined( 'ABSPATH' ) ) {
	exit;
}
// @codeCoverageIgnoreEnd

/**
 * @noinspection PhpUndefinedClassInspection
 * GutenbergHelper test case.
 *
 * @mixin TestCase
 */
class GutenbergHelper extends WP_UnitTestCase {

	private function get_instance() {
		return new GutenbergPackageVersionProvider();
	}

	public function test_get_packages() {
		$packages = $this->get_instance()->get_packages();
		$this->assertArrayHasKey( 'v3.3.0', $packages );
		$this->assertArrayHasKey( 'v5.9.2', $packages );
		$this->assertArrayNotHasKey( 'abc', $packages );

		$packages = $this->get_instance()->get_packages( 'v3.3.0' );
		$this->assertArrayHasKey( 'wp-a11y', $packages );
		$this->assertArrayHasKey( 'wp-wordcount', $packages );
		$this->assertArrayNotHasKey( 'wp-block-editor', $packages );
		$this->assertArrayNotHasKey( 'abc', $packages );

		$packages = $this->get_instance()->get_packages( 'v5.9.2' );
		$this->assertArrayHasKey( 'wp-a11y', $packages );
		$this->assertArrayHasKey( 'wp-wordcount', $packages );
		$this->assertArrayHasKey( 'wp-block-editor', $packages );
		$this->assertArrayNotHasKey( 'abc', $packages );
	}

	public function test_get_package_version() {
		$this->assertFalse( $this->get_instance()->get_package_version( 'abc', 'wp-a11y' ) );
		$this->assertFalse( $this->get_instance()->get_package_version( 'v3.3.0', 'wp-block-editor' ) );
		$this->assertEquals( '1.1.1', $this->get_instance()->get_package_version( 'v3.3.0', 'wp-a11y' ) );
		$this->assertNotFalse( $this->get_instance()->get_package_version( 'v5.9.2', 'wp-block-editor' ) );
		$this->assertEquals( '2.3.0', $this->get_instance()->get_package_version( 'v5.9.2', 'wp-a11y' ) );
	}

	public function test_package_exists() {
		$this->assertFalse( $this->get_instance()->package_exists( 'abc', 'wp-a11y' ) );
		$this->assertFalse( $this->get_instance()->package_exists( 'v3.3.0', 'wp-block-editor' ) );
		$this->assertTrue( $this->get_instance()->package_exists( 'v3.3.0', 'wp-a11y' ) );
		$this->assertTrue( $this->get_instance()->package_exists( 'v5.9.2', 'wp-block-editor' ) );
		$this->assertTrue( $this->get_instance()->package_exists( 'v5.9.2', 'wp-a11y' ) );
	}

}
