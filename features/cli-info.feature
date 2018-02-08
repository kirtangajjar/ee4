Feature: Review CLI information

  Background:
    When I run `wp package path`
    Then save STDOUT as {PACKAGE_PATH}

  Scenario: Get the path to the packages directory
    Given an empty directory
	And a non-existent {PACKAGE_PATH} directory

    When I run `wp cli info --format=json`
    Then STDOUT should be JSON containing:
      """
      {"ee_packages_dir_path":null}
      """

    When I run `wp package install danielbachhuber/ee-reset-post-date-command`
    Then STDERR should be empty

    When I run `wp cli info --format=json`
    Then STDOUT should be JSON containing:
      """
      {"ee_packages_dir_path":"{PACKAGE_PATH}"}
      """

    When I run `wp cli info`
    Then STDOUT should contain:
      """
      EE packages dir:
      """

  Scenario: Packages directory path should be slashed correctly
    When I run `EE_PACKAGES_DIR=/foo wp package path`
    Then STDOUT should be:
      """
      /foo/
      """

    When I run `EE_PACKAGES_DIR=/foo/ wp package path`
    Then STDOUT should be:
      """
      /foo/
      """

    When I run `EE_PACKAGES_DIR=/foo\\ wp package path`
    Then STDOUT should be:
      """
      /foo/
      """
