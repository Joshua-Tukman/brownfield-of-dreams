require 'rails_helper'

RSpec.describe 'as an admin' do
  describe 'when i visit my dashboard' do
    it 'i can click a link to toggle a tutorial classroom status' do
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      tutorial1 = create(:tutorial, title: 'RSPEC and You')
      tutorial2 = create(:tutorial, title: 'The Final API Call')
      create(:video, tutorial_id: tutorial1.id)
      create(:video, tutorial_id: tutorial1.id)
      create(:video, tutorial_id: tutorial2.id)
      create(:video, tutorial_id: tutorial2.id)

      visit admin_dashboard_path

      within("#tutorial-#{tutorial1.id}") do
        expect(page).to have_content('RSPEC and You')
        expect(page).to have_button('false')
      end

      within("#tutorial-#{tutorial2.id}") do
        expect(page).to have_content('The Final API Call')
        expect(page).to have_button('false')
        click_button('false')
      end

      expect(current_path).to eq(admin_dashboard_path)

      within("#tutorial-#{tutorial1.id}") do
        expect(page).to have_content('RSPEC and You')
        expect(page).to have_button('false')
      end

      within("#tutorial-#{tutorial2.id}") do
        expect(page).to have_content('The Final API Call')
        expect(page).to have_button('true')
        click_button('true')
      end

      expect(current_path).to eq(admin_dashboard_path)

      within("#tutorial-#{tutorial1.id}") do
        expect(page).to have_content('RSPEC and You')
        expect(page).to have_button('false')
      end

      within("#tutorial-#{tutorial2.id}") do
        expect(page).to have_content('The Final API Call')
        expect(page).to have_button('false')
        click_button('false')
      end
    end
  end
end
