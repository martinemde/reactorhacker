#
# for each word determine response from term for all passwords
#
# find remaining passwords for each first attempt for each password
#   Remaining passwords have the attempted word with the same ratio
#   each actual, find where attempted.ratio == returned ratio
#   

require File.dirname(__FILE__) + '/word'

class Term
  attr_reader :words, :picks

  def initialize(words)
    @words = words.split(/[^a-z]/i).reject { |word| word.empty? }.map { |w| Word.new(w) }
    @picks = []
  end

  def empty?
    @words.empty?
  end

  def pick(word)
    @picks << words.find { |w| word == w }
  end

  def choices
    @words - @picks
  end
end

def brainstorm
  word_set = WordSet.new("All", words.map { |w| Word.new(w) })

  first_pass = word_set.possible_word_sets
  puts first_pass.map { |k,v| "Attempt #{k}:\n#{v.sort.to_s}\n" }

  word_set.possible_word_sets.each do |first,match_ratios|
    if first == 'bullet'
      puts 'Picked bullet'
      second_pass = match_ratios.find { |mr| mr.correct == 0 and mr.total == 6 }
      puts second_pass.word_set.possible_word_sets.map { |k,v| "Attempt #{k}:\n#{v.sort.to_s}\n" }
=begin
      second_pass.each do |k,v|
        if k == 'called'
          puts 'Picked called'
          third_pass = v.find { |mr| mr.correct == 3 && mr.total == 6 }.word_set.possible_word_sets
          puts third_pass.map { |k,v| "Attempt #{k}:\n#{v.sort.to_s}\n" }
        end
      end
=end
    end
  end
end

