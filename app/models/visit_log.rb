class VisitLog < ActiveRecord::Base
  belongs_to :url
  validates :url, presence: true
end
