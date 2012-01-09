module BlitzBulletins

  class Topic
    attr_reader :name, :date, :description

    def initialize(attribs)
      @name = attribs[:name]
      @date = attribs[:date] || Date.today
      @description = attribs[:description]
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

    def short_date
      @date.strftime("%m/%d/%Y")
    end
  end

end
