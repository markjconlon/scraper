require 'mechanize'

agent = Mechanize.new{ |agent|
agent.user_agent_alias = 'Mac Safari'
}

page = agent.get('https://wikipedia.org/')
search_form = page.form(action: '//www.wikipedia.org/search-redirect.php')

search_form.search = 'Steve Jobs'

results = agent.submit(search_form, search_form.button('go'))

html_results = Nokogiri::HTML(results.body)
name = html_results.at_css('#firstHeading').text
bday = html_results.at_css('.bday').text
dday = html_results.at_css('.dday').text

puts "#{name} born #{bday}, died #{dday}"
