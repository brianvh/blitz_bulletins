require 'thor'

module BlitzBulletins
  class CLI < Thor

    desc "list", "List the Blitz Bulletin topics"
    method_option :before, :type => :string, :aliases => '-b'
    method_option :after, :type => :string, :aliases => '-a'
    method_option :descriptions, :type => :boolean, :aliases => '-d'
    def list
      load_descriptions
      topics(descriptions?).each do |t|
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

    def topics(with_desc = false)
      BlitzBulletins.topics(with_desc)
    end

    def descriptions?
      !BlitzBulletins.descriptions.empty?
    end

    def load_descriptions
      BlitzBulletins.load_descriptions if options[:descriptions]
    end
  end
end
