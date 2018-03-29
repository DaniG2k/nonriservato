RSpec.feature 'Admins can destroy workshops' do
  let(:admin) { create(:organization, :admin) }
  let(:workshop) { create(:workshop) }

  before do
    login_as(admin)
    visit edit_admin_workshop_path(workshop)
  end

  context 'successfully' do
    it 'destroying a project displays the correct message' do
      click_button 'Destroy'

      expect(page).to have_content(I18n.t('workshops.workshop_destroyed'))
    end
  end
end
