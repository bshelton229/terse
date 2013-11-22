class User < ActiveRecord::Base
  has_many :urls, dependent: :destroy
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def self.from_github_auth(auth)
    if auth['info'] && auth['info']['nickname']
      user = find_or_create_by username: auth['info']['nickname'].downcase

      if user.name != auth['info']['name'] || user.image_url !=  auth['info']['image']
        user.update name: auth['info']['name'], image_url: auth['info']['image']
      end

      user.persisted? ? user : false
    else
      false
    end
  end
end
