module Garb
  class Session

    attr_accessor :auth_token, :email, :requestor_method
    
    def login(email, password, opts={})
      self.email = email
      auth_request = AuthenticationRequest.new(email, password, opts)
      self.auth_token = auth_request.auth_token(opts)
    end
    
    def profiles
      @profiles ||= Profile.all(self)
    end
    
    def request(url, params={})
      requestor_method.call(self, url, params)
    end
    
    def requestor_method
      @requestor_method ||= Proc.new do |s, url, params|
        DataRequest.get(url, s.auth_token, params)
      end
    end
    
  end
end
