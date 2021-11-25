
#!/bin/bash

#  A script to produce a HTML content for trees in Dundee

set -u

title="Trees in Dundee"
timestamp=$(date +"%x %r %Z")



# change the code from here

add_element() {
		tree_name=$(echo ${1:13:-4} | sed 's/_/ /')
		tree_fact=$(tail -n -5 "$1")
		tree_picture_html=\<img src="images/${1:13:-4}.jpg" alt="A $(echo {1:13:-4} | sed 's/_/ /' ) tree" width="500" height="600">images/sycamore.jpg
		copyright=$(cat images/${1:13:-4}-copyright.txt)
		link="reports/${1:13:-4}.pdf"
		link_text=${1:13:-4}' trees in Dundee'
		tree_text=$(cat <<- _END_

			<h2>$tree_name</h2>
			<p>$tree_fact</p>
			$tree_picture_html
			<p>$copyright</p>
			<p><a href="$link">$link_text</a></p>

			_END_
			);
		formatted_text+=$tree_text
}


for  file in descriptions/*; do
	add_element "$file"
done


# to here

cat <<- _EOF_
<html>
	<head>
		<title>$title</title>
	</head>

	<body>
		<h1>$title</h1>
		$formatted_text
		<p>Generated on $timestamp by $USER<p>
	</body>
</html>
_EOF_
