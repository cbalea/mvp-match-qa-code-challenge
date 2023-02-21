require 'rspec'
require 'selenium-webdriver'
require 'webdrivers'

RSpec.configure do |config|
  config.around(:example) do |example|
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    begin
      example.run
    ensure
      @driver.quit
    end
  end
end