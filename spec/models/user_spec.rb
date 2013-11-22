require 'spec_helper'

describe User do
  it 'Should require a username' do
    user = build(:user, username: nil)
    expect(user).to_not be_valid
    expect(user.errors[:username].first).to match %r{can't be blank}
  end

  it 'Should require a unique username, case insensitive' do
    user1 = create(:user)
    user2 = build(:user, username: user1.username.upcase)
    expect(user2).to_not be_valid
    expect(user2.errors[:username].first).to match %r{has already been taken}
  end

  context 'Omniauth' do
    let(:auth) do
      {
        'info' => {
          'name' => 'Bryan Shelton',
          'nickname' => 'bshelton229'
        }
      }
    end

    it 'Should create and return a user from an omniauth response' do
      user = User.from_github_auth(auth)
      expect(user.username).to eq('bshelton229')

      user2 = User.from_github_auth(auth)
      expect(user2).to eq(user)
    end

    it 'Should return false when the user cannot be created' do
      resp = auth
      resp['info']['nickname'] = nil
      expect(User.from_github_auth(resp)).to be_false
    end
  end
end
