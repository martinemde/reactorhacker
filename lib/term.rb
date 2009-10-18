require 'word_set'
require 'pick'

class Term
  attr_reader :word_set, :picks

  def initialize(words)
    @word_set = WordSet.new(words)
    @picks = []
  end

  def empty?
    @word_set.empty?
  end

  def solved?
    @word_set.solved?
  end

  def suggest
    @suggest ||= @word_set.suggest
  end

  # Pass a set of picks like { "word" => 1, "other" => 3 }
  def after_picking(picks)
    return self unless picks.is_a?(Hash)
    picks.inject(self) { |term, (word, correct)| term.pick(word, correct) }
  end

  def pick(word, correct)
    dup.pick!(word, correct)
  end

  def possible_matches
    @word_set
  end

  protected

  # Send a pick with the word and the correct characters count
  def pick!(word, correct)
    pk = Pick.new(word, correct)
    @word_set = @word_set.remaining_after_pick(pk)
    self
  end

end

