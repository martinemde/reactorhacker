require 'word'

class Pick
  attr_reader :word, :correct

  def initialize(word, correct)
    @word, @correct = Word.new(word), correct.to_i
  end

  def match?(attempt)
    @word.match_count(attempt) == @correct
  end

  def to_s
    "#@word:#@correct"
  end
end
