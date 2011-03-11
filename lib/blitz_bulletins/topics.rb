module BlitzBulletins

  class Topics
    attr_reader :list

    def initialize(with_desc = false)
      @descriptions = with_desc
      @list = []
    end

    def parse_file
      readlines.each { |line| @list.push(topic_from_line(line)) }
    end

    def descriptions?
      @descriptions
    end

    def self.load(with_desc = false)
      topics = Topics.new(with_desc)
      topics.parse_file
      topics.list
    end

    private

    def topic_from_line(line)
      BlitzBulletins::Topic.from_line(line, descriptions?)
    end

    def readlines
      IO.readlines(File.expand_path('data/topics.txt'))
    end
  end

end
