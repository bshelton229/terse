require 'spec_helper'

feature "Github login" do
  it 'Should be able to log in via Github' do
    visit '/auth/github'
    visit root_path
    expect(page).to have_content("bshelton229")
    expect(User.find_by username: 'bshelton229').to_not be_nil
  end
end