#!/bin/sh
# Script to help create new entries at
# https://www.uni-muenster.de/Physik.FSPHYS/intern/physiker/fs_protokolle

# print usage if not enough arguments
if [ $# -lt 2 ]; then
	echo "Usage: $0 #1 #2 [#3]
	#1: date (e.g. 2017-06-01)
	#2: name (e.g. simon_may, 'Simon May' or simon)
	#3: surname, if it wasn’t included in #2 (e.g. may or May)"
	exit
fi

# get input arguments
in_date=$1
in_name=$(echo "$2" | tr '[:upper:]' '[:lower:]')
in_surname=$(echo "$3" | tr '[:upper:]' '[:lower:]')

if [ -z "$in_surname" ]; then
	url_name=$(echo $in_name | sed -r 's/\s+/_/g')
	forename=$(echo $url_name | sed -r 's/(.+)_.*/\1/')
else
	url_name="$in_name"_"$in_surname"
	forename=$in_name
fi
# replace umlauts/ß in url_name
url_name=$(echo $url_name | sed '
	s/ä/ae/g
	s/ö/oe/g
	s/ü/ue/g
	s/ß/ss/g
')
	
# capitalize forename
forename=$(echo $forename | sed 's/^./\U&/')

echo de_DE
echo '<li><time datetime="'$in_date'">'$in_date'</time> – Protokollant: '\
'<a href="/Physik.FSPHYS/fachschaft/mitglieder/'$url_name'" class="int">'\
$forename'</a><br />
  <a class="download" href="/imperia/md/content/physik_fsphys/intern/physiker'\
'/fs-protokolle/'$in_date'_protokoll.pdf">Protokoll der Sitzung des '\
'Fachschaftsrats von Mittwoch, <time datetime="'$in_date'">'$in_date\
'</time></a> (<a href="/imperia/md/content/physik_fsphys/intern/physiker/'\
'fs-protokolle/'$in_date'_protokoll.tex" class="download">T'\
'<span style="vertical-align: sub;">E</span>X</a>)</li>'
echo
echo en_US
echo '<li><time datetime="'$in_date'">'$in_date'</time> – Recorder: '\
'<a href="/Physik.FSPHYS/en/fachschaft/mitglieder/'$url_name'" class="int">'\
$forename'</a><br />
  <a class="download" hreflang="de" href="/imperia/md/content/physik_fsphys/'\
'intern/physiker/fs-protokolle/'$in_date'_protokoll.pdf">Minutes of the '\
'student council meeting on Wednesday, <time datetime="'$in_date'">'$in_date\
'</time></a> (<a class="download" hreflang="de" href="/imperia/md/content/'\
'physik_fsphys/intern/physiker/fs-protokolle/'$in_date'_protokoll.tex">T'\
'<span style="vertical-align: sub;">E</span>X</a>)</li>'
