require 'spec_helper'

describe UrlsController do
  it 'Should re-direct to expanded slugs' do
    url = create(:url, full: 'http://sheltonplace.com')
    get :resolve, slug: url.slug
    expect(response).to redirect_to("http://sheltonplace.com")
    expect(url.visit_count).to eq(1)
    visit = url.visits.first
    expect(visit.ip).to eq(request.env['REMOTE_ADDR'])
    expect(visit.referer).to eq(request.env['HTTP_REFERER'])
  end

  it 'Shoudl return 404 for non-existing slugs' do
    get :resolve, slug: 'bad'
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end

  it 'Should be able to create urls for anonymous users' do
    post :create, url: {full: 'http://sheltonplace.com'}
    url = assigns(:url)
    expect(url).to be_persisted
  end

  it 'Should assign the current user to the url if someone is logged in' do
    user = create(:user)
    login(user)
    post :create, url: {full: 'http://sheltonplace.com'}
    url = assigns(:url)
    expect(url.user).to eq(user)
  end
end
