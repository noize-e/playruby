require './lib/authorizer/data/manager/transaction'
require 'spec_helper'

describe Authorizer::Data::Manager::Transaction do
  subject { described_class.instance }
  let!(:bank_operation_json) { {"transfer": { "amount": 1000 }} }
  let!(:bank_operation) { lambda { 3000 - 100 } }
  let!(:transfer_class) { Class.new do def initialize(type, data, &tasks); end; end }

  it 'registers subtasks for (n) type transaction' do
    subject.add_tasks_for :transfer do
      add_task { bank_operation }
    end

    expect(subject.get_tasks_for(:transfer)).to be_instance_of(Proc)
  end

  it 'builds a transaction of (n) type' do
    transaction = subject.build(bank_operation_json, transfer_class)

    expect(transaction).to be_kind_of(transfer_class)
  end
end
