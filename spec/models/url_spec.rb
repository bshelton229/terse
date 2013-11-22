require 'spec_helper'

describe Url do
  it 'Should only allow valid URLS' do
    %w{
      http:
      nothing
      bryan.com/hello
      http://
    }.each do |url|
      url = Url.new full: url
      expect(url).to_not be_valid
    end
  end

  it 'Should allow good urls' do
    %w{
      http://test.com
      http://sheltonplace.com/test?url=string&another=string
      https://domain.com
      https://domain.com/path
    }.each do |url|
      url = Url.new full: url
      expect(url).to be_valid
    end
  end
end
