require 'spec_helper'

describe NumberToWordHelper do

  describe "#number_to_word" do
    {
      'one'   => 1,
      'two'   => 2,
      'three' => 3,
      'four'  => 4,
      'five'  => 5,
    }.each do |word, integer|
      it "returns #{word} when given #{integer}" do
        helper.number_to_word(integer).should eq(word)
      end
    end
  end
end
