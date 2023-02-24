require 'rspec/expectations'

module PageObjects
  class RegistrationPage
    include RSpec::Matchers

    private def form_text_input(field_label); @driver.find_element(xpath: "//label[text()='#{field_label}']/following-sibling::input"); end
    private def form_text_area(field_label); @driver.find_element(xpath: "//label[text()='#{field_label}']/following-sibling::textarea"); end
    private def form_clickable_field(field_label, selected_value); @driver.find_element(xpath: "//label[text()='#{field_label}']/../descendant::label[contains(text(), '#{selected_value}')]"); end
    private def form_selectable_field(preselected_value, desired_value); @driver.find_element(xpath: "//option[@selected='selected' and text()='#{preselected_value}']/following-sibling::option[text()='#{desired_value}']"); end
    private def submit_button; @driver.find_element(xpath: "//input[@type='submit']"); end
    private def error_fieldsets; @driver.find_elements(xpath: "//fieldset[contains(@class,'error_p')]/descendant::label[text()='This field is required.']"); end

    def initialize(driver, wait)
      @driver = driver
      @wait = wait
      @driver.get('https://www.way2automation.com/way2auto_jquery/registration.php#load_box')
    end

    def click_submit
      @wait.until{submit_button}.click
    end

    def error_messages_count
      return @wait.until{error_fieldsets}.length
    end

    def assert_error_messages_count_decreased_from(initial_count)
      expect(error_messages_count).to be (initial_count-1)
    end

    def fill_first_name
      @wait.until{form_text_input("First Name:")}.send_keys("Joe")
    end

    def assert_form_submitted
      @wait.until{form_text_input("First Name:").text == ""}
    end

    # This method implicitly validates that the file exists, throwing an error if it doesn't.
    private def image_filepath
      File.expand_path('assets/white-rectangle.png')
    end

    def fill_form
      @wait.until{form_text_input("First Name:")}.send_keys("Joe")
      @wait.until{form_text_input("Last Name:")}.send_keys("Testlio")
      @wait.until{form_clickable_field("Marital Status:", "Married")}.click
      @wait.until{form_clickable_field("Hobby:", "Cricket")}.click
      @wait.until{form_selectable_field("India", "India")}.click
      @wait.until{form_selectable_field("Month", "1")}.click
      @wait.until{form_selectable_field("Day", "1")}.click
      @wait.until{form_selectable_field("Year", "2014")}.click
      @wait.until{form_text_input("Phone Number:")}.send_keys("123456")
      @wait.until{form_text_input("Username:")}.send_keys("tester")
      @wait.until{form_text_input("E-mail:")}.send_keys("test@test.com")
      @wait.until{form_text_input("Your Profile Picture")}.send_keys(image_filepath)
      @wait.until{form_text_area("About Yourself")}.send_keys("My name is Joe and I'm a tester.")
      @wait.until{form_text_input("Password:")}.send_keys("password")
      @wait.until{form_text_input("Confirm Password:")}.send_keys("password")
    end

  end
end
