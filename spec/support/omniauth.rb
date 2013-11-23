# Omniauth testing
OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  provider: 'github',
  info: {
    nickname: 'bshelton229',
    name: 'Bryan Shelton'
  }
})
