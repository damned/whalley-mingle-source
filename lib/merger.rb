class Merger
  def initialize(mingle)
    @mingle = mingle
  end

  def merge(mingle_stories, wall_cards)
    merged = wall_cards.clone
    mingle_stories.each {|story|
      unless wall_cards.any? {|card| card_of_story?(card, story) }
        merged << card_from_story(story)
      end
    }
    merged
  end

  private

  def card_of_story?(card, story)
    card[:source] == 'mingle' && card[:id] == card_uri(story)
  end

  def card_from_story(story)
    {
        source: 'mingle',
        id: card_uri(story),
        top: 0,
        left: 0,
        text: card_text(story),
        alert: 'New card'
    }
  end

  def card_text(story)
    "##{story['Number']}\n#{story['Name']}"
  end

  def card_uri(story)
    "mingle://#{hostname}/#{project}##{story['Number']}"
  end

  def hostname
    @mingle.hostname
  end

  def project
    @mingle.project
  end
end