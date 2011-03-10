require 'thor'

module BlitzBulletins
  class CLI < Thor

    desc "list", "List the Blitz Bulletin topics"
    method_option :before, :type => :string, :aliases => '-b'
    def list
      topics.each do |t|
        next if not_before?(t.date)
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

    def topics
      BlitzBulletins.topics
    end
  end
end