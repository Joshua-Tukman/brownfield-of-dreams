require 'rails_helper'

RSpec.describe "As a visitor" do
  it "I am able to register and confirm my email address" do

    visit new_user_path

    fill_in 'user[email]', with: "example@gmail.com"
    fill_in 'user[first_name]', with: "Bob"
    fill_in 'user[last_name]', with: "Sample"
    fill_in 'user[password]', with: "password"
    fill_in "Password Confirmation", with: "password"
    
    click_on "Create Account" 

    user = User.last

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Check your email to activate your account!")
    expect(page).to have_content("Activation Status: Inactive")
    
    visit "/activate/#{user.id}"
    
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Your account has now been activated")
    expect(page).to have_content("Activation Status: Active")
  end
end