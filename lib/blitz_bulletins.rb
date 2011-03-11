require 'blitz_bulletins/cli'
require 'blitz_bulletins/topics'
require 'blitz_bulletins/topic'

module BlitzBulletins
  @@topics = []
  @@descriptions = {}

  def self.load_topics
    return false unless @@topics.empty?
    @@topics = BlitzBulletins::Topics.load and return true
  end

  def self.load_descriptions
    return false unless @@descriptions.empty?
    @@descriptions = BlitzBulletins::Descriptions.load and return true
  end

  def self.descriptions
    @@descriptions
  end

  def self.topics
    load_topics
    @@topics
  end

end