require 'thor'

module BlitzBulletins
  class CLI < Thor

    desc "list", "List the Blitz Bulletin topics"
    method_option :before, :type => :string, :aliases => '-b'
    method_option :after, :type => :string, :aliases => '-a'
    method_option :descriptions, :type => :boolean, :aliases => '-d'
    method_option :subscribers, :type => :boolean, :aliases => '-s'
    method_option :posters, :type => :boolean, :aliases => '-p'
    method_option :format, :type => :string, :default => 'plain', :aliases => '-f'
    def list
      load_descriptions
      load_subscribers
      load_posters
      topics(descriptions?, subscribers?).each do |t|
        next unless t.before?(before)
        next unless t.after?(after)
        send("output_#{options[:format]}", t)
      end
    end

    private

    def output_plain(topic)
      puts topic
      posters_for_topic(topic.name) if posters?
    end

    def output_csv(topic)
      line = topic.to_csv
      if posters?
        posters_for_topic(topic.name, line)
      else
        puts line.join(', ')
      end
    end

    def posters_for_topic(name, line=nil)
      posters.in_topic[name].each do |p|
        next if p.expired?
        if line.nil?
          puts p.name_indented
        else
          out = line + [p.email]
          puts out.join(', ')
        end
      end
    end

    def before
      @before ||= parse_date(options[:before])
    end

    def after
      @after ||= parse_date(options[:after])
    end

    def parse_date(date)
      date.nil? ? nil : Date.parse(date)
    end

    def topics(with_desc = false, with_subs = false)
      BlitzBulletins.topics(with_desc, with_subs)
    end

    def descriptions?
      !BlitzBulletins.descriptions.empty?
    end

    def load_descriptions
      BlitzBulletins.load_descriptions if options[:descriptions]
    end

    def subscribers?
      !BlitzBulletins.subscribers.empty?
    end

    def load_subscribers
      BlitzBulletins.load_subscribers if options[:subscribers]
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
