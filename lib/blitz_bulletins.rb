require 'date'

require 'blitz_bulletins/cli'
require 'blitz_bulletins/topics'
require 'blitz_bulletins/topic'
require 'blitz_bulletins/descriptions'
require 'blitz_bulletins/posters'
require 'blitz_bulletins/poster'

module BlitzBulletins
  @@topics = []
  @@descriptions = {}
  @@posters = nil

  def self.load_topics(with_desc = false)
    return false unless @@topics.empty?
    @@topics = Topics.new(readlines('topics'), with_desc).list
    return true
  end

  def self.topics(with_desc = false)
    load_topics(with_desc)
    @@topics
  end

  def self.load_descriptions
    return false unless @@descriptions.empty?
    @@descriptions = Descriptions.new(readlines('descriptions')).hash
    return true
  end

  def self.descriptions
    @@descriptions
  end

  def self.load_posters
    return false unless @@posters.nil?
    @@posters = Posters.new(readlines('posters'))
    return true
  end

  def self.posters
    @@posters
  end

  def self.readlines(file)
    IO.readlines(File.expand_path("data/#{file}.txt"))
  end

end
