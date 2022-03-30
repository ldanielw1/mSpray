# QA automation tests of mSray using rspec and Chrome WebDriver
# adds and deletes markers on the map

require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

# log in methods
require_relative "log_in.rb"

# add marker type (report, futureLocation, data)
$type = 'report'

describe "automating mSpray QA" do
  it "adds markers" do
    @driver = set_up
    add_marker
    expect(@driver.find_element(id: 'add_data').displayed?)
    @driver.quit
  end

  it "deletes markers" do
    @driver = set_up
    delete_marker
    expect(!@driver.find_element(css: '.gm-style-iw.gm-style-iw-c').displayed?)
    @driver.quit
  end
end

def add_marker
  # attempts to add a fla
  # clicks on the add flag button based on set type (see variable def)
  @driver.find_element(css: '.fas.fa-plus').click
  if $type == 'report'
    @driver.find_element(css: '.btn-floating.red.toggle-add-malaria-reports').click
  elsif $type == 'futureLocation'
    @driver.find_element(css: '.btn-floating.yellow.darken-2.toggle-add-future-spray-locations').click
  elsif $type == 'data'
    @driver.find_element(css: '.btn-floating.blue.toggle-add-spray-data').click
  else
    puts 'flag type not properly defined, check init of variable'
  end

  # clicks on map location defined by rand offset
  map = @driver.find_element(id: 'map')
  x_offset = map.rect.x + rand(100)
  y_offset = map.rect.y + rand(100)

  #zooms in on the map
  @driver.action.move_to_location(x_offset, y_offset).double_click.perform
  @driver.action.click
end

def delete_marker
  # attempts to delete a spray data flag
  # double clicks to zoom in on map
  @driver.action.move_to(@driver.find_element(id: 'map')).double_click.double_click.perform
  waitUntil(10, 'button')

  # clicks spray data to delete it
  @driver.find_element(css: '[role="button"]').click
  waitUntil(10, 'modal')
  @driver.action.move_to(@driver.find_element(css: '.btn.modal-trigger.delete_marker')).click
end
