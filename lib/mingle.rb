require 'unirest'
class Mingle
  attr_reader :hostname, :project

  def initialize(mingle_hostname, project, auth)
    @hostname = mingle_hostname
    @project = project
    @authentication = {
        :user => auth.first[0],
        :password => auth.first[1]
    }
  end

  def get_stories
    selector = "select name, number, status where 'Modified On' > 'July 1 2015'"
    mingle_response = Unirest.get "https://#{@hostname}/api/v2/projects/#{project}/cards/execute_mql.json?mql=" + CGI.escape(selector), auth: authentication
    cards = mingle_response.body
  end

  private

  attr_reader :authentication
end
