require 'thor'

module BlitzBulletins
  class CLI < Thor

    desc "list", "List the Blitz Bulletin topics"
    method_option :before, :type => :string, :aliases => '-b'
    method_option :after, :type => :string, :aliases => '-a'
    method_option :descriptions, :type => :boolean, :aliases => '-d'
    method_option :posters, :type => :boolean, :aliases => '-p'
    def list
      load_descriptions
      load_posters
      topics(descriptions?).each do |t|
        next unless t.before?(before)
        next unless t.after?(after)
        puts t
        posters_for_topic(t.name) if posters?
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

    def posters_for_topic(name)
      posters.in_topic[name].each { |p| puts p.name_indented unless p.expired?}
    end

    def posters?
      !BlitzBulletins.posters.nil?
    end

    def posters
      BlitzBulletins.posters
    end

    def load_posters
      BlitzBulletins.load_posters if options[:posters]
    end
  end
end
