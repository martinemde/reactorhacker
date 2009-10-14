require File.dirname(__FILE__) + '/word_set'
require File.dirname(__FILE__) + '/pick'

class Term
  attr_reader :word_set, :picks

  def initialize(words)
    @word_set = WordSet.new(words)
    @picks = []
  end

  def suggest
    @word_set.suggest
  end

  # Send a pick with the word and the correct characters count
  def pick!(word, correct)
    pk = Pick.new(word, correct)
    @word_set = @word_set.remaining_after_pick(pk)
    @picks << pk
    self
  end

  def pick(word, correct)
    pk = Pick.new(word, correct)
    t = dup
    t.pick!(word, correct)
    t
  end

  def empty?
    @word_set.empty?
  end

  def possible_matches
    @word_set
  end

  def solved?
    @word_set.solved?
  end
end

