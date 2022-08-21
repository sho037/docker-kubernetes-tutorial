#!/bin/bash
set -e

key='COLOR="#'

random=`od -An -N4 -tx < /dev/urandom`

color=`echo $random | cut -c 1-6`

echo "$key$color\"" > .env

. /usr/local/bin/docker-php-entrypoint apache2-foreground