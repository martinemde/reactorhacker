require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'term'

describe Term do
  def words
    %w[tells lance typed truly tanks trick males taken those]
  end

  subject { Term.new(words.join("\n")) }

  it "suggest the first pick with the lowest max solve attempts" do
    subject.suggest.should == "males"
  end

  it "has 9 possible matches" do
    subject.should have(9).possible_matches
  end

  it "is not solved" do
    subject.should_not be_solved
  end

  context "(picking males has 2 correct)" do
    before { subject.pick!("males", 2) }

    it "suggests the next best pick" do
      subject.suggest.should == "taken"
    end

    it "has 3 possible matches" do
      subject.should have(3).possible_matches
    end

    it "is not solved" do
      subject.should_not be_solved
    end

    context "(picking taken has 1 correct)" do
      before { subject.pick!("taken", 1) }

      it "suggests the only answer" do
        subject.suggest.should == "tells"
      end

      it "has 1 possible matches" do
        subject.should have(1).possible_matches
      end

      it "is solved" do
        subject.should be_solved
      end
    end
  end
end
