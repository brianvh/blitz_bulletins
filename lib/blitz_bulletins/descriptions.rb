module BlitzBulletins
  class Descriptions
    attr_reader :hash

    def initialize(lines=[])
      @hash = {}
      parse(lines)
    end

    def parse(lines=[])
      lines.each do |line|
        name, desc = line.chomp.split(/:/)
        @hash[name] = desc
      end
    end
  end
end
