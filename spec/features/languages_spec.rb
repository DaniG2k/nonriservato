RSpec.feature 'Website visitors can change page language' do
  before { visit root_path }

  scenario 'to Italian' do
    within('.flags') do
      find("a[href='/it']").click
    end

    expect(page).to have_selector("html[lang='it']")
  end

  scenario 'to English' do
    within('.flags') do
      find("a[href='/en']").click
    end

    expect(page).to have_selector("html[lang='en']")
  end
end
