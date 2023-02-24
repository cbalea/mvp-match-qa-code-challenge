require_relative 'helpers/spec_helper'
require_relative '../pages/alert_page'
extend RSpec::Matchers

RSpec.describe 'Alert page' do
  it 'can open and close alert' do
    alert_page = PageObjects::AlertPage.new(@driver, @wait)
    alert_page.trigger_alert
    alert_page.close_alert
    expect(alert_page.alert_exists?).to eq false
  end
end
