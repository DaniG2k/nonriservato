RSpec.feature 'Admins can create events' do
  let(:admin) { FactoryBot.create(:organization, :admin) }

  before do
    login_as(admin)
    visit new_admin_event_path
  end

  context 'successfully' do
    it 'creating an event displays the correct message' do
      fill_in 'Name', with: 'Event name'
      choose(['made by NonRiservato', 'powered by NonRiservato', 'network', 'varie'].sample)
      fill_in 'Start date', with: '14/02/2018'
      fill_in 'End date', with: '24/02/2018'
      fill_in 'Description', with: Faker::Lorem.sentence
      fill_in 'Summary', with: Faker::Lorem.sentence
      fill_in 'Contact email', with: 'sample@email.com'
      attach_file('Load image', "#{Rails.root}/spec/fixtures/logo.png")
      click_button 'Create Event'

      expect(page).to have_content(I18n.t('events.event_created'))
    end

    it 'allows events to be created in multiple languages' do
      fill_in 'Name', with: 'English name'
      choose(['made by NonRiservato', 'powered by NonRiservato', 'network', 'varie'].sample)
      fill_in 'Start date', with: '14/02/2018'
      fill_in 'End date', with: '24/02/2018'
      fill_in 'Description', with: Faker::Lorem.sentence
      fill_in 'Summary', with: Faker::Lorem.sentence
      fill_in 'Contact email', with: 'sample@email.com'
      attach_file('Load image', "#{Rails.root}/spec/fixtures/logo.png")
      click_button 'Create Event'

      expect(page).to have_content(I18n.t('events.event_created'))
      expect(page).to have_content('English name')

      # Switch language
      event_slug = Event.find_by_name('English name').slug
      visit edit_admin_event_path(event_slug, locale: 'it')

      fill_in 'Nome', with: 'Nome Italiano'
      choose(['made by NonRiservato', 'powered by NonRiservato', 'network', 'varie'].sample)
      fill_in 'Data inizio', with: '14/02/2018'
      fill_in 'Data fine', with: '24/02/2018'
      fill_in 'Descrizione', with: Faker::Lorem.sentence
      riassunto = Faker::Lorem.sentence
      fill_in 'Riassunto', with: riassunto
      fill_in 'Contatto email', with: 'sample@email.com'
      attach_file('Carica immagine', "#{Rails.root}/spec/fixtures/logo.png")
      click_button 'Salva cambiamenti'

      expect(page).to have_content('Nome Italiano')
      expect(page).to have_content(riassunto)
    end
  end

  context 'unsuccessfully' do
    it 'fails with a message' do
      fill_in 'Name', with: ''
      click_button 'Create Event'

      expect(page).to have_content(I18n.t('events.event_not_created'))
    end
  end
end
