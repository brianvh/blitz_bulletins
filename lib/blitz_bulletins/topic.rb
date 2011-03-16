module BlitzBulletins

  class Topic
    attr_reader :name, :date

    def initialize(name, date=Date.today, with_desc = false)
      @name = name
      @date = date
      @description = nil
      @with_desc = with_desc
    end

    def to_s
      "#{full_name}: #{short_date}"
    end

    def to_csv
      [description, name, short_date].compact
    end

    def before?(before)
      before.nil? ? true : date < before
    end

    def after?(after)
      after.nil? ? true : date >= after
    end

    def full_name
      description.nil? ? name : "#{description} (#{name})"
    end

    def description
      @description ||= get_description
    end

    def self.from_line(line, with_desc = false)
      pat = /^(...) +(\d+) +(\d\d:?\d\d) (.+)$/
      mon, day, yr_time, name = pat.match(line).to_a[1..-1]
      yr_time = Date.today.year if /:/ === yr_time
      Topic.new(name, Date.parse("#{mon} #{day} #{yr_time}"), with_desc)
    end

    private

    def short_date
      @date.strftime("%m/%d/%Y")
    end

    def description?
      @with_desc
    end

    def get_description
      description? ? BlitzBulletins.descriptions[name] : nil
    end
  end

end
