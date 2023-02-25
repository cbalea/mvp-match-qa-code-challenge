def try_action_successful?(&action)
  begin
    yield action
    return true
  rescue Selenium::WebDriver::Error::NoSuchAlertError
    return false
  rescue Selenium::WebDriver::Error::NoSuchElementError
    return false
  end
end