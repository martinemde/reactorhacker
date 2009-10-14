require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'word_set'
require 'pick'

describe WordSet do
  def words
    %w[tells lance typed truly tanks trick males taken those]
  end

  subject { WordSet.new(words.join("\n")) }

  it "suggest the first pick with the lowest max solve attempts" do
    subject.suggest.should == "males"
  end

  it "returns a narrowed remaining WordSet after picking a word and correct count" do
    subject.remaining_after_pick(Pick.new("males", 2)).should == WordSet.new(%w[tells tanks taken])
  end

  it "raises an error if the picked word is not found" do
    lambda {
      subject.remaining_after_pick(Pick.new("females", 2))
    }.should raise_error(WordSet::WordNotFound)
  end
end
