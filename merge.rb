require 'unirest'
require 'highline/import'

mingle_instance = ask('mingle hostname? ') {|q| q.default = 'tw-digital.mingle.thoughtworks.com'}
user = ask('username? ') {|q| q.default = 'dmoore'}
password = ask('password? ') {|q| q.echo = false }

mingle_response = Unirest.get "https://#{mingle_instance}/api/v2/projects/tw_dot_com/cards/execute_mql.json?mql=" + CGI.escape("select name, number, status where 'Modified On' > 'July 1 2015'"), auth:{:user=> user, :password=> password}
cards = mingle_response.body


puts cards
