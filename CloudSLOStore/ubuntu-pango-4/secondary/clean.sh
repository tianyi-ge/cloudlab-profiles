#!/bin/sh

kill -9 `pidof mongod`
rm -rf db*
