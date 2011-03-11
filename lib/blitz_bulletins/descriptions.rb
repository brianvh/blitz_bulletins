module BlitzBulletins
  class Descriptions
    attr_reader :hash

    def initialize
      @hash = {}
    end

    def parse_file
      readlines.each do |line|
        name, desc = line.chomp.split(/:/)
        @hash[name] = desc
      end
    end

    def self.load
      descriptions = Descriptions.new
      descriptions.parse_file
      descriptions.hash
    end

    private

    def readlines
      IO.readlines(File.expand_path('data/descriptions.txt'))
    end
  end
end
