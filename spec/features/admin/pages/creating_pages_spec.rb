RSpec.feature 'Admins can create pages' do
  let(:admin) { create(:organization, :admin) }

  before do
    login_as(admin)
    visit page_path('some page')
  end

  context 'successfully' do
    it 'creating a page displays the correct message' do
      fill_in 'Title', with: 'Some page'
      fill_in 'Text', with: Faker::Lorem.sentence
      click_button 'Create Page'

      expect(page).to have_content(I18n.t('pages.page_created'))
    end

    it 'allows pages to be created in multiple languages' do
      fill_in 'Title', with: 'English Title'
      fill_in 'Text', with: Faker::Lorem.sentence
      click_button 'Create Page'

      expect(page).to have_content('English Title')
      expect(page).to have_content(I18n.t('pages.page_created'))

      # Switch language
      page_id = Page.find_by_title('English Title').id
      visit edit_page_path(page_id, locale: 'it')

      fill_in 'Titolo', with: 'Titolo Italiano'
      fill_in 'Contenuto', with: 'Contenuto in Italiano'
      click_button 'Aggiorna Pagina'

      expect(page).to have_content('Titolo Italiano')
      expect(page).to have_content('Contenuto in Italiano')
    end
  end

  context 'unsuccessfully' do
    it 'fails with a message' do
      fill_in 'Title', with: ''
      fill_in 'Text', with: ''
      click_button 'Create Page'

      expect(page).to have_content('prohibited this page from being saved')
    end
  end
end
