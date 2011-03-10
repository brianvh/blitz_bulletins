require 'thor'

module BlitzBulletins
  class CLI < Thor

    desc "list", "List the Blitz Bulletin topics"
    method_option :before, :type => :string, :aliases => '-b'
    method_option :after, :type => :string, :aliases => '-a'
    def list
      topics.each do |t|
        next unless before?(t.date)
        next unless after?(t.date)
        puts t
      end
    end

    private

    def before
      @before ||= parse_date(options[:before])
    end

    def after
      @after ||= parse_date(options[:after])
    end

    def before?(date)
      before.nil? ? true : date < before
    end

    def after?(date)
      after.nil? ? true : date >= after
    end

    def parse_date(date)
      date.nil? ? nil : Date.parse(date)
    end

    def topics
      BlitzBulletins.topics
    end
  end
end