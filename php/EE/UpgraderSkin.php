<?php

namespace EE;

/**
 * A Upgrader Skin for WordPress that only generates plain-text
 *
 * @package ee
 */
class UpgraderSkin extends \WP_Upgrader_Skin {

	public $api;

	public function header() {}
	public function footer() {}
	public function bulk_header() {}
	public function bulk_footer() {}

	public function error( $error ) {
		if ( ! $error ) {
			return;
		}

		if ( is_string( $error ) && isset( $this->upgrader->strings[ $error ] ) ) {
			$error = $this->upgrader->strings[ $error ];
		}

		// TODO: show all errors, not just the first one
		\EE::warning( $error );
	}

	public function feedback( $string ) {

		if ( isset( $this->upgrader->strings[ $string ] ) ) {
			$string = $this->upgrader->strings[ $string ];
		}

		if ( strpos( $string, '%' ) !== false ) {
			$args = func_get_args();
			$args = array_splice( $args, 1 );
			if ( ! empty( $args ) ) {
				$string = vsprintf( $string, $args );
			}
		}

		if ( empty( $string ) ) {
			return;
		}

		$string = str_replace( '&#8230;', '...', strip_tags( $string ) );
		$string = html_entity_decode( $string, ENT_QUOTES, get_bloginfo( 'charset' ) );

		\EE::log( $string );
	}
}

