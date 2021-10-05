require './lib/authorizer/misc/ext/tasks_pipeline'
require 'spec_helper'

describe Authorizer::Misc::Ext::TasksPipeline do
	let!(:tasks_pipeline) { Authorizer::Misc::Ext::TasksPipeline }
  subject { Object.new.extend(tasks_pipeline) }

  it 'adds tasks and executes the pipeline' do
    def subject.pipeline
      add_task { puts 'Hello' }
      add_task { puts 'my name is' }
      add_task { puts 'Mr. Robot' }
      execute_first_task
    end

    subject.pipeline

    expect(subject.get_status).to eq(:end)
  end
end
