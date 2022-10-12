# QA automation tests of mSray using rspec and Chrome WebDriver
# adds and deletes markers on the map
# checks modals are displayed
# and data is entried in tables

# selenium webdriver libraries
require "selenium-webdriver"
require "rspec"

# custom library methods
require_relative "log_in.rb"
require_relative "filter.rb"

# Test specifc elements
# delete type
$dtype = 'data'

describe "automating mSpray QA" do
  # setting up driver for testing environment
  before(:all) do
    @driver = set_up
  end

  # checks if adding markers pops open a modal and adds data entry in table
  context "adds markers" do
    # three types to check
    types = ['report', 'future', 'data']

    types.each do |type|
      it "checks modal opened" do
        # attempts to add a marker and checks for modal open
        add_marker(type)
        expect(@driver.find_element(id: 'add_data').displayed?)
      end

      it "checks #{type} data entry" do
        # looks at data table and checks that data is added
        prev = check_data(type)
        add_marker(type)
        expect(check_data(type)).to eql(prev+1)
      end
    end
  end

  # checks if deleting markers pops open a modal and deletes data entry in table
  context "deletes markers" do
    it "checks modal opened" do
      # attempts to delete a marker and expect modal opened
      $dtype = delete_marker()
      expect(!@driver.find_element(css: '.gm-style-iw.gm-style-iw-c').displayed?)
    end

    it "checks data entry" do
      # looks at data table and checks that data is deleted
      prev = check_data($dtype)
      delete_marker()
      expect(check_data($dtype)).to eql(prev-1)
    end
  end

  after(:all) do
    @driver.close
  end
end

def check_data(type)
  # uses num_rows to find the number of data entries with given types
  # navigates to specified data table
  if type == 'report'
    url = "http://localhost:3000/malaria_reports/view"
  elsif type == 'future'
    url = "http://localhost:3000/future_spray_locations/view"
  else
    url = "http://localhost:3000/spray_data/view"
  end
  @driver.get url

  # returns num_rows
  return num_rows(@driver)
end

def add_marker(type = 'report')
  # attempts to add a flag
  # gets site, resets map view
  map_view

  # clicks on the add flag button based on set type (see variable def)
  @driver.find_element(css: '.fas.fa-plus').click
  if type == 'report'
    @driver.find_element(css: '.btn-floating.red.toggle-add-malaria-reports').click
  elsif type == 'future'
    @driver.find_element(css: '.btn-floating.yellow.darken-2.toggle-add-future-spray-locations').click
  else
    @driver.find_element(css: '.btn-floating.blue.toggle-add-spray-data').click
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
  # attempts to delete a data flag
  # gets site, resets map view
  map_view

  # double clicks to zoom in on map
  @driver.action.move_to(@driver.find_element(id: 'map')).double_click.double_click.perform
  waitUntil(10, 'button')

  # clicks spray data to delete it
  @driver.find_element(css: '[role="button"]').click
  waitUntil(10, 'modal')
  # finds the type of the flag
  type = @driver.find_element(css: 'h4').text
  @driver.action.move_to(@driver.find_element(css: '.btn.modal-trigger.delete_marker')).click

  # returns shortened type of flag
  if type == 'Spray Data'
    type = 'data'
  elsif type == 'Future Spray Locations'
    type = 'future'
  else
    type = 'report'
  end

  return type
end
