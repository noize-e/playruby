helpers do
    def get_body_data(r)
        r.body.rewind
        data = JSON.parse r.body.read
        @params = Sinatra::IndifferentHash.new
        @params.merge!(data)
        data
    end
end