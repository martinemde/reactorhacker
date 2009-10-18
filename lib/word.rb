class Word < String
  class Invalid < ArgumentError; end 

  def initialize(word)
    word = word.strip.downcase
    raise(Invalid, "only letters allowed") unless word =~ /^[a-z]*$/
    super
  end

  # Given a set of words, return the number of tries for the worst case senario
  def max_solve_attempts(words)
    solve_attempts_by_match_count(words).values.max
  end

  def solve_attempts_by_match_count(words)
    words.inject(zero_default_hash) { |h, word| h[match_count(word)] += 1; h }
  end

  def match_count(word)
    scan(/./).zip(word.scan(/./)).select { |(a,b)| a == b }.size
  end

  protected

  def zero_default_hash
    Hash.new { |h, k| h[k] = 0 }
  end
end
