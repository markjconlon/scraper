require 'nokogiri'

file = File.open('stevejobs.html')
html = Nokogiri::HTML(file)

output = File.new('stevejobs_story.txt', 'w+')

name = html.at_css('#firstHeading').text
bday = html.at_css('.bday').text
dday = html.at_css('.dday').text
cause_of_death = html.at_xpath('//a[@title="Pancreatic cancer"]').text

# puts name,bday,dday,cause_of_death

output.write(name + ' was born on ' + bday + "\n")
output.write( 'He died on ' + dday + 'do to ' + cause_of_death)
