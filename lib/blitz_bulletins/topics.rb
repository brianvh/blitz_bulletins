module BlitzBulletins

  class Topics
    attr_reader :list

    def initialize
      @list = []
    end

    def parse_file
      readlines.each { |line| @list.push(topic_from_line(line)) }
    end

    def self.load
      topics = Topics.new
      topics.parse_file
      topics.list
    end

    private

    def topic_from_line(line)
      BlitzBulletins::Topic.from_line(line)
    end

    def readlines
      IO.readlines(File.expand_path('data/topics.txt'))
    end
  end

end
