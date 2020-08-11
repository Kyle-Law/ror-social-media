require 'rails_helper'
require 'capybara/rspec'

RSpec.describe UsersController, type: :feature do
  context 'GET users controller views' do
    let(:user) { User.create(id: '1', name: 'tester', email: 'tester@email.com', password: 'password') }

    before :each do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    

    it 'Get #show' do
      visit user_path(user)
      expect(page).to have_content('Name:')
    end
  end

  context 'Testing Add Friend' do
    let(:user) { User.create(id: '1', name: 'tester', email: 'tester@email.com', password: 'password') }

    before :each do
      User.create(id: '2', name: 'tester2', email: 'tester2@email.com', password: 'password')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    scenario 'friend request links' do
      visit users_path
      expect(page).to have_content('Add Friend')
    end

    scenario 'Add Friend' do
      visit users_path
      click_link 'Add Friend'
      expect(page).to have_content('Pending Request')
    end
  end

  context 'Testing Accept and Decline friend requests' do
    let(:user) { User.create(id: '1', name: 'tester', email: 'tester@email.com', password: 'password') }

    before :each do
      user2 = User.create(id: '2', name: 'tester2', email: 'tester2@email.com', password: 'password')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      visit users_path
      click_link 'Add Friend'
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user2.email
      fill_in 'user_password', with: user2.password
      click_button 'Log in'
      visit user_path(user2)
    end

    scenario 'accept friend request' do
      click_button 'Accept'
      visit users_path
      expect(page).to have_content('Already Friend')
    end

    scenario 'should create a new row with reversed attributes' do
      click_button 'Accept'
      expect(Friendship.where(user_id: '2', friend_id: '1', status: true)).not_to be_empty
    end

    scenario 'Reject friend request' do
      click_button 'Reject'
      visit users_path
      expect(page).to have_content('Add Friend')
    end
  end

  
end