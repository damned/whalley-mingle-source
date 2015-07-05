class Merger
  def merge(mingle_cards, wall_cards)
    mingle_cards.map {|card|
      {
          text: "##{card['Number']}\n#{card['Name']}"
      }
    }
  end
end