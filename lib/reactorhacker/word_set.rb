module ReactorHacker
  class WordSet < Array
    class WordNotFound < ArgumentError; end

    def self.normalize(words)
      words = words.split(/[^a-z]/i) if words.is_a? String
      words.map { |w| Word.new(w) }.reject { |w| w.empty? }.uniq
    end

    def initialize(words)
      super self.class.normalize(words)
    end

    def suggestion
      map { |word| [word.max_solve_attempts(self), word] }.min.last
    end

    def remaining_after_pick(pick)
      matches = select { |word| pick.match?(word) }
      if matches.empty?
        raise WordSet::WordNotFound, "Word not found in set: #{pick}"
      end
      matches
    end

    def solved?
      size == 1
    end

    def select
      WordSet.new(super)
    end
  end
end
