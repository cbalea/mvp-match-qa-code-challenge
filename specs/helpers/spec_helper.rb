require 'rspec'
require 'selenium-webdriver'
require 'webdrivers'

RSpec.configure do |config|
  config.around(:example) do |example|

    if(ENV['ENVIRONMENT'])
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--w3c=false')
      # still doesn't fix https://stackoverflow.com/questions/58296774/ruby-selenium-webdriver-3-142-6-unable-to-upload-file-due-to-seleniumwebdriv
      @driver = Selenium::WebDriver.for :remote, url: 'http://localhost:9515/wd/hub', options: options
    else
      @driver = Selenium::WebDriver.for :chrome
    end

    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    begin
      example.run
    ensure
      @driver.quit
    end
  end
end