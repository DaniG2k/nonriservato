RSpec.feature 'Admins can create projects' do
  let(:admin) { FactoryBot.create(:organization, :admin) }

  before do
    login_as(admin)
    visit new_admin_project_path
  end

  context 'successfully' do
    it 'creating a project displays the correct message' do
      fill_in 'Name', with: 'Test project'
      fill_in 'Start date', with: '16/02/2018'
      fill_in 'Definition', with: Faker::Lorem.sentence
      fill_in 'Description', with: Faker::Lorem.sentence
      fill_in 'Website', with: 'http://example.com'
      click_button 'Create Project'

      expect(page).to have_content(I18n.t('projects.project_created'))
    end

    it 'allows translating projects' do
      fill_in 'Name', with: 'English project'
      fill_in 'Start date', with: '16/02/2018'
      fill_in 'Definition', with: Faker::Lorem.sentence
      fill_in 'Description', with: Faker::Lorem.sentence
      fill_in 'Website', with: 'http://example.com'
      click_button 'Create Project'

      expect(page).to have_content(I18n.t('projects.project_created'))

      project = Project.first
      visit edit_admin_project_path(project, locale: 'it')

      fill_in 'Nome', with: 'Progetto Italiano'
      fill_in "Data d'inizio", with: '16/02/2018'
      fill_in 'Definizione', with: Faker::Lorem.sentence
      fill_in 'Descrizione', with: Faker::Lorem.sentence
      fill_in 'Sito internet', with: 'http://example.com'
      click_button 'Salva cambiamenti'

      expect(page).to have_content('Il progetto è stato aggiornato con successo.')
    end
  end

  context 'unsuccessfully' do
    it 'fails with a message' do
      fill_in 'Name', with: ''
      fill_in 'Start date', with: ''
      fill_in 'Definition', with: Faker::Lorem.sentence
      fill_in 'Description', with: Faker::Lorem.sentence
      fill_in 'Website', with: 'http://example.com'
      click_button 'Create Project'

      expect(page).to have_content('devi dare un nome al tuo progetto')
    end

    it 'shows the appropriate message for missing fields on a translated model' do
      fill_in 'Name', with: 'English project'
      fill_in 'Start date', with: '16/02/2018'
      fill_in 'Definition', with: Faker::Lorem.sentence
      fill_in 'Description', with: Faker::Lorem.sentence
      fill_in 'Website', with: 'http://example.com'
      click_button 'Create Project'

      expect(page).to have_content(I18n.t('projects.project_created'))

      project = Project.first
      visit edit_admin_project_path(project, locale: 'it')

      fill_in 'Nome', with: ''
      fill_in "Data d'inizio", with: '16/02/2018'
      fill_in 'Definizione', with: Faker::Lorem.sentence
      fill_in 'Descrizione', with: Faker::Lorem.sentence
      fill_in 'Sito internet', with: 'http://example.com'
      click_button 'Salva cambiamenti'

      expect(page).to have_content(I18n.t('projects.project_not_updated'))
    end
  end
end
