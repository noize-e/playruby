require './lib/authorizer/domain/transaction/processor'
require './lib/authorizer/domain/router'
require 'spec_helper'

describe Authorizer::Domain::Router do
  let(:operations) { {"account": {"active-card": true, "available-limit": 100}} }
  let(:processor) { Authorizer::Domain::Transaction::Processor.new(operations) }
  subject { described_class.new(processor) }
  it 'runs' do
	  subject
  end
end
