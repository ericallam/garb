module Garb
  class Session

    attr_accessor :auth_token, :email
    
    def login(email, password, opts={})
      self.email = email
      auth_request = AuthenticationRequest.new(email, password, opts)
      self.auth_token = auth_request.auth_token(opts)
    end
    
    def profiles
      @profiles ||= Profile.all(self)
    end
    
    def request(url, params={})
      DataRequest.new(url, self.auth_token, params).send_request
    end
  end
end
