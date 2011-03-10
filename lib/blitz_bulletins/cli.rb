require 'thor'

module BlitzBulletins
  class CLI < Thor

    desc "list", "List the Blitz Bulletin topics"
    method_option :before, :type => :string, :aliases => '-b'
    method_option :after, :type => :string, :aliases => '-a'
    def list
      topics.each do |t|
        next unless t.before?(before)
        next unless t.after?(after)
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

    def parse_date(date)
      date.nil? ? nil : Date.parse(date)
    end

    def topics
      BlitzBulletins.topics
    end
  end
end