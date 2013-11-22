class Url < ActiveRecord::Base
  belongs_to :user
  has_many :visits, class_name: 'VisitLog'
  validates :full, url: true
  validates :slug, uniqueness: true
  before_create :normalize_full, :generate_slug

  # Expand a slug to a full url
  def self.expand(slug)
    ( url = find_by slug: slug ) ? url.full : nil
  end

  # Takes a slug and a controller request object
  # Returns either a url object, or nil
  def self.redirect!(slug, request=nil)
    url = find_by slug: slug
    if url
      url.visits.create(request: request)
      url
    else
      nil
    end
  end

  def visit_count
    visits.count
  end

  private
    def generate_slug
      self.slug = SecureRandom.urlsafe_base64(Random.new.rand(4..8)).gsub(%r{[^0-9a-z]}i, "") if self.slug.blank?
    end

    def normalize_full
      uri = URI.parse full
      uri.hostname.downcase!
      self.full = uri.to_s
      # If the request_uri is simply /, then remove it
      self.full.gsub!(/\/\z/,"") if uri.request_uri.eql?("/")
    end
end
