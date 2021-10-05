module API
    module Routes

        ##
        # Routing class for /api/contact_message endpoint

        class ContactMessages < Sinatra::Application
            before do
                content_type 'application/json'
            end

            ##
            # getAllContactMessages
            # getContactMessagesFilteredByEmail

            get '/api/contact_message' do

                # matches "GET /contact_messages?email=`*@*.*`

                # 1. Missing attributes projection: Skip created_at and updated_at
                # 2. Missing attributes sorting: by creation date DESC

                if params.has_key?('email')
                    # Perform query with table's GSI: email_index
                    items = API::Models::ContactMessage.where(
                        :sk => 'API::Models::ContactMessage',
                        "email" => params['email']
                    )
                else
                    # Perform query with table's GSI: sk_index
                    items = API::Models::ContactMessage.where(
                        :sk => 'API::Models::ContactMessage'
                    )
                end

                items.to_json
            end

            ##
            # getContactMessageById

            get '/api/contact_message/:id' do
                # The range key could live in a gobal constant
                begin
                    item = API::Models::ContactMessage.find(params[:id], :range_key=>'API::Models::ContactMessage')
                    item.to_json
                rescue Dynamoid::Errors::RecordNotFound => error
                    halt 404, error.message
                end
            end

            ##
            # createContactMessage

            post '/api/contact_message' do
                begin
                    data = get_body_data(request)
                    item = API::Models::ContactMessage.new(
                        :email=>data["email"],
                        :content=>data["content"],
                        :first_name=>data["first_name"])
                    item.save!
                    {
                        :id => item.id,
                        :next => "/api/contact_messages/#{item.id}"
                    }.to_json
                rescue Dynamoid::Errors::DocumentNotValid => error
                    halt 403, error.message
                end
            end
        end


        ##
        # Routing class for /api/lead endpoint

        class LandpageLead < Sinatra::Application
            before do
                content_type 'application/json'
            end

            get '/api/lead' do
                items = API::Models::ContactMessage.where(
                    :sk => 'API::Models::LandpageLead'
                )
                items.to_json
            end

            post '/api/lead' do
                begin
                    data = get_body_data(request)
                    item = API::Models::LandpageLead.new(
                        :first_name => data["first_name"],
                        :last_name => data["last_name"],
                        :email => data["email"],
                        :phone => data["phone"],
                        :company_name => data["company_name"],
                        :company_industry => data["company_industry"])
                    item.save!
                    {
                        :id => item.id,
                        :next => "/api/lead/#{item.id}"
                    }.to_json
                rescue Dynamoid::Errors::DocumentNotValid => error
                    halt 403, error.message
                end
            end
        end
    end
end