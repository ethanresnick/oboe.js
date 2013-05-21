#!/bin/bash

# Since the grunt jstd plugin doesn't support v3, here's a little
# shell script to do the same. Usage is:
#
#   build.sh            # run all tests
#   build.sh foo.bar    # build but only run test foo.bar

# Edit these variables to suit your install:
JSTD_JAR=~/dev/jstestdriver/JsTestDriver-1.3.5.jar
SERVER=http://localhost:4224
BASEPATH=~/Sites/progressivejson/

function test {
   echo "Will run oboe json tests(" ${TESTS} ") against $1"
   java -jar ${JSTD_JAR} --captureConsole --config test/jsTestDriver-${1}.conf --server ${SERVER} --tests ${TESTS} --basePath ${BASEPATH} --reset   
}

if [ "$1" ] ; then
  TESTS=$1
else
  echo "no tests specified, will run all"
  TESTS=all
fi

echo "building at $(date)"

test dev
 
env grunt 

test concat 

test minified 

mv dist/oboe.concat.js dist/oboe.js 

