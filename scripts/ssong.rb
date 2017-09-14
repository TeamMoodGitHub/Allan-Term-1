require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
:adapter => "mysql2",
:host => "localhost",
:username => "root",
:password => "guest",
:database =>  "FindThatAnime_development"
)

class Anime < ActiveRecord::Base
end

class Song < ActiveRecord::Base
end


Anime.all.each do |anime|
	opening = anime.openingtheme.split(/#\d+:\s|\sby\s/).reject(&:empty?)
	ending = anime.endingtheme.split(/#\d+:\s|\sby\s/).reject(&:empty?)
	id = anime.id
	print "\n"
	print "SHOW: " + anime.title + "\n"
	
	optitle = ""
	opauthor = ""
	count = 1
	opening.each do |song|
		attribute = song.gsub('"', '')
		print attribute + "\n"
		if count.even?
			opauthor = attribute
		else
			optitle = attribute
		end
		if count % 2 == 0
		Song.create(:title => optitle, :author => opauthor, :anime_id => id)
		print "CREATE: TITLE:" + optitle + " AUTHOR:" + opauthor + "\n"
		end
		count = count + 1
	end

	count = 1
	edtitle = ""
	edauthor = ""
	ending.each do |song|
		attribute = song.gsub('"', '')
		print attribute + "\n"
		if count.even?
			edauthor = attribute
		else
			edtitle = attribute
		end
		if count % 2 == 0
		Song.create(:title => edtitle, :author => edauthor, :anime_id => id)
		print "CREATE: TITLE:" + edtitle + " AUTHOR:" + edauthor + "\n" 
		end
		count = count + 1
	end
end


