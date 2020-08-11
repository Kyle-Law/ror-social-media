require 'rails_helper'
require 'capybara/rspec'

RSpec.describe User, type: :model do
  context 'User associations tests' do
    it { should have_many(:posts)}
    it { should have_many(:comments)}
    it { should have_many(:likes)}
    it { should have_many(:friends)}
    it { should have_many(:inverse_friendships).class_name('Friendship').with_foreign_key('friend_id') }
  end
end