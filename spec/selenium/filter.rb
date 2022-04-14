# filtering methods for dealing with tables

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
    driver.find_element(css: '.fa.fa-angle-up').click
    waitUntil(10, 'filter_down')
  end

  # returns the first row element of the given column unless told not to
  # setting xpath to be the proper column
  str = '//table/tbody/tr[2]/td['
  str.concat((column+1).to_s).concat("]")
  return driver.find_element(xpath: str)
end

def num_rows(driver)
  # returns the number of rows in the table
  return driver.find_elements(css: '.data-row').length
end

def click_button(driver, fxn)
  # clicks on the first row button based on fxn
  cssclass = '.btn.admin-button.modal-trigger.'
  if fxn == 'edit'
    cssclass.concat('blue.lighten-3')
  else
    cssclass.concat('red.lighten-2')
  end
  driver.find_element(css: cssclass).click

  # returns the true false value if a modal is displayed
  return driver.find_element(css: '.modal-content').displayed?
end
