#!/bin/bash
set -e

key='COLOR="#'

# get 4 byte random numbers in base 16
random=`od -An -N4 -tx < /dev/urandom`

# cut out subtext from 1 to 6
color=`echo $random | cut -c 1-6`

echo "$key$color\"" > .env

exit 0