require 'spec_helper'

describe UrlsController do
  it 'Should re-direct to expanded slugs' do
    url = create(:url, full: 'http://sheltonplace.com')
    get :resolve, slug: url.slug
    expect(response).to redirect_to("http://sheltonplace.com")
  end

  it 'Shoudl return 404 for non-existing slugs' do
    get :resolve, slug: 'bad'
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end
