require File.dirname(__FILE__) + '/word_set'

class MatchRatio
  attr_reader :correct, :total

  def initialize(correct, total)
    @correct, @total = correct, total
    @words = []
  end

  def <<(possible)
    @words << possible
  end

  def solved?
    @words.size == 1
  end

  def word_set
    WordSet.new("Matching #{@correct}/#{@total}", @words, self)
  end

  def possible_word_sets
    word_set.possible_word_sets
  end

  def to_f
    @correct / @total.to_f
  end

  def to_s
    word_set.to_s
  end

  def <=>(mr)
    to_f <=> mr.to_f
  end
end
