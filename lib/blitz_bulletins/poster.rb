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

    def email
      profile.nil? ? nil : profile.email
    end

    def name_indented
      "    #{name}"
    end

    private

    def profile
      @profile ||= lookup
    end

    private

    def lookup
      dnd_prof = nil
      Net::DartmouthDND.start(%w(name email expires)) do |dnd|
        dnd_prof = dnd.find(uid, :one)
      end
      dnd_prof
    end

    def has_expired?
      return false if profile.expires.empty?
      Date.today > Date.parse(profile.expires)
    end
  end
end
