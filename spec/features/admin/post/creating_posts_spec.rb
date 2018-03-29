RSpec.feature 'Admins can create posts' do
  let(:admin) { create(:organization, :admin) }

  before(:each) do
    login_as(admin)
    visit new_admin_post_path
  end

  context 'successfully' do
    it 'creating a post displays the correct message' do
      fill_in 'Title', with: 'Some page'
      fill_in 'Date', with: '23/02/2018'
      fill_in 'post_summary', with: Faker::Lorem.sentence
      fill_in 'post_body', with: Faker::Lorem.sentence
      click_button 'Create Post'

      expect(page).to have_content(I18n.t('posts.post_created'))
    end

    it 'allows posts to be created in multiple languages' do
      fill_in 'Title', with: 'English Title'
      fill_in 'Date', with: '23/02/2018'
      fill_in 'post_summary', with: "Content in English #{Faker::Lorem.sentence}"
      fill_in 'post_body', with: Faker::Lorem.sentence
      click_button 'Create Post'

      expect(page).to have_content(I18n.t('posts.post_created'))
      expect(page).to have_content('Content in English')

      # Switch language
      post = Post.with_translations.find_by_title 'English Title'
      visit edit_admin_post_path(post, locale: 'it')

      fill_in 'Titolo', with: 'Titolo Italiano'
      fill_in 'Data', with: '23/02/2018'
      fill_in 'post_summary', with: "Contenuto in Italiano #{Faker::Lorem.sentence}"
      fill_in 'post_body', with: Faker::Lorem.sentence
      click_button 'Salva cambiamenti'

      expect(page).to have_content('Contenuto in Italiano')
      expect(page).to have_content(I18n.t('posts.post_updated'))
    end
  end

  context 'unsuccessfully' do
    it 'fails with a message' do
      fill_in 'Title', with: ''
      fill_in 'Date', with: ''
      click_button 'Create Post'

      expect(page).to have_content(I18n.t('posts.post_not_created'))
    end
  end
end
