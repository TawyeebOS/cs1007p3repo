#!/bin/bash

#  A script to produce a HTML content for trees in Dundee

set -u

title="Trees in Dundee"
timestamp=$(date +"%x %r %Z")

formatted_text=""

# change the code from here
add_element() {
		tree_name="Some tree"
		tree_fact="Some text about this tree goes here"
		tree_picture_html="A picture of this tree"
		copyright="Copyright notice goes here"
		link="Link to the pdf file about locations of this tree in Dundee"
		link_text="Text for the PDF link"
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

add_element
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
