require 'date'

module BlitzBulletins

  class Topic
    attr_reader :name, :date

    def initialize(name=nil, date=Date.today)
      @name = name
      @date = date
    end

    def to_s
      "#{@name}: #{short_date}"
    end

    def self.from_line(line)
      pat = /^(...) +(\d+) +(\d\d:?\d\d) (.+)$/
      mon, day, yr_time, name = pat.match(line).to_a[1..-1]
      yr_time = Date.today.year if /:/ === yr_time
      Topic.new(name, Date.parse("#{mon} #{day} #{yr_time}"))
    end

    private

    def short_date
      @date.strftime("%m/%d/%Y")
    end
  end

end
