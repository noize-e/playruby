# frozen_string_literal: true
# 
def load_dir(path)
  warpath = File.expand_path(path, __dir__)
  $LOAD_PATH.unshift(warpath) unless $LOAD_PATH.include?(warpath)
end

load_dir 'authorizer'
require 'service/layer'

Authorizer::Application::Layer.run
