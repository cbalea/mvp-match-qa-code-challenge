require_relative 'helpers/spec_helper'
require_relative '../pages/registration_page'
extend RSpec::Matchers

RSpec.describe 'Registration page' do

  it 'shows error messages on empty fields' do
    registration_page = PageObjects::RegistrationPage.new(@driver, @wait)
    registration_page.click_submit
    initial_error_count = registration_page.error_messages_count
    registration_page.fill_first_name
    registration_page.click_submit
    expect(registration_page.error_messages_count).to eq (initial_error_count-1)
  end

  it 'can successfully submit form' do
    registration_page = PageObjects::RegistrationPage.new(@driver, @wait)
    registration_page.fill_form
    registration_page.click_submit
    expect(registration_page.form_submitted?).to be true
  end

end
