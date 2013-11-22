class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      uri = URI.parse(value)
      resp = uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
    rescue URI::InvalidURIError
      resp = false
    end
    unless resp == true
      record.errors[attribute] << (options[:message] || "is not a url")
    end
  end
end
