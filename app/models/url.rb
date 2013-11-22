class Url < ActiveRecord::Base
  belongs_to :user
  validates :full, url: true
  before_create :normalize_url

  private
    def normalize_url
      uri = URI.parse full
      uri.hostname.downcase!
      self.full = uri.to_s
      # If the request URI is simply, then remove it
      self.full.gsub!(/\/\z/,"") if uri.request_uri.eql?("/")
    end
end
