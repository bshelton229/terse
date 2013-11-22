class Url < ActiveRecord::Base
  belongs_to :user
  validates :full, url: true
end
