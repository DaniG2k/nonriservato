RSpec.feature 'Admins can create sections' do
  let(:admin) { FactoryBot.create(:organization, :admin) }

  before do
    login_as(admin)
    visit new_admin_section_path
  end

  context 'successfully' do
    it 'creating a section displays the correct message' do
      fill_in 'Title', with: 'Section title'
      fill_in 'Description', with: Faker::Lorem.sentence
      click_button 'Create Section'

      expect(page).to have_content(I18n.t('sections.section_created'))
    end

    it 'allows translating section' do
      fill_in 'Title', with: 'English section'
      fill_in 'Description', with: Faker::Lorem.sentence
      click_button 'Create Section'

      expect(page).to have_content I18n.t('sections.section_created')

      section = Section.first
      visit edit_admin_section_path(section, locale: 'it')

      fill_in 'Titolo', with: 'Sezione Italiana'
      fill_in 'Descrizione', with: Faker::Lorem.sentence
      click_button 'Aggiorna Sezione'

      expect(page).to have_content I18n.t('sections.section_updated')
    end

    it 'allows translating the organizations page description' do
      description = Faker::Lorem.sentence
      fill_in 'Title', with: 'Network'
      fill_in 'Description', with: description
      click_button 'Create Section'

      expect(page).to have_content(I18n.t('sections.section_created'))

      section = Section.first
      visit edit_admin_section_path(section, locale: 'it')

      fill_in 'Titolo', with: 'Network'
      fill_in 'Descrizione', with: description
      click_button 'Aggiorna Sezione'

      expect(page).to have_content I18n.t('sections.section_updated')

      visit organizations_path

      expect(page).to have_content(description)
    end
  end

  context 'unsuccessfully' do
    it 'fails with a message' do
      fill_in 'Title', with: ''
      fill_in 'Description', with: ''
      click_button 'Create Section'

      expect(page).to have_content I18n.t('sections.section_not_created')
    end
  end
  #
  #   it 'shows the appropriate message for missing fields on a translated model' do
  #     fill_in 'Name', with: 'English project'
  #     fill_in 'Start date', with: '16/02/2018'
  #     fill_in 'Definition', with: Faker::Lorem.sentence
  #     fill_in 'Description', with: Faker::Lorem.sentence
  #     fill_in 'Website', with: 'http://example.com'
  #     click_button 'Create Project'
  #
  #     expect(page).to have_content(I18n.t('projects.project_created'))
  #
  #     project = Project.first
  #     visit edit_admin_project_path(project, locale: 'it')
  #
  #     fill_in 'Nome', with: ''
  #     fill_in "Data d'inizio", with: '16/02/2018'
  #     fill_in 'Definizione', with: Faker::Lorem.sentence
  #     fill_in 'Descrizione', with: Faker::Lorem.sentence
  #     fill_in 'Sito internet', with: 'http://example.com'
  #     click_button 'Salva cambiamenti'
  #
  #     expect(page).to have_content(I18n.t('projects.project_not_updated'))
  #   end
  # end
end
