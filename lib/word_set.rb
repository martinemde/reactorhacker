class WordSet
  def initialize(name, words, match_ratio = nil)
    @name, @words = name, words
    @match_ratio = match_ratio
  end

  def match_ratios_for(pick)
    @words.inject({}) do |h, actual|
      mr = pick.match_ratio(actual)
      h[mr.to_s] ||= mr
      h[mr.to_s] << actual
      h
    end.values
  end

  def possible_word_sets
    @matches = @words.inject({}) do |all, attempted|
      all[attempted] = match_ratios_for(attempted)
      all
    end
  end

  def solved?
    @words.size == 1
  end

  def to_s
    if solved?
      "#{@name}: **Solved: *#{@words.first}*\n"
    else
      "#{@name}: #{@words.join(', ')}\n"
    end
  end
end
