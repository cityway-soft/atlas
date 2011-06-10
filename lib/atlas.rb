require 'active_support/core_ext'

module Atlas
  mattr_accessor :logger

  def self.logger
    @@logger ||= Logger.new("log/atlas.log")
  end
end

class String
  def to_word
    Atlas::Word.to_word(self)
  end

  def to_words
    Atlas::Word.to_words(self)
  end

  def to_tokens_or_words
    Atlas::StringContainer.to_tokens_or_words(self)
  end
end

class Array
  def to_words
    Atlas::Word.to_words(self)
  end

  def to_tokens_or_words
    Atlas::StringContainer.to_tokens_or_words(self)
  end
end

require 'atlas/trie'
require 'atlas/benchmarking'
require 'atlas/string_container'
require 'atlas/token'
require 'atlas/word'
require 'atlas/word_parser'
require 'atlas/phonetic'
require 'atlas/word_index'
require 'atlas/road'
require 'atlas/road_section'
require 'atlas/address'
require 'atlas/location'
require 'atlas/zone'
require 'atlas/location_index'
require 'atlas/ign'
require 'atlas/ign/route'
require 'atlas/scoring'
require 'atlas/score_board'
require 'atlas/word_set_matcher'
require 'atlas/suggestion'
require 'atlas/geocoding'
