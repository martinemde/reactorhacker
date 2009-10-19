require 'spec_helper'

describe ReactorHacker::Term do
  def words
    %w[tells lance typed truly tanks trick males taken those]
  end

  before { @term = ReactorHacker::Term.new(words.join("\n")) }
  subject { @term }

  context "(no words)" do
    subject { ReactorHacker::Term.new("") }
    it { should be_empty }
    it { should have(0).possible_matches }
    it { should_not be_solved }
  end

  it { should have(9).possible_matches }
  it { should_not be_solved }
  it "suggests the first pick with the lowest max solve attempts" do
    subject.suggestion.should == "MALES"
  end

  context "(picking MALES has 2 correct)" do
    before { @term = @term.pick("MALES", 2) }

    it { should have(3).possible_matches }
    it { should_not be_solved }
    it "suggests the next best pick" do
      subject.suggestion.should == "TAKEN"
    end

    context "(picking TAKEN has 1 correct)" do
      before { @term = @term.pick("TAKEN", 1) }

      it { should have(1).possible_matches }
      it { should be_solved }
      it "suggests the only answer" do
        subject.suggestion.should == "TELLS"
      end
    end
  end

  context "(after picking MALES and TAKEN)" do
    before { @term = @term.after_picking("MALES" => "2", "TAKEN" => "1") }

    it { should have(2).picks }
    it { should have(1).possible_matches }
    it { should be_solved }
    it "suggests the only answer" do
      subject.suggestion.should == "TELLS"
    end
  end
end
