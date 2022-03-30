# QA automation tests of mSray using rspec and Chrome WebDriver
# moves a marker on the map

require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

# log in methods
require_relative "log_in.rb"

# move offset values
$x_offset = 100
$y_offset = 100

describe "automating mSpray QA" do
  it "moves markers" do
    @driver = set_up
    move_marker
    expect(@driver.find_element(css: '.fas.fa-map').displayed?)
    @driver.quit
  end
end

def move_marker
  # attempts to move a flag
  # double clicks to zoom in on map
  @driver.action.move_to(@driver.find_element(id: 'map')).double_click.double_click.perform
  waitUntil(10, 'button')

  # attempts to drag and drop a flag
  flag = @driver.find_element(css: '[role="button"]')
  @driver.action.move_to(flag).pointer_down(:left).move_by($x_offset, $y_offset).release.perform

  # clicks submit to change locations
  waitUntil(50, 'modal')
  modal = @driver.find_element(id: 'move_pin')
  # hacks clicking submit through tab and enter
  @driver.action.send_keys(modal, :tab).perform
  @driver.action.send_keys(:enter).perform
  waitUntil(30, 'map')
end
