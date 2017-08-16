require 'mechanize'
require 'csv'

agent = Mechanize.new{ |agent|
agent.user_agent_alias = 'Mac Safari'
}

page = agent.get('https://wikipedia.org/')
search_form = page.form(action: '//www.wikipedia.org/search-redirect.php')

search_terms = ['Steve Jobs', 'henry ford', 'andrew carnegie', 'benjamin franklin',
  'Thomas Edison', 'ray kroc']

search_terms.each do |term|
  search_form.search = term
  results = agent.submit(search_form, search_form.button('go'))
  html_results = Nokogiri::HTML(results.body)
  name = html_results.at_css('#firstHeading').text
  bday = html_results.at_css('.bday').text
  dday = html_results.at_css('.dday').text
  # puts "#{name} born #{bday}, died #{dday}"
  CSV.open('life_data.csv', 'a+') do |csv|
    csv << [name, bday, dday]
  end
end
