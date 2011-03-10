require 'thor'

module BlitzBulletins
  class CLI < Thor

    desc "list", "List the Blitz Bulletin topics"
    method_option :before, :type => :string, :aliases => '-b'
    method_option :after, :type => :string, :aliases => '-a'
    def list
      topics.each do |t|
        next if not_before?(t.date)
        next if not_after?(t.date)
        puts t
      end
    end

    private

    def before
      return nil unless options[:before]
      @before ||= Date.parse(options[:before])
    end

    def not_before?(date)
      return false unless before
      before == date ? true : before < date
    end

    def after
      return nil unless options[:after]
      @after ||= Date.parse(options[:after])
    end

    def not_after?(date)
      return false unless after
      after == date ? false : after > date
    end

    def topics
      BlitzBulletins.topics
    end
  end
end