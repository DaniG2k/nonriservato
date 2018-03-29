RSpec.feature 'Admins can destroy projects' do
  let(:admin) { create(:organization, :admin) }
  let(:project) { create(:project, organization: admin) }

  before do
    login_as(admin)
    visit edit_admin_project_path(project)
  end

  context 'successfully' do
    it 'destroying a project displays the correct message' do
      click_button 'Destroy'

      expect(page).to have_content(I18n.t('projects.project_destroyed'))
    end
  end
end
