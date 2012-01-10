module BlitzBulletins
  class Subscribers
    attr_reader :hash

    def initialize(lines=[])
      @hash = {}
      parse(lines)
    end

    def parse(lines=[])
      lines.each do |line|
        name, count = line.chomp.split(/:/)
        @hash[name] = count.to_i
      end
    end
  end
end
