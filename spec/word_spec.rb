require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'word'

describe Word do
  subject { Word.new("cat") }

  { 
    #       3      2      2      2      2
    4 => ['cat', 'fat', 'hat', 'tat', 'bat'],
    #       3      0      1      2
    1 => ['cat', 'fog', 'pot', 'fat'],
    #       3      0      1      2      2
    2 => ['cat', 'fog', 'pot', 'fat', 'bat']
  }.each do |max, words|
    it "has max_selve_attempts of #{max} for #{words.join(', ')}" do
      subject.max_solve_attempts(words).should == max
    end
  end

  {
    "Cat"  => "cat",
    "CAT"  => "cat",
    " cat" => "cat", # space cat
    "    " => "",
    ""     => ""
  }.each do |word, normal|
    it %|normalizes "#{word}" to "#{normal}"| do
      Word.new(word).should == normal
    end
  end

  ["c t", "123", "ab1"].each do |bad|
    it %|raises on "#{bad}"| do
      lambda { Word.new(bad) }.should raise_error(Word::Invalid)
    end
  end
end
