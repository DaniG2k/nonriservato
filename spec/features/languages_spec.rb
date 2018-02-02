RSpec.feature 'Website visitors can change page language' do
  before { visit root_path }

  scenario 'to Italian' do
    click_link '/it'

    expect(page).to have_content('Benvenuti')
  end

  scenario 'to English' do
    click_link '/en'

    expect(page).to have_content('Welcome')
  end
end
