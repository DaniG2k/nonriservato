RSpec.feature 'Admins can destroy sections' do
  let(:admin) { FactoryBot.create(:organization, :admin) }
  let(:section) { FactoryBot.create(:section) }

  before do
    login_as(admin)
    visit edit_admin_section_path(section)
  end

  context 'successfully' do
    it 'destroying a section displays the correct message' do
      click_button 'Delete'

      expect(page).to have_content(I18n.t('sections.section_destroyed'))
    end
  end
end
