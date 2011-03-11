require 'blitz_bulletins/cli'
require 'blitz_bulletins/topics'
require 'blitz_bulletins/topic'
require 'blitz_bulletins/descriptions'

module BlitzBulletins
  @@topics = []
  @@descriptions = {}

  def self.load_topics(with_desc = false)
    return false unless @@topics.empty?
    @@topics = BlitzBulletins::Topics.load(with_desc) and return true
  end

  def self.load_descriptions
    return false unless @@descriptions.empty?
    @@descriptions = BlitzBulletins::Descriptions.load and return true
  end

  def self.descriptions
    @@descriptions
  end

  def self.topics(with_desc = false)
    load_topics(with_desc)
    @@topics
  end

end
