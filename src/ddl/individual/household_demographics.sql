drop table if exists household_demographics_text;
create table household_demographics_text
(
    hd_demo_sk                int,
    hd_income_band_sk         int,
    hd_buy_potential          string,
    hd_dep_count              int,
    hd_vehicle_count          int
)
USING csv
OPTIONS(header "false", delimiter "|", path "${TPCDS_S3_ROOT_DIR}/household_demographics")
;
drop table if exists household_demographics;
create table household_demographics
using parquet
as (select * from household_demographics_text)
;
drop table if exists household_demographics_text;
