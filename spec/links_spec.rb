require 'spec_helper'
require 'links'

describe Links do
  let(:links) { %{http://docker.com | docker
                  http://google.com?query=docker | Google Search}.split(/\n+/) }
  let(:param) { 'docker' }
  let(:excludes) { ['google'] }
  let(:google_search_id) { 2 }
  let(:google_search_data) { ['Google Search', 'http://google.com?query=docker'] }
  subject { described_class.new(links) }
  
  context 'Filter by parameter(case-insensitive)' do
    it 'Select g search title and url' do
      subject.filter(param)
      subject.select_url(google_search_id)

      expect([subject.title, subject.url]).to eq(google_search_data)
    end
  end
end
