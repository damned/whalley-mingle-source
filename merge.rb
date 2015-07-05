require 'unirest'
require 'highline/import'
require_relative 'lib/mingle'
require_relative 'lib/merger'

mingle_instance = ask('mingle hostname? ') {|q| q.default = 'tw-digital.mingle.thoughtworks.com'}
project = ask('project? ') {|q| q.default = 'tw_dot_com'}
user = ask('username? ') {|q| q.default = 'dmoore'}
password = ask('password? ') {|q| q.echo = false }
mingle = Mingle.new(mingle_instance, project, user => password)
merger = Merger.new(mingle)

class Whalley
  def get_cards
    whalley_response = Unirest.get "http://localhost:1234/api/0.1/walls"
    cards = whalley_response.body['cards'].map do |card|
      string_keys_to_symbols(card)
    end
  end

  private

  def string_keys_to_symbols(hash)
    Hash[hash.map { |(k, v)| [k.to_sym, v] }]
  end
end
stories = mingle.get_stories
before_cards = Whalley.new.get_cards

puts "from mingle: #{stories}"
puts "from whalley: #{before_cards.map {|c| c[:text].slice(0,20) + '...' }}"

merged = merger.merge(stories, before_cards)

puts merged.first
puts merged.size

puts "merged: #{merged.map {|c| c[:text].slice(0,20) + '...' }}"
