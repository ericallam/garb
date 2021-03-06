module Garb
  class Profile
    
    attr_reader :table_id, :title, :account_name, :account_id, :web_property_id, :session
    
    class Property
      include HappyMapper
      
      tag 'property'
      namespace 'http://schemas.google.com/analytics/2009'
      
      attribute :name, String
      attribute :value, String

      def instance_name
        Garb.from_google_analytics(name)
      end
    end

    class Entry
      include HappyMapper
      
      tag 'entry'

      element :title, String
      element :tableId, String, :namespace => 'http://schemas.google.com/analytics/2009'

      has_many :properties, Property
    end

    def initialize(entry, session)
      @session = session
      @title = entry.title
      @table_id = entry.tableId

      entry.properties.each do |p|
        instance_variable_set :"@#{p.instance_name}", p.value
      end
    end

    def id
      Garb.from_google_analytics(@table_id)
    end

    def self.all(session)
      url = "https://www.google.com/analytics/feeds/accounts/default"
      response = session.request(url)
      Entry.parse(response.body).map {|entry| new(entry, session)}
    end
    
  end
end
