require_relative 'helpers/spec_helper'
require_relative '../pages/registration-page'

RSpec.describe 'Registration page' do
  it 'can submit form' do
    registration_page = PageObjects::RegistrationPage.new(@driver, @wait)
    registration_page.load
    registration_page.foo
  end
end
