
# As a user
# So that I can view my saved links
# I want a homepage that displays all my saved links
feature 'View links on homepage' do
  scenario 'Includes one persistant link on homepage' do
    Link.create(url: "www.google.com", title: "Google")
    visit '/links'
    within 'ul#links' do
      expect(page).to have_content "Google"
    end
  end
end
