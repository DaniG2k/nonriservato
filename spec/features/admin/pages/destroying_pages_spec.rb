# require 'rails_helper'
#
# RSpec.feature 'Admins can destroy pages' do
#   let(:admin) { FactoryBot.create(:organization, :admin) }
#   let!(:page) { FactoryBot.create(:page) }
#
#   before do
#     login_as(admin)
#     visit edit_page_path(page)
#   end
#
#   context 'successfully' do
#     it 'destroying a page displays the correct message' do
#       click_button 'Destroy'
#
#       expect(page).to have_content(I18n.t('pages.page_destroyed'))
#     end
#   end
# end
