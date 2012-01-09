module BlitzBulletins

  class Topics
    attr_reader :list

    def initialize(lines=[], with_desc = false)
      @descriptions = with_desc
      @list = []
      parse(lines)
    end

    def parse(lines=[])
      lines.each { |line| @list.push(topic_from_line(line.chomp)) }
    end

    def descriptions?
      @descriptions
    end

    private

    def topic_from_line(line)
      mon, day, year, name = parse_line(line)
      attribs = {:name => name, :date => Date.parse("#{mon} #{day} #{year}") }
      attribs[:description] = get_description(name) if descriptions?
      Topic.new(attribs)
    end

    def parse_line(line)
      pat = /^(...) +(\d+) +(\d\d:?\d\d) (.+)$/
      parts = pat.match(line).to_a[1..-1]
      parts[2] = Date.today.year if /:/ === parts[2]
      parts
    end

    def get_description(name)
      BlitzBulletins.descriptions[name]
    end
  end

end
