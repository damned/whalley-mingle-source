require 'rspec'
require_relative '../lib/merger'

describe Merger do
  let(:wall_cards) { [] }
  let(:mingle_cards) { [] }

  let(:merger) { Merger.new }
  subject(:cards) { Merger.new.merge(mingle_cards, wall_cards) }

  context 'a mingle card' do
    let(:mingle_cards) { [a_story] }

    it 'is added' do
      expect(cards.size).to eq 1
      expect(cards.first[:text]).to start_with '#' + a_story['Number']
      expect(cards.first[:text]).to end_with a_story['Name']
    end
  end

  def a_story
    {'Name' => 'a mingle story', 'Number' => '123', 'Status' => 'Next'}
  end
end