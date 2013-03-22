require 'spec_helper'

describe ReactorHacker::Pick do
  subject { ReactorHacker::Pick.new("cat", "2") }

  def match(*a)
    be_match(*a)
  end

  it "has the correct word" do
    subject.word.should == ReactorHacker::Word.new("cat")
  end

  it "converts string correct into integer" do
    subject.correct.should == 2
  end

  it "matches another word with the correct number of matching letters" do
    subject.should match('hat')
    subject.should match('bat')
  end

  it "does not match a word with different correct count" do
    subject.should_not match('cat')
    subject.should_not match('dog')
  end
end
