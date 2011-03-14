require 'net/dnd'

module BlitzBulletins
  class Poster
    attr_reader :uid

    def initialize(uid)
      @uid = uid
      @profile = nil
      @expired = nil
    end

    def expired?
      @expired ||= profile.nil? ? true : has_expired?
    end

    def name
      profile.nil? ? nil : profile.name
    end

    def name_indented
      "    #{name}"
    end

    private

    def profile
      lookup if @profile.nil?
      @profile
    end

    private

    def lookup
      Net::DartmouthDND.start(%w(name expires)) do |dnd|
        @profile = dnd.find(uid, :one)
      end
    end

    def has_expired?
      return false if profile.expires.empty?
      Date.today > Date.parse(profile.expires)
    end
  end
end
