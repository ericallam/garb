module Garb
  module Version

    MAJOR = 0
    MINOR = 5
    TINY  = 2

    def self.to_s # :nodoc:
      [MAJOR, MINOR, TINY].join('.')
    end

  end
end
