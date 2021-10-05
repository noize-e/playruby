 # app/server.rb
require 'rubygems'
require 'sinatra'
require 'aws-sdk'

Aws.config.update(
  region: 'us-east-1'
)

require_relative "helpers"
require_relative "models"
require_relative "routes"


module API
    class App < Sinatra::Application

        not_found do
          halt 404, "Opps"
        end


        error 400..500 do
            { code: status, message: body.join }.to_json
        end

        use API::Routes::ContactMessages
        use API::Routes::LandpageLead
    end
end