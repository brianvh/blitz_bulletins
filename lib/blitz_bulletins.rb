require 'blitz_bulletins/cli'

module BlitzBulletins
  @@topics = []

  autoload :Topics, 'blitz_bulletins/topics'

  def self.load_topics
    return false unless @@topics.empty?
    @@topics = BlitzBulletins::Topics.load and return true
  end

  def self.topics
    load_topics
    @@topics
  end

end