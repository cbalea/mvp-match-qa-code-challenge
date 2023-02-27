require 'rspec'
require 'selenium-webdriver'
require 'webdrivers'

RSpec.configure do |config|
  config.around(:example) do |example|
    # @driver = Selenium::WebDriver.for :chrome

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--disable-popup-blocking')
    options.add_argument('--disable-translate')
    options.headless!
    @driver = Selenium::WebDriver.for :remote, url: 'http://localhost:9515/wd/hub', options: options

    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    begin
      example.run
    ensure
      @driver.quit
    end
  end
end