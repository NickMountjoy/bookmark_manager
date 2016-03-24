feature 'creating a new link' do
  scenario 'There is a form to input new link data' do
    visit '/links/new'
    expect(page).to have_field("title")
    expect(page).to have_field("url")
  end

  scenario 'The newly created link appears on the links page' do
    visit '/links/new'
    fill_in(:title, with: "MySpace")
    fill_in(:url, with: "www.myspace.com")
    click_button("Submit")
    within 'ul#links' do
      expect(page).to have_content("MySpace")
    end
  end
end
