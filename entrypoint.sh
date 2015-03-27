#!/bin/bash
set -e

CONFIG="/opt/kippo-graph/config.php"

: ${KIPPO_DB_USER:=root}
: ${KIPPO_DB_NAME:=kippo}

if [ -n "$MYSQL_PORT_3306_TCP" ]; then
	KIPPO_DB_HOST='mysql'
	KIPPO_DB_PORT='3306'
	KIPPO_DB_PASSWORD=$MYSQL_ENV_MYSQL_ROOT_PASSWORD
fi

if [ -z "$KIPPO_DB_HOST" ]; then
	echo >&2 'error: missing KIPPO_DB_HOST and MYSQL_PORT_3306_TCP environment variables'
	echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
	echo >&2 '  with -e KIPPO_DB_HOST=hostname'
	exit 1
fi

if [ -z "$KIPPO_DB_PORT" ]; then
	echo >&2 'error: missing KIPPO_DB_PORT and MYSQL_PORT_3306_TCP environment variables'
	echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
	echo >&2 '  with -e KIPPO_DB_PORT=port'
	exit 1
fi

if [ -z "$KIPPO_DB_PASSWORD" ]; then
	echo >&2 'error: missing KIPPO_DB_PASSWORD and MYSQL_PORT_3306_TCP environment variables'
	echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
	echo >&2 '  with -e KIPPO_DB_PASSWORD=password'
	exit 1
fi

set_config() {
	key="$1"
	value="$2"
	php_escaped_value="$(php -r 'var_export($argv[1]);' "$value")"
	sed_escaped_value="$(echo "$php_escaped_value" | sed 's/[\/&]/\\&/g')"
	sed -ri "s/((['\"])$key\2\s*,\s*)(['\"]).*\3/\1$sed_escaped_value/" $CONFIG
}

set_config 'DB_HOST' "$KIPPO_DB_HOST"
set_config 'DB_NAME' "$KIPPO_DB_NAME"
set_config 'DB_PASS' "$KIPPO_DB_PASSWORD"
set_config 'DB_USER' "$KIPPO_DB_USER"
set_config 'DB_PORT' "$KIPPO_DB_PORT"

exec "$@"
