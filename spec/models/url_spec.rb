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
      expect(url.errors[:full].first).to match %r{is not a url}
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

  it 'Should normalise URLs' do
    url = Url.create full: 'hTTp://ShelTonPlace.com/'
    expect(url).to be_persisted
    expect(url.full).to eq("http://sheltonplace.com")
  end

  it 'Should generate a slug for each URL' do
    url = create(:url)
    expect(url.slug).to_not be_nil
  end

  it 'Should enforce unique slugs, case sensitive' do
    url = create(:url, slug: 'aBc')
    expect(url).to be_persisted

    url2 = build(:url, slug: 'aBc')
    expect(url2).to_not be_valid
    expect(url2.errors[:slug].first).to match %r{taken}

    url3 = build(:url, slug: 'ABc')
    expect(url3).to be_valid
  end

  it 'Should be able to attach a user' do
    user = create(:user)
    url = create(:url, user: user)
    expect(url.user).to eq(user)
  end

  it 'Should provide an expand class method' do
    url = create(:url, full: 'http://sheltonplace.com')
    expect(url).to be_persisted
    expect(Url.expand url.slug).to eq("http://sheltonplace.com")
    expect(Url.expand "badslug").to be_nil
  end

  it "Should try to get the remote site's title" do
    url = create(:url)
    expect(url.title).to eq("Bryan Shelton | Home")
  end

  it "Should leave title blank if it can't reach a host" do
    url = create(:url, full: 'http://baddomain.com')
    expect(url).to be_persisted
    a_request(:get, "http://baddomain.com").should have_been_made
    expect(url.title).to be_nil
  end

  context 'Redirection' do
    it 'Should provide a redirect! class method, which will add a visit, and return a model or nil' do
      url = create(:url)
      expect(url.visits).to be_blank
      redirect = Url.redirect! url.slug
      expect(redirect).to eq(url)
      expect(url.visits.count).to eq(1)

      redirect = Url.redirect! url.slug
      expect(url.visits.count).to eq(2)

      expect(url.visit_count).to eq(2)
    end

    it 'Should return nil if there is no slug found' do
      redirect = Url.redirect! 'badslug'
      expect(redirect).to be_nil
    end
  end
end
