#!/bin/bash
#
# tpcdsenv.sh - UNIX Environment Setup
#

#######################################################################
# Those are mandatory parameters. Please provide the location of
# spark installation and root dir of S3 bucket.
#######################################################################
export SPARK_HOME=/apps_01/udap/dlp/lib/spark
export TPCDS_S3_ROOT_DIR=s3a://tpc

#######################################################################
# Script environment parameters. When they are not set the script
# defaults to paths relative from the script directory.
#######################################################################

export TPCDS_ROOT_DIR=
export TPCDS_LOG_DIR=
export TPCDS_DBNAME=
export TPCDS_WORK_DIR=
export ADDITION_SPARK_OPTIONS=
