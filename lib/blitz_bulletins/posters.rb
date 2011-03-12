module BlitzBulletins
  class Posters
    attr_reader :hash, :in_topic

    def initialize
      @hash = {}
      @in_topic = Hash.new { |hash, key| hash[key] = [] }
    end

    def [](uid)
      hash[uid]
    end

    def []=(uid, poster)
      hash[uid] = poster
    end

    def parse_file
      readlines.each do |line|
        uid, topic = line.chomp.split(/:/)
        self[uid] ||= get_poster(uid)
        in_topic[topic.gsub('dartmouth.bulletins.', '')] << self[uid]
      end
    end

    def self.load
      posters = Posters.new
      posters.parse_file
      posters
    end

    private

    def get_poster(uid)
      BlitzBulletins::Poster.new(uid)
    end

    def readlines
      BlitzBulletins.readlines(:posters)
    end
  end
end
