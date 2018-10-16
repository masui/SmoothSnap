#
index.html: template.html android.txt android.html
	ruby include.rb template.html android.html > index.html
android.html: android.txt
	/opt/local/bin/ruby makehtml.rb android.txt dict.txt > android.html
clean:
	/bin/rm -f android.html index.html
