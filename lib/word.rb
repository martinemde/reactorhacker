class Word < String
  class Invalid < ArgumentError; end 

  def initialize(word)
    word = word.strip.downcase
    raise(Word::Invalid, "only letters allowed") unless word =~ /^[a-z]*$/
    super
  end

  # Given a set of words, return the number of tries for the worst case senario
  def max_solve_attempts(words)
    words.inject({}) do |h, word|
      mc = match_count(word)
      h[mc] ||= 0
      h[mc] += 1
      h
    end.values.max
  end

  def match_count(word)
    return size if self == word
    (0..size-1).to_a.select { |i| self[i] == word[i] }.size
  end

  def match_percentage(word)
    MatchPercentage.new(match_count(word), word.size)
  end
end
