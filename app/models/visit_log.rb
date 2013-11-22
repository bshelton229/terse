class VisitLog < ActiveRecord::Base
  belongs_to :url
  validates :url, presence: true

  # Set ip and referer from a standard request object
  def request=(request)
    if request.respond_to?(:env) and request.env.kind_of?(Hash)
      self.ip = request.env["REMOTE_ADDR"] if request.env["REMOTE_ADDR"]
      self.referer = request.env["HTTP_REFERER"] if request.env["HTTP_REFERER"]
    end
  end
end
