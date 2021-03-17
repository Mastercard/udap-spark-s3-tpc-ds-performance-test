# udap-spark-s3-tpc-ds-performance-test
Explore Spark SQL with S3 object storage and its performance using TPC-DS workload 
A enhanced fork version with s3 object storage feature from https://github.com/IBM/spark-tpc-ds-performance-test

## Flow
* Commandline
  1. Create the spark tables with pre-generated dataset.
  2. Run the entire query set or a subset of queries and monitor the results.


## Required Components before run this projects

* Apache Spark ,prefer 2.4+ version
* Apache Hive (MetaStore) ,prefer 3.1.2 ,the spark should integrate with Hive MetaStore
* Open Source distributed Object Storage with S3 compatiable API,such as minio https://github.com/minio/minio
* Hadoop Yarn ( optional),prefer 3.2.x , or you can run standalone Spark with Hive MetaStore integration  

# Steps

## Run locally
1. [Clone the repository](#1-clone-the-repository)
2. [Create bucket at object storage and copy data files into the bucket](#2-create bucket andcopy data files )
3. [Run the script](#2-run-the-script)

### 1. Clone the repository

Clone the `udap-spark-s3-tpc-ds-performance-test` repo locally. In a terminal, run:

``` 
$ git clone https://github.com/Mastercard/udap-spark-s3-tpc-ds-performance-test.git 
```

### 2. Create bucket at object storage and copy data files into the bucket

Let us use Minio as an example . In a terminal, run:

``` 
$ mc mb dev/tpc/
$ cd udap-spark-s3-tpc-ds-performance-test/src/data 
$ mc cp --recursive * dev/tpc
```
 
### 2. Run the script

*Note:* Verify that the `bin/tpcdsenv.sh` script has `SPARK_HOME` and `TPCDS_S3_ROOT_DIR` setup correctly.

Now that we have Spark setup and the TPC-DS scripts downloaded, we are ready to setup and start running the TPC-DS queries using the `bin/tpcdsspark.sh` utility script. This driver script will allow you to compile the TPC-DS toolkit to produce the data and the queries, and then run them to collect results.  

Perform the following steps to complete the execution of the script:

```
 $ cd udap-spark-s3-tpc-ds-performance-test
 $ bin/tpcdsspark.sh 

==============================================
TPC-DS On Spark Menu
----------------------------------------------
SETUP
 (1) Create spark tables
RUN
 (2) Run a subset of TPC-DS queries
 (3) Run All (99) TPC-DS Queries
CLEANUP
 (4) Cleanup
 (Q) Quit
----------------------------------------------
Please enter your choice followed by [ENTER]: 
```

#### Setup Option: "(1) - Create Spark Tables"

This option creates the tables in the database name specified by `TPCDS_DBNAME` defined in `bin/tpcdsenv.sh`. The default name is `TPCDS` but can be changed if needed. The created tables are based on the pre-generated data. 

The SQL statements to create the tables can be found in `src/ddl/individual`, and are created in parquet format for efficient processing.  

==============================================
TPC-DS On Spark Menu
----------------------------------------------
SETUP
 (1) Create spark tables
RUN
 (2) Run a subset of TPC-DS queries
 (3) Run All (99) TPC-DS Queries
CLEANUP
 (4) Cleanup
 (Q) Quit
----------------------------------------------
Please enter your choice followed by [ENTER]: 1
----------------------------------------------

INFO: Creating tables. Will take a few minutes ...
INFO: Progress : [########################################] 100%
INFO: Spark tables created successfully..
Press any key to continue
```
 
#### Run Option: "(2) - Run a subset of TPC-DS queries"

A comma separated list of queries can be specified in this option. The result of each query in the supplied list is generated in `TPCDS_WORK_DIR`, with a default directory location of `work`. The format of the result file is `query<number>.res`. 

A summary file named `run_summary.txt` is also generated. It contains information about query number, execution time and number of rows returned. 

*Note:*  The query number is a two digit number, so for query 1 the results will be in `query01.res`.

*Note:*  If you are debugging and running queries using this option, make sure to save `run_summary.txt` after each of your runs.

```
==============================================
TPC-DS On Spark Menu
----------------------------------------------
SETUP
 (1) Create spark tables
RUN
 (2) Run a subset of TPC-DS queries
 (3) Run All (99) TPC-DS Queries
CLEANUP
 (4) Cleanup toolkit
 (Q) Quit
----------------------------------------------
Please enter your choice followed by [ENTER]: 2
----------------------------------------------

Enter a comma separated list of queries to run (ex: 1, 2), followed by [ENTER]:
1,2
INFO: Checking pre-reqs for running TPC-DS queries. May take a few seconds..
INFO: Checking pre-reqs for running TPC-DS queries is successful.
INFO: Running TPCDS queries. Will take a few minutes depending upon the number of queries specified.. 
INFO: Progress : [########################################] 100%
INFO: TPCDS queries ran successfully. Below are the result details
INFO: Individual result files: udap-spark-s3-tpc-ds-performance-test/work/query<number>.res
INFO: Summary file: udap-spark-s3-tpc-ds-performance-test/work/run_summary.txt
Press any key to continue
```

#### Run Option: "(3) - Run all (99) TPC-DS queries"

The only difference between this and option `(5)` is that all 99 TPC-DS queries are run instead of a subset.

*Note:* If you are running this on your laptop, it can take a few hours to run all  99 TPC-DS queries.

```
==============================================
TPC-DS On Spark Menu
----------------------------------------------
SETUP
 (1) Create spark tables
RUN
 (2) Run a subset of TPC-DS queries
 (3) Run All (99) TPC-DS Queries
CLEANUP
 (4) Cleanup toolkit
 (Q) Quit
----------------------------------------------
Please enter your choice followed by [ENTER]: 3
----------------------------------------------
INFO: Checking pre-reqs for running TPC-DS queries. May take a few seconds..
INFO: Checking pre-reqs for running TPC-DS queries is successful.
INFO: Running TPCDS queries. Will take a few minutes depending upon the number of queries specified.. 
INFO: Progress : [########################################] 100%
INFO: TPCDS queries ran successfully. Below are the result details
INFO: Individual result files: udap-spark-s3-tpc-ds-performance-test/work/query<number>.res
INFO: Summary file: udap-spark-s3-tpc-ds-performance-test/work/run_summary.txt
Press any key to continue
```

#### Cleanup option: "(4) - Cleanup"

This will clean up all of the files generated during option steps 1, 2, and 3. If you use this option, make sure to run the setup steps (1) before running queries using option 2 and 3.

#### Cleanup option: "(Q) - Quit"

This will exit the script.


# License
This code pattern is licensed under the Apache Software License, Version 2.  Separate third party code objects invoked within this code pattern are licensed by their respective providers pursuant to their own separate licenses. Contributions are subject to the [Developer Certificate of Origin, Version 1.1 (DCO)](https://developercertificate.org/) and the [Apache Software License, Version 2](http://www.apache.org/licenses/LICENSE-2.0.txt).

[Apache Software License (ASL) FAQ](http://www.apache.org/foundation/license-faq.html#WhatDoesItMEAN)
