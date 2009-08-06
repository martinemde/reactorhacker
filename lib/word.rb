require File.dirname(__FILE__) + '/match_ratio'

class Word < String
  def initialze(word)
    raise ArgumentError, "Words can only be letters." unless word =~ /^[A-Z]+$/i
    super
  end

  def remaining(words)
  end

  def match_ratio(actual)
    return MatchRatio.new(size, size) if self == actual
    matches = 0
    0.upto(size - 1) do |i|
      matches += 1 if self[i] == actual[i]
    end
    MatchRatio.new(matches, actual.size)
  end
end
