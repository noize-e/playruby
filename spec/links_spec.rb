require 'spec_helper'
require 'links_reader'


describe Links do
  let(:links) { %{http://docker.com | docker
                  http://google.com?query=docker | Google Search}.split(/\n+/) }
  let(:param) { "docker" }
  let(:excludes) { ["google"] }
  subject { described_class.new(links) }
  
  context "Filter by (case-insensitive)" do
    it 'Single parameter' do
      expect(subject.filter(param).titles).to eq([[1, 'docker'], [2, "Google Search"]]) 
    end

    it 'Single parameter with exclusion' do
      expect(subject.filter(param, exclude: excludes).titles).to eq([[1, 'docker']]) 
    end
  end
end
