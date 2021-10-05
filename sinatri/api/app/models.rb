require 'dynamoid'

Dynamoid.configure do |config|
  config.namespace = nil
  config.read_capacity = 2 # Read capacity for your tables
  config.write_capacity = 2 # Write capacity for your tables
end


module API
  module Models

    ##
    # This class represents the application table (DynamoDB Single Table Model).

    class SinatraApp
      include Dynamoid::Document

      table :name => 'SinatraApp',
            :key => :id,
            :read_capacity => 2,
            :write_capacity => 2,
            :inheritance_field => :sk

      range :sk, :string

      field :email

      global_secondary_index :name => :sk_index,
                             :hash_key => :sk,
                             :projected_attributes => :all

      global_secondary_index :name => :email_index,
                             :hash_key => :sk,
                             :range_key => :email,
                             :projected_attributes => :all
    end

    ##
    # This class represents a landing page lead in the app table

    class LandpageLead < SinatraApp

      # magic fields: id, created_at and updated_at

      field :first_name
      field :last_name
      field :phone
      field :company_name
      field :company_industry

      validates_presence_of :first_name,
                            :last_name,
                            :phone,
                            :email,
                            :company_name,
                            :company_industry
      validates_format_of :email, with: /@/
      validates :phone, length: { minimum: 10, maxium: 10 }

    end

    ##
    # This class represents a contact message in the app table.

    class ContactMessage < SinatraApp

      # magic fields: id, created_at and updated_at

      field :first_name
      field :content

      validates_presence_of :first_name,
                            :email,
                            :content
      validates_format_of :email, with: /@/
    end
  end
end