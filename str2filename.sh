#!/bin/bash

echo "$@" | iconv -f utf8 -t ascii//TRANSLIT | tr " \-[A-Z]" "__[a-z]"
