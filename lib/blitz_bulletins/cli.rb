require 'thor'

module BlitzBulletins
  class CLI < Thor

    desc "list", "List the Blitz Bulletin topics"
    def list
      topics.each { |t| puts t }
    end

    private

    def topics
      BlitzBulletins.topics
    end
  end
end