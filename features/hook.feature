Feature: Tests `EE::add_hook()`

  Scenario: Add callback to the `before_invoke`
    Given a WP installation
    And a before-invoke.php file:
      """
      <?php
      $callback = function() {
        EE::log( '`add_hook()` to the `before_invoke` is working.');
      };

      EE::add_hook( 'before_invoke:plugin list', $callback );
      """
    And a ee.yml file:
      """
      require:
        - before-invoke.php
      """

    When I run `wp plugin list`
    Then STDOUT should contain:
      """
      `add_hook()` to the `before_invoke` is working.
      """
    And the return code should be 0

  Scenario: Add callback to the `before_invoke`
    Given a WP installation
    And a before-invoke.php file:
      """
      <?php
      $callback = function() {
        EE::log( '`add_hook()` to the `before_invoke` is working.');
      };

      EE::add_hook( 'before_invoke:db check', $callback );
      """
    And a ee.yml file:
      """
      require:
        - before-invoke.php
      """

    When I run `wp db check`
    Then STDOUT should contain:
      """
      `add_hook()` to the `before_invoke` is working.
      """
    And the return code should be 0

  Scenario: Add callback to the `before_invoke`
    Given a WP installation
    And a before-invoke.php file:
      """
      <?php
      $callback = function() {
        EE::log( '`add_hook()` to the `before_invoke` is working.');
      };

      EE::add_hook( 'before_invoke:core version', $callback );
      """
    And a ee.yml file:
      """
      require:
        - before-invoke.php
      """

    When I run `wp core version`
    Then STDOUT should contain:
      """
      `add_hook()` to the `before_invoke` is working.
      """
    And the return code should be 0
