#!/usr/bin/env ruby

include SprayDatumHelper
include WorkerHelper

create_worker('1', 'Daniel', true)
create_worker('2', 'Kevin', true)
create_worker('3', 'Jermaine', true)
create_worker('4', 'Wuchi', true)
create_worker('5', 'Brent', false)
create_worker('6', 'Jeff', false)
create_worker('7', 'Annie', false)
create_worker('8', 'Brenda', false)
create_worker('9', 'Lesliam', false)
create_worker('10', 'Edwin', false)

create_spray_datum({:timestamp=>"2013-05-02 21:34:26", :imei=>"A000002C022C19", :lat=>"-23.82168442", :lng=>"30.16113748", :gps_accuracy=>"64", :is_mopup_spray=>"", :foreman=>"t", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>6, :unsprayed_shelters=>8, :stats=>{"Test"=>{:rooms_sprayed=>1, :shelters_sprayed=>2, :refilled=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 14:16:10", :imei=>"c4644dcd0281adb6", :lat=>"-23.81972577", :lng=>"30.30440348", :gps_accuracy=>"48", :is_mopup_spray=>"", :foreman=>"u", :chemical_used=>"", :unsprayed_rooms=>9, :unsprayed_shelters=>9, :stats=>{"Test"=>{:rooms_sprayed=>1, :shelters_sprayed=>2, :refilled=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 14:48:23", :imei=>"c4644dcd0281adb6", :lat=>"-23.77202789", :lng=>"30.39038133", :gps_accuracy=>"64", :is_mopup_spray=>"", :foreman=>"v", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>1, :unsprayed_shelters=>0, :stats=>{"Test"=>{:rooms_sprayed=>1, :shelters_sprayed=>2, :refilled=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 16:21:15", :imei=>"A000002C022C19", :lat=>"-23.63509498", :lng=>"30.49364637", :gps_accuracy=>"45", :is_mopup_spray=>"", :foreman=>"w", :chemical_used=>"", :unsprayed_rooms=>7, :unsprayed_shelters=>9, :stats=>{"Test"=>{:rooms_sprayed=>1, :shelters_sprayed=>2, :refilled=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 16:32:22", :imei=>"A000002C022C19", :lat=>"-23.63122072", :lng=>"30.4947733", :gps_accuracy=>"45", :is_mopup_spray=>"", :foreman=>"x", :chemical_used=>"", :unsprayed_rooms=>7, :unsprayed_shelters=>8, :stats=>{"Test"=>{:rooms_sprayed=>1, :shelters_sprayed=>2, :refilled=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 17:08:51", :imei=>"A000002C022C19", :lat=>"-23.63278573", :lng=>"30.49383527", :gps_accuracy=>"45", :is_mopup_spray=>"", :foreman=>"y", :chemical_used=>"", :unsprayed_rooms=>6, :unsprayed_shelters=>9, :stats=>{"Test"=>{:rooms_sprayed=>1, :shelters_sprayed=>2, :refilled=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 17:32:42", :imei=>"c4644dcd0281adb6", :lat=>"-23.63495215", :lng=>"30.49370998", :gps_accuracy=>"32", :is_mopup_spray=>"", :foreman=>"z", :chemical_used=>"Fendona", :unsprayed_rooms=>0, :unsprayed_shelters=>0, :stats=>{"Test"=>{:rooms_sprayed=>1, :shelters_sprayed=>2, :refilled=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 17:43:39", :imei=>"c4644dcd0281adb6", :lat=>"-23.02218511", :lng=>"30.60618102", :gps_accuracy=>"32", :is_mopup_spray=>"", :foreman=>"aa", :chemical_used=>"DDT", :unsprayed_rooms=>4, :unsprayed_shelters=>8, :stats=>{"Test"=>{:rooms_sprayed=>1, :shelters_sprayed=>2, :refilled=>true}}})
create_spray_datum({:timestamp=>"2018-08-29 15:41:15", :imei=>"358240051111110", :lat=>"-30", :lng=>"20", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"not identified", :chemical_used=>"DDT", :unsprayed_rooms=>1, :unsprayed_shelters=>0, :stats=>{"Sprayer 1"=>{:rooms_sprayed=>"4", :shelters_sprayed=>"2", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-08-30 12:31:50", :imei=>"358240051111110", :lat=>"-30", :lng=>"20", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"not identified", :chemical_used=>"DDT", :unsprayed_rooms=>0, :unsprayed_shelters=>0, :stats=>{"Sprayer 1"=>{:rooms_sprayed=>"3", :shelters_sprayed=>"3", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-08-31 13:43:11", :imei=>"358240051111110", :lat=>"-30", :lng=>"20", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"not identified", :chemical_used=>"Fendona", :unsprayed_rooms=>0, :unsprayed_shelters=>1, :stats=>{"LTT-D02 - NEMAKHAVHANI PW"=>{:rooms_sprayed=>"3", :shelters_sprayed=>"1", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-08-31 15:40:31", :imei=>"358240051111110", :lat=>"30", :lng=>"-21", :gps_accuracy=>"2147483647", :is_mopup_spray=>"FALSE", :foreman=>"James", :chemical_used=>"Fendona", :unsprayed_rooms=>1, :unsprayed_shelters=>0, :stats=>{"Jackson"=>{:rooms_sprayed=>"3", :shelters_sprayed=>"1", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-08-31 15:50:48", :imei=>"358240051111110", :lat=>"2", :lng=>"1", :gps_accuracy=>"2147483647", :is_mopup_spray=>"FALSE", :foreman=>"9324203", :chemical_used=>"", :unsprayed_rooms=>0, :unsprayed_shelters=>0, :stats=>{"2313"=>{:rooms_sprayed=>"0", :shelters_sprayed=>"0", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-04 15:27:54", :imei=>"352531085290789", :lat=>"33.72", :lng=>"-117.81", :gps_accuracy=>"15", :is_mopup_spray=>"FALSE", :foreman=>"123", :chemical_used=>"", :unsprayed_rooms=>0, :unsprayed_shelters=>0, :stats=>{"34"=>{:rooms_sprayed=>"0", :shelters_sprayed=>"0", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-06 15:24:55", :imei=>"358240051111110", :lat=>"-30", :lng=>"20", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Daniel", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>1, :unsprayed_shelters=>11, :stats=>{"James"=>{:rooms_sprayed=>"22", :shelters_sprayed=>"1", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-06 15:29:05", :imei=>"358240051111110", :lat=>"-30", :lng=>"20", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Jane", :chemical_used=>"N/A", :unsprayed_rooms=>3, :unsprayed_shelters=>0, :stats=>{"Jenny"=>{:rooms_sprayed=>"0", :shelters_sprayed=>"0", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-06 15:32:40", :imei=>"358240051111110", :lat=>"-30", :lng=>"20", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Jermaine", :chemical_used=>"Fendona", :unsprayed_rooms=>3, :unsprayed_shelters=>0, :stats=>{"Kevin"=>{:rooms_sprayed=>"7", :shelters_sprayed=>"2", :refilled=>"false"}, "Wuchi"=>{:rooms_sprayed=>"2", :shelters_sprayed=>"5", :refilled=>"false"}}})
