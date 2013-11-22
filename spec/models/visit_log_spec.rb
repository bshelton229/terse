require 'spec_helper'

describe VisitLog do
  it 'Should require a url' do
    url = create(:url)
    visit = VisitLog.new
    expect(visit).to_not be_valid

    visit.url = url
    expect(visit).to be_valid
    expect(visit.save).to be_true
    expect(visit).to be_persisted
  end
end
