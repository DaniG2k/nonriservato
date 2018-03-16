RSpec.feature 'Website visitors can view events' do
  context 'Italian' do
    it 'displays the events page content' do
      visit root_path locale: :it
      click_link 'Calendario'

      expect(page).to have_content 'Cerca'
    end
  end

  context 'English' do
    it 'does not display the events page content' do
      visit root_path locale: :en
      click_link 'Calendar'

      expect(page).to have_content 'This page is only available in Italian'
    end
  end
end
