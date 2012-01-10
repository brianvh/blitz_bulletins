module BlitzBulletins

  class Topic
    attr_reader :name, :date, :description, :subscribers

    def initialize(attribs)
      @name = attribs[:name]
      @date = attribs[:date] || Date.today
      @description = attribs[:description]
      @subscribers = attribs[:subscribers]
    end

    def to_s
      "#{full_name}: #{short_date}#{subscriber_count}"
    end

    def to_csv
      [description, name, short_date, subscribers].compact
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

    def subscriber_count
      return '' if subscribers.nil?
      " -- #{subscribers} subscriber#{subscribers == 1 ? '' : 's'}"
    end
  end

end
