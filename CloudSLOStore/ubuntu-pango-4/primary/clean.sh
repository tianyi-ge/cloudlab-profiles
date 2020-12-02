#!/bin/sh

kill -9 `pidof mongod` `pidof mongodec`
rm -rf db*
