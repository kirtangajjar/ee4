#!/bin/bash

# called by Travis CI

set -ex

EE_BIN_DIR=${EE_BIN_DIR-/tmp/ee-phar}

# Disable XDebug to speed up Composer and test suites.
if [ -f ~/.phpenv/versions/$(phpenv version-name)/etc/conf.d/xdebug.ini ]; then
  phpenv config-rm xdebug.ini
else
  echo "xdebug.ini does not exist"
fi

composer install --no-interaction --prefer-source

CLI_VERSION=$(head -n 1 VERSION)
if [[ $CLI_VERSION == *"-alpha"* ]]
then
	GIT_HASH=$(git rev-parse HEAD)
	GIT_SHORT_HASH=${GIT_HASH:0:7}
	CLI_VERSION="$CLI_VERSION-$GIT_SHORT_HASH"
fi

# the Behat test suite will pick up the executable found in $EE_BIN_DIR
if [[ $BUILD == 'git' || $BUILD == 'sniff' ]]
then
	echo $CLI_VERSION > VERSION
else
	mkdir -p $EE_BIN_DIR
	php -dphar.readonly=0 utils/make-phar.php ee.phar --quiet --version=$CLI_VERSION
	mv ee.phar $EE_BIN_DIR/wp
	chmod +x $EE_BIN_DIR/wp
fi

echo $CLI_VERSION > PHAR_BUILD_VERSION

mysql -e 'CREATE DATABASE ee_test;' -uroot
mysql -e 'GRANT ALL PRIVILEGES ON ee_test.* TO "ee_test"@"localhost" IDENTIFIED BY "password1"' -uroot
