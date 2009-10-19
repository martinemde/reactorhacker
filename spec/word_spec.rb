require 'spec_helper'

describe ReactorHacker::Word do
  subject { ReactorHacker::Word.new("cat") }

  { 
    #       3      2      2      2      2
    4 => ['cat', 'fat', 'hat', 'tat', 'bat'],
    #       3      0      1      2
    1 => ['cat', 'fog', 'pot', 'fat'],
    #       3      0      1      2      2
    2 => ['cat', 'fog', 'pot', 'fat', 'bat']
  }.each do |max, words|
    it "has max_selve_attempts of #{max} for #{words.join(', ')}" do
      subject.max_solve_attempts(ReactorHacker::WordSet.new(words)).should == max
    end
  end

  {
    "cat"  => "CAT",
    "Cat"  => "CAT",
    "CAT"  => "CAT",
    " cat" => "CAT", # space cat
    "    " => "",
    ""     => ""
  }.each do |word, normal|
    it %|normalizes "#{word}" to "#{normal}"| do
      ReactorHacker::Word.new(word).should == normal
    end
  end

  ["c t", "123", "ab1"].each do |bad|
    it %|raises on "#{bad}"| do
      lambda { ReactorHacker::Word.new(bad) }.should raise_error(ReactorHacker::Word::Invalid)
    end
  end
end
