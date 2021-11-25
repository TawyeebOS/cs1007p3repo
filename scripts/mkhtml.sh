#!/bin/bash

#  A script to produce a HTML content for trees in Dundee

set -u

title="Trees in Dundee"
timestamp=$(date +"%x %r %Z")



# change the code from here

list_of_files=()

for file in description/*; do
	list_of_files+=file" "
done

len=${#list_of_files[@]}

for tree in $tree_list; do
        specific_trees+=$(echo $tree | sed 's/[A-Z]/ &/g' | sed 's/ //')
done



add_element() {
		tree_name="${specific_trees[$1]}"
		tree_fact=$(tail -n -5 list_of_files[$1])
		tree_picture_html=$(<img src="images/${list_of_files[$1]:12:-4}.jpg" alt="A ${list_of_files[$1]:12:-4} tree" width="500" height="600">)
		copyright=$(cat images/${list_of_files[$1]:12:-4}-copyright.txt)
		link=$(reports/"${specific_trees[$1]}".pdf)
		link_text='"${specific_trees[$1]}" trees in Dundee'
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


for  (( i=0; i<$len; i++ )); do
	add_element i
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
