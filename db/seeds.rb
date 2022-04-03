#!/usr/bin/env ruby

include SprayDatumHelper
include WorkerHelper

AllowedEmail.where(email: "ldanielcwu@gmail.com").first_or_create
AllowedEmail.where(email: "msprayapp@gmail.com").first_or_create
AllowedEmail.where(email: "austin.zhang@gpmail.org").first_or_create
AllowedEmail.where(email: "ausdfzh323@gmail.com").first_or_create
AllowedEmail.where(email: "msprayapptest@gmail.com").first_or_create

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

create_spray_datum({:timestamp=>"2018-09-06 15:24:55", :imei=>"358240051111110", :lat=>"-23.15287975", :lng=>"29.44401074", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Daniel", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>1, :unsprayed_shelters=>11, :stats=>{"2"=>{:rooms_sprayed=>"22", :shelters_sprayed=>"1", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-06 15:29:05", :imei=>"358240051111110", :lat=>"-23.151", :lng=>"30.7437666", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Jane", :chemical_used=>"N/A", :unsprayed_rooms=>3, :unsprayed_shelters=>0, :stats=>{"3"=>{:rooms_sprayed=>"0", :shelters_sprayed=>"0", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-06 15:32:40", :imei=>"358240051111110", :lat=>"-23.151", :lng=>"29.44401074", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Jermaine", :chemical_used=>"Fendona", :unsprayed_rooms=>3, :unsprayed_shelters=>0, :stats=>{"1"=>{:rooms_sprayed=>"7", :shelters_sprayed=>"2", :refilled=>"false"}, "4"=>{:rooms_sprayed=>"2", :shelters_sprayed=>"5", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-08 15:24:55", :imei=>"358240051111110", :lat=>"-23.35287975", :lng=>"30.4437666", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Daniel", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>1, :unsprayed_shelters=>11, :stats=>{"2"=>{:rooms_sprayed=>"22", :shelters_sprayed=>"1", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-10 15:24:55", :imei=>"358240051111110", :lat=>"-23.2", :lng=>"30", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Daniel", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>1, :unsprayed_shelters=>11, :stats=>{"2"=>{:rooms_sprayed=>"22", :shelters_sprayed=>"1", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-09-07 15:24:55", :imei=>"358240051111110", :lat=>"-23.2", :lng=>"30.2", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Daniel", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>1, :unsprayed_shelters=>11, :stats=>{"2"=>{:rooms_sprayed=>"22", :shelters_sprayed=>"1", :refilled=>"false"}}})
create_spray_datum({:timestamp=>"2018-11-20 15:00:59", :imei=>"358240051111110", :lat=>"-23.3528", :lng=>"29.444", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Jermaine", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>2, :unsprayed_shelters=>12, :stats=>{"2"=>{:rooms_sprayed=>"22", :shelters_sprayed=>"1", :refilled=>"false"}}})
