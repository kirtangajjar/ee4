<?php

class EE_Test extends PHPUnit_Framework_TestCase {

	public function testLaunchProcDisabled() {
		$err_msg = 'Error: Cannot do \'launch\': The PHP functions `proc_open()` and/or `proc_close()` are disabled';

		$cmd = 'php -ddisable_functions=proc_open php/boot-fs.php --skip-wordpress eval ' . escapeshellarg( 'EE::launch( null );' ) . ' 2>&1';
		$output = array();
		exec( $cmd, $output );
		$output = trim( implode( "\n", $output ) );
		$this->assertTrue( false !== strpos( $output, $err_msg ) );

		$cmd = 'php -ddisable_functions=proc_close php/boot-fs.php --skip-wordpress eval ' . escapeshellarg( 'EE::launch( null );' ) . ' 2>&1';
		$output = array();
		exec( $cmd, $output );
		$output = trim( implode( "\n", $output ) );
		$this->assertTrue( false !== strpos( $output, $err_msg ) );
	}

	public function testGetPHPBinary() {
		$this->assertSame( EE\Utils\get_php_binary(), EE::get_php_binary() );
	}
}
