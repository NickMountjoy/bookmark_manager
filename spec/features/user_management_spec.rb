feature 'User sign up' do

  scenario 'Requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end


  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, joe@example.com')
    expect(User.first.email).to eq('joe@example.com')
  end
end

def sign_up(email: 'joe@example.com',
            password: '12345678',
            password_confirmation: '12345678')
  visit '/users/new'
  fill_in :email,                 with: email
  fill_in :password,              with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end
