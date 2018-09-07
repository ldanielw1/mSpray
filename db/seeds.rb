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

create_spray_datum({:timestamp=>"2013-05-02 21:34:26", :imei=>"A000002C022C19", :lat=>"-23.82168442", :lng=>"30.16113748", :gps_accuracy=>"64", :is_mopup_spray=>"", :homestead_sprayed=>true, :foreman=>"t", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>6, :unsprayed_shelters=>8, :stats=>{"Test"=>{"roomsSprayed"=>1, "sheltersSprayed"=>2, "refilled"=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 14:16:10", :imei=>"c4644dcd0281adb6", :lat=>"-23.81972577", :lng=>"30.30440348", :gps_accuracy=>"48", :is_mopup_spray=>"", :homestead_sprayed=>false, :foreman=>"u", :chemical_used=>"", :unsprayed_rooms=>9, :unsprayed_shelters=>9, :stats=>{"Test"=>{"roomsSprayed"=>1, "sheltersSprayed"=>2, "refilled"=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 14:48:23", :imei=>"c4644dcd0281adb6", :lat=>"-23.77202789", :lng=>"30.39038133", :gps_accuracy=>"64", :is_mopup_spray=>"", :homestead_sprayed=>true, :foreman=>"v", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>1, :unsprayed_shelters=>0, :stats=>{"Test"=>{"roomsSprayed"=>1, "sheltersSprayed"=>2, "refilled"=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 16:21:15", :imei=>"A000002C022C19", :lat=>"-23.63509498", :lng=>"30.49364637", :gps_accuracy=>"45", :is_mopup_spray=>"", :homestead_sprayed=>false, :foreman=>"w", :chemical_used=>"", :unsprayed_rooms=>7, :unsprayed_shelters=>9, :stats=>{"Test"=>{"roomsSprayed"=>1, "sheltersSprayed"=>2, "refilled"=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 16:32:22", :imei=>"A000002C022C19", :lat=>"-23.63122072", :lng=>"30.4947733", :gps_accuracy=>"45", :is_mopup_spray=>"", :homestead_sprayed=>false, :foreman=>"x", :chemical_used=>"", :unsprayed_rooms=>7, :unsprayed_shelters=>8, :stats=>{"Test"=>{"roomsSprayed"=>1, "sheltersSprayed"=>2, "refilled"=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 17:08:51", :imei=>"A000002C022C19", :lat=>"-23.63278573", :lng=>"30.49383527", :gps_accuracy=>"45", :is_mopup_spray=>"", :homestead_sprayed=>false, :foreman=>"y", :chemical_used=>"", :unsprayed_rooms=>6, :unsprayed_shelters=>9, :stats=>{"Test"=>{"roomsSprayed"=>1, "sheltersSprayed"=>2, "refilled"=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 17:32:42", :imei=>"c4644dcd0281adb6", :lat=>"-23.63495215", :lng=>"30.49370998", :gps_accuracy=>"32", :is_mopup_spray=>"", :homestead_sprayed=>true, :foreman=>"z", :chemical_used=>"Fendona", :unsprayed_rooms=>0, :unsprayed_shelters=>0, :stats=>{"Test"=>{"roomsSprayed"=>1, "sheltersSprayed"=>2, "refilled"=>true}}})
create_spray_datum({:timestamp=>"2013-05-04 17:43:39", :imei=>"c4644dcd0281adb6", :lat=>"-23.02218511", :lng=>"30.60618102", :gps_accuracy=>"32", :is_mopup_spray=>"", :homestead_sprayed=>true, :foreman=>"aa", :chemical_used=>"DDT", :unsprayed_rooms=>4, :unsprayed_shelters=>8, :stats=>{"Test"=>{"roomsSprayed"=>1, "sheltersSprayed"=>2, "refilled"=>true}}})
