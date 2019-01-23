
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

#townhall_url
townhall_url="http://annuaire-des-mairies.com/95/viarmes.html"
def get_townhall_email(townhall_url)
	nom_pret=[]
	lien_pret=[]

	adresse = Nokogiri::HTML(open("#{townhall_url}"))
	a = adresse.css('td')[7].text
	return a

end

val_d_oise_town_urls = "http://annuaire-des-mairies.com/val-d-oise.html"
ville = Nokogiri::HTML(open(val_d_oise_town_urls))
@tab_tout=ville.css('a[class="lientxt"]')

def get_townhall_urls(val_d_oise_town_urls, ville)
#ville = Nokogiri::HTML(open(val_d_oise_town_urls))

u=0
lien_pret=[]

for i in @tab_tout
	#puts i
	result=i.to_s
	result=/[http](.*)[html]/.match(result).to_s.gsub('href=".','http://annuaire-des-mairies.com').gsub('txt" ','')
	lien_pret[u]=result
	#puts result
	u=u+1

end


return lien_pret
end
u=0
nom_pret=[]
for i in @tab_tout
	#puts i
	result=i.to_s
	result=/[>](.*)[<]/.match(result).to_s.gsub('>','').gsub('<','')
	nom_pret[u]=result
	
	u=u+1

end
#puts nom_pret
#ville = Nokogiri::HTML(open(val_d_oise_town_urls))
#nom_pret = ville.css('a[class="lientxt"]').text

lien_pret=get_townhall_urls(val_d_oise_town_urls,ville)
mail_pret=[]
myash=Hash.new
t=0
for i in lien_pret
	
	#print get_townhall_email(i)
	myash.store(nom_pret[t],get_townhall_email(i))
	t=t+1
    
	#if t==10
	# 	break
	# end=end
	
end


def save_as_JSON
	File.open("../../db/email.JSON","w") do |f|
	  f.write(myash.to_json)
	end
end
save_as_JSON
#puts lien_pret
