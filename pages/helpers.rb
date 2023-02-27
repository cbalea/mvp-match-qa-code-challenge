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

# This method implicitly validates that the file exists, throwing an error if it doesn't.
private def absolute_filepath(file)
  File.expand_path(file)
end