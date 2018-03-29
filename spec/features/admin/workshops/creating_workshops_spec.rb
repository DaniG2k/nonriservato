RSpec.feature 'Admins can create workshops' do
  let(:admin) { create(:organization, :admin) }

  before do
    login_as(admin)
    visit new_admin_workshop_path
  end

  context 'successfully' do
    it 'creating a workshop displays the correct message' do
      fill_in 'Name', with: 'Test workshop'
      fill_in 'Start date', with: '16/02/2018'
      fill_in 'End date', with: '20/02/2018'
      fill_in 'Definition', with: Faker::Lorem.sentence
      fill_in 'Description', with: Faker::Lorem.paragraph
      fill_in 'Website', with: 'http://example.com'
      click_button 'Create Workshop'

      expect(page).to have_content(I18n.t('workshops.workshop_created'))
    end
  end

  context 'unsuccessfully' do
    it 'fails with a message' do
      fill_in 'Name', with: ''
      fill_in 'Start date', with: ''
      fill_in 'Definition', with: Faker::Lorem.sentence
      fill_in 'Description', with: Faker::Lorem.sentence
      fill_in 'Website', with: 'http://example.com'
      click_button 'Create Workshop'

      expect(page).to have_content('devi dare un nome al workshop')
    end
  end
end
