RSpec.feature 'Admins can destroy posts' do
  let(:admin) { FactoryBot.create(:organization, :admin) }
  let(:post) { FactoryBot.create(:post) }

  before do
    login_as(admin)
    visit edit_admin_post_path(post)
  end

  context 'successfully' do
    it 'destroying a project displays the correct message' do
      click_button 'Destroy'

      expect(page).to have_content(I18n.t('posts.post_destroyed'))
    end
  end
end
