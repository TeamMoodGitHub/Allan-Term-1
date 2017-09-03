require 'rubygems'
require 'active_record'
require 'open-uri'
require 'nokogiri'
require 'uri'
require 'addressable/uri'

ActiveRecord::Base.establish_connection(
:adapter => "mysql2",
:host => "localhost",
:username => "root",
:password => "guest",
:database =>  "FindThatAnime_development"
)

class Anime < ActiveRecord::Base
end

print "seed" + "\n"

site = URI.encode("https://myanimelist.net/topanime.php")
def seed(site)
	doc = Nokogiri::HTML(open(site).read, nil, 'utf-8')
	for showcount in 0..49
		href = doc.css("a[class='hoverinfo_trigger fl-l ml12 mr8']")[showcount]['href']
		encoded_href = URI.encode(href)
		show = Nokogiri::HTML(open(encoded_href).read, nil, 'utf-8')

		title = show.css("span[itemprop='name']")[0].text.strip
		type = show.css("div[class='js-scrollfix-bottom']").css("div").css("a")[9].text.strip
		synopsis = show.css("span[itemprop='description']").text.strip
		if synopsis == nil
			synopsis = "None"
		end
		episodes = show.css('span#curEps')[0].text.strip
		#SELECTS from spaceit class and returns text. then strips the first 10 characters
		aired = show.css("div[class='spaceit']")[1].text
		aired = aired[9..aired.size-1].strip

		opening = show.css("div[class='theme-songs js-theme-songs opnening']").text.strip
		if opening == "No opening themes have been added to this title. Help improve our database by adding an opening theme here."
			opening = "None"
		end

		ending = show.css("div[class='theme-songs js-theme-songs ending']").text.strip
		if ending == "No ending themes have been added to this title. Help improve our database by adding an ending theme here."
			ending = "None"
		end

		mal = show.css("div[class='di-ib']")
		mal = mal.css("a")[2]['href']
		

		test(title, type, synopsis, episodes, aired, opening, ending, mal)
		Anime.create(:title => title, :animetype => type, :synopsis => synopsis, :aired => aired, :openingtheme => opening, :endingtheme => ending, :mal => mal)

		sleep 1
	end
		seed(doc.css("link[rel='next']")[0]['href'])
end

def test(title, type, synopsis, episodes, aired, opening, ending, mal)
	print title + "\n"
	print type + "\n"
	print synopsis + "\n"
	print episodes + "\n"
	print aired + "\n"
	print opening + "\n"
	print ending + "\n"
	print mal + "\n"
	print "\n"
end


seed(site)