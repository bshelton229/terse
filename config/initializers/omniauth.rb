Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, fields: [:nickname, :name] unless Rails.env.production?
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end
