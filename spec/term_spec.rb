require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'term'

describe Term do
  def words
    %w[tells lance typed truly tanks trick males taken those]
  end

  before { @term = Term.new(words.join("\n")) }
  subject { @term }

  context "(no words)" do
    subject { Term.new("") }
    it { should be_empty }
    it { should have(0).possible_matches }
    it { should_not be_solved }
  end

  it { should have(9).possible_matches }
  it { should_not be_solved }
  it "suggest the first pick with the lowest max solve attempts" do
    subject.suggest.should == "males"
  end

  context "(picking males has 2 correct)" do
    before { @term = @term.pick("males", 2) }

    it { should have(3).possible_matches }
    it { should_not be_solved }
    it "suggests the next best pick" do
      subject.suggest.should == "taken"
    end

    context "(picking taken has 1 correct)" do
      before { @term = @term.pick("taken", 1) }

      it { should have(1).possible_matches }
      it { should be_solved }
      it "suggests the only answer" do
        subject.suggest.should == "tells"
      end
    end
  end

  context "(after picking males and taken)" do
    before { @term = @term.after_picking("males" => "2", "taken" => "1") }

    it { should have(1).possible_matches }
    it { should be_solved }
    it "suggests the only answer" do
      subject.suggest.should == "tells"
    end
  end
end
