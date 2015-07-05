require 'rspec'
require_relative '../lib/merger'

describe Merger do
  let(:stories) { [] }
  let(:mingle) { double('mingle', hostname: 'mingle.tw.com', project: 'myproject') }

  let(:merger) { Merger.new(mingle) }
  subject(:merged) { merger.merge(stories, wall_cards) }

  context 'a mingle card' do
    let(:stories) { [ story ] }
    let(:story) { a_story('Number' => '123') }

    context 'it not on wall' do
      let(:wall_cards) { [] }

      it 'is added' do
        expect(merged.size).to eq 1
        expect(merged.first[:text]).to start_with '#123'
        expect(merged.first[:text]).to end_with story['Name']
      end

      it 'has identifying source and id set' do
        expect(merged.first[:source]).to eq 'mingle'
        expect(merged.first[:id]).to eq 'mingle://mingle.tw.com/myproject#123'
      end

      it 'is placed at top left' do
        expect(merged.first[:left]).to eq 0
        expect(merged.first[:top]).to eq 0
      end

      it 'will be marked with an alert' do
        expect(merged.first[:alert]).to eq 'New card'
      end
    end

    context 'it is already on wall' do
      let(:existing_card) do
        {
          source: 'mingle',
          id: 'mingle://mingle.tw.com/myproject#123',
          text: '#123 The story',
          top: 100,
          left: 50
        }
      end
      let(:wall_cards) { [ existing_card ] }

      it 'is left on wall' do
        expect(merged.size).to eq 1
        expect(merged.first[:id]).to eq existing_card[:id]
      end

      it 'is left at current location' do
        expect(merged.first[:top]).to eq existing_card[:top]
        expect(merged.first[:left]).to eq existing_card[:left]
      end
    end

  end

  def a_story(overrides = {})
    {'Name' => 'a mingle story', 'Number' => '123', 'Status' => 'Next'}.merge overrides
  end
end