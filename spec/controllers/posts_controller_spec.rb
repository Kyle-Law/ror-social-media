require 'rails_helper'
require 'capybara/rspec'
# rubocop:disable  Metrics/BlockLength
RSpec.describe PostsController, type: :feature do
  context 'timeline displays friends posts' do
    let(:user) { User.create(id: '1', name: 'happy', email: 'happy@gmail.com', password: 'happypassword') }

    scenario "display current user's post" do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      fill_in 'post_content', with: 'Here is a random content for testing'
      click_button 'Save'
      visit root_path
      expect(page).to have_content('Here is a random content for testing')
    end

    scenario 'display friends posts' do
      user2 = User.create(id: '2', name: 'emo', email: 'emo@gmail.com', password: 'emopassword')
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
      click_button 'Accept'
      visit root_path
      fill_in 'post_content', with: 'Here is a content by user2'
      click_button 'Save'
      sleep(2)
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      expect(page).to have_content('Here is a content by user2')
    end

    scenario 'cannot see posts if are not friends' do
      user2 = User.create(id: '2', name: 'sad', email: 'sad@gmail.com', password: 'password')
      visit new_user_session_path
      fill_in 'user_email', with: user2.email
      fill_in 'user_password', with: user2.password
      click_button 'Log in'
      visit root_path
      fill_in 'post_content', with: 'Here is a post by user2'
      click_button 'Save'
      sleep(2)
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      expect(page).not_to have_content('Here is a post by user2')
    end
  end
  # rubocop:enable  Metrics/BlockLength
end
