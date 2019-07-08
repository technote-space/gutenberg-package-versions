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

	private function get_instance( $target = 'gutenberg' ) {
		return new GutenbergPackageVersionProvider( $target );
	}

	public function test_get_tags() {
		$tags = $this->get_instance()->get_tags();
		$this->assertNotEmpty( $tags );
		$this->assertContainsOnly( 'string', $tags );

		$tags = $this->get_instance( 'wp' )->get_tags();
		$this->assertNotEmpty( $tags );
		$this->assertContainsOnly( 'string', $tags );
	}

	public function test_get_versions() {
		$packages = $this->get_instance()->get_versions();
		$this->assertArrayHasKey( '3.3.0', $packages );
		$this->assertArrayHasKey( '5.9.2', $packages );
		$this->assertArrayNotHasKey( 'abc', $packages );

		$packages = $this->get_instance()->get_versions( '3.3.0' );
		$this->assertArrayHasKey( 'wp-a11y', $packages );
		$this->assertArrayHasKey( 'wp-wordcount', $packages );
		$this->assertArrayNotHasKey( 'wp-block-editor', $packages );
		$this->assertArrayNotHasKey( 'abc', $packages );

		$packages = $this->get_instance()->get_versions( '5.9.2' );
		$this->assertArrayHasKey( 'wp-a11y', $packages );
		$this->assertArrayHasKey( 'wp-wordcount', $packages );
		$this->assertArrayHasKey( 'wp-block-editor', $packages );
		$this->assertArrayNotHasKey( 'abc', $packages );

		$this->assertEmpty( $this->get_instance()->get_versions( '5.2.1' ) );
		$this->assertNotEmpty( $this->get_instance( 'wp' )->get_versions( '5.2.1' ) );
	}

	public function test_get_package_version() {
		$this->assertFalse( $this->get_instance()->get_package_version( 'abc', 'wp-a11y' ) );
		$this->assertFalse( $this->get_instance()->get_package_version( '3.3.0', 'wp-block-editor' ) );
		$this->assertEquals( '1.1.1', $this->get_instance()->get_package_version( '3.3.0', 'wp-a11y' ) );
		$this->assertNotFalse( $this->get_instance()->get_package_version( '5.9.2', 'wp-block-editor' ) );
		$this->assertEquals( '2.3.0', $this->get_instance()->get_package_version( '5.9.2', 'wp-a11y' ) );

		$this->assertFalse( $this->get_instance()->get_package_version( '5.1.0', 'wp-block-editor' ) );
		$this->assertEquals( '1.0.0-alpha.0', $this->get_instance()->get_package_version( '5.2.0', 'wp-block-editor' ) );
		$this->assertFalse( $this->get_instance( 'wp' )->get_package_version( '5.1.0', 'wp-block-editor' ) );
		$this->assertEquals( '2.0.1', $this->get_instance( 'wp' )->get_package_version( '5.2.0', 'wp-block-editor' ) );
	}

	public function test_package_exists() {
		$this->assertFalse( $this->get_instance()->package_exists( 'abc', 'wp-a11y' ) );
		$this->assertFalse( $this->get_instance()->package_exists( '3.3.0', 'wp-block-editor' ) );
		$this->assertTrue( $this->get_instance()->package_exists( '3.3.0', 'wp-a11y' ) );
		$this->assertTrue( $this->get_instance()->package_exists( '5.9.2', 'wp-block-editor' ) );
		$this->assertTrue( $this->get_instance()->package_exists( '5.9.2', 'wp-a11y' ) );

		$this->assertFalse( $this->get_instance( 'wp' )->package_exists( '5.1.1', 'wp-block-editor' ) );
		$this->assertTrue( $this->get_instance( 'wp' )->package_exists( '5.2.0', 'wp-block-editor' ) );
	}

}
