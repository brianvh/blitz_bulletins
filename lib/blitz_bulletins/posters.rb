module BlitzBulletins
  class Posters
    attr_reader :hash, :in_topic

    def initialize(lines=[])
      @hash = {}
      @in_topic = Hash.new { |hash, key| hash[key] = [] }
      parse(lines)
    end

    def [](uid)
      hash[uid]
    end

    def []=(uid, poster)
      hash[uid] = poster
    end

    def parse(lines=[])
      lines.each do |line|
        uid, topic = line.chomp.split(/:/)
        self[uid] ||= get_poster(uid)
        in_topic[topic.gsub('dartmouth.bulletins.', '')] << self[uid]
      end
    end

    private

    def get_poster(uid)
      BlitzBulletins::Poster.new(uid)
    end
  end
end
