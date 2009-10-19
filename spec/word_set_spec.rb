require 'spec_helper'

describe ReactorHacker::WordSet do
  def words
    %w[tells lance typed truly tanks trick males taken those]
  end

  subject { ReactorHacker::WordSet.new(words.join("\n")) }

  it "suggests the first pick with the lowest max solve attempts" do
    subject.suggestion.should == "MALES"
  end

  it "returns a narrowed remaining WordSet after picking a word and correct count" do
    subject.remaining_after_pick(ReactorHacker::Pick.new("males", 2)).should == ReactorHacker::WordSet.new(%w[tells tanks taken])
  end

  it "raises an error if the picked word is not found" do
    lambda {
      subject.remaining_after_pick(ReactorHacker::Pick.new("females", 2))
    }.should raise_error(ReactorHacker::WordSet::WordNotFound)
  end
end
