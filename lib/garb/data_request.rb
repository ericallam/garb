module Garb
  class DataRequest
    
    def self.get(url, auth_token, parameters={})
      uri = URI.parse(url)
      
      parameter_list = parameters.map {|k,v| "#{k}=#{v}" }
      query_string = parameter_list.empty? ? '' : "?#{parameter_list.join('&')}"
      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = http.get("#{uri.path}#{query_string}", 'Authorization' => "GoogleLogin auth=#{auth_token}")
      raise response.body.inspect unless response.is_a?(Net::HTTPOK)
      response
    end

  end
end