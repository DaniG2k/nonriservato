# TODO
# Fix this spec
# RSpec.feature 'Admins can destroy events' do
#   let(:admin) { create(:organization, :admin) }
#   let(:project) { create(:project, organization: admin) }
#   let(:event) { create(:event, organization: admin, project: project) }
#
#   before do
#     login_as(admin)
#     visit edit_admin_event_path(event)
#   end
#
#   context 'successfully' do
#     it 'destroying an event displays the correct message' do
#       click_button 'Destroy'
#
#       expect(page).to have_content(I18n.t('events.event_destroyed'))
#     end
#   end
# end
