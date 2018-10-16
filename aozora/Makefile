#
# 青空文庫をゲット
#
index.html: template.html aozora.txt aozora.html
	ruby include.rb template.html aozora.html > index.html
aozora.html: aozora.txt
	/opt/local/bin/ruby makehtml.rb aozora.txt > aozora.html
aozora.txt: list_person_all_utf8.csv
	ruby aozoraconv.rb list_person_all_utf8.csv > aozora.txt
list_person_all_utf8.csv: list_person_all.csv
	nkf -w list_person_all.csv > list_person_all_utf8.csv
list_person_all.csv: list_person_all.zip
	unzip list_person_all.zip
list_person_all.zip:
	wget http://www.aozora.gr.jp/index_pages/list_person_all.zip

get: list_person_all.zip

clean:
	/bin/rm -f *~ aozora.html aozora.txt list_person_all_utf8.csv \
		list_person_all.csv index.html 
