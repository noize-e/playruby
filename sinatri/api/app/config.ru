require 'rack'
require 'rack/contrib'
require_relative './server'

set :root, File.dirname(__FILE__)

run API::App