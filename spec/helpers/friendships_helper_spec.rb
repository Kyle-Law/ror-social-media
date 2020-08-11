require 'rails_helper'
require 'capybara/rspec'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user) { User.create(id: '1', name: 'Peter', email: 'peter@example.com', password: 'password') }
  let(:user2) { User.create(id: '2', name: 'Mick', email: 'mick@example.com', password: 'password') }
  let(:friendship) { Friendship.create(user_id: user.id, friend_id: user2.id, status: false) }

  context 'Test accept friend method' do
    it 'Should return an accept link' do
      expect(accept_friend(friendship)).to have_content('Accept')
    end
  end

  context 'Test decline friend method' do
    it 'should return a decline link' do
      expect(reject_friend(friendship)).to have_content('Decline')
    end
  end
end