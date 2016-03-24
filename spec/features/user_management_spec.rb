feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, joe@example.com')
    expect(User.first.email).to eq('joe@example.com')
  end
end

def sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email,    with: 'joe@example.com'
  fill_in :password, with: 'oranges!'
  click_button 'Sign up'
end
