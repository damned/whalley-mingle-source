require 'unirest'
require 'highline/import'
require_relative 'lib/mingle'

mingle_instance = ask('mingle hostname? ') {|q| q.default = 'tw-digital.mingle.thoughtworks.com'}
project = ask('project? ') {|q| q.default = 'tw_dot_com'}
user = ask('username? ') {|q| q.default = 'dmoore'}
password = ask('password? ') {|q| q.echo = false }
mingle = Mingle.new(mingle_instance, user => password)


class Whalley
  def get_cards
    whalley_response = Unirest.get "http://localhost:1234/api/0.1/walls"
    cards = whalley_response.body
  end
end
mingle_cards = mingle.get_cards(project)
before_cards = Whalley.new.get_cards

puts "from mingle: #{mingle_cards}"
puts "from whalley: #{before_cards['cards'].map {|c| c['text'].slice(0,20) }}"
