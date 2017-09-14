import urllib
import urllib3
import requests
from bs4 import BeautifulSoup



textToSearch = 'helloworld'
#query = urllib.quote(textToSearch)
url = "https://www.youtube.com/results?search_query=" + textToSearch
r = requests.get(url)
data = r.text 
#response = urllib.urlopen(url)
#html = response.read()
soup = BeautifulSoup(data, "html.parser")
snippet = soup.find_all("h3")

hreflist = []
for h3 in snippet:
	for link in h3.find_all("a"):
		hreflist.append(link['href'])

print (hreflist[0])
		
