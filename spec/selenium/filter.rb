# filtering methods for dealing with tables
# filters by column header and returns the first row element in the column

# selenium webdriver libraries
require "selenium-webdriver"
require "chromedriver-helper"

# log in methods
require_relative "log_in.rb"

def filter(driver, column, sort = 'up')
  # attempts to filter based on preferred sorting, and returns first row element
  # finds specifc column to click and waits for sorting arrow
  column = column.to_s.to_i
  column_headers = driver.find_elements(css: "a[class='column-header']")
  driver.action.move_to(column_headers[column]).click.perform
  sleep(inspection_time = 1)

  # sort the column based on the passed parameter sort
  # default will be sort up
  if sort == 'up'
    if column != 0
      driver.find_element(css: '.fa.fa-angle-down').click
    end
    waitUntil(10, 'filter_up')
  else
    waitUntil(10, 'filter_down')
  end

  # returns the first row element of the given column
  str = '//table/tbody/tr[2]/td['
  str.concat((column+1).to_s).concat("]")
  return driver.find_element(xpath: str)
end