#!/bin/bash

#  A script to produce a template html file for tree in Dundee

set -u

title="Trees in Dundee"
timestamp=$(date +"%x %r %Z")

formatted_text=""

add_element() {
	   tree_fact="Some text about this tree goes here"
	   tree_picture="A picture of this tree"
	   copyright="Copyright notice goes here"
	   links="Links to the pdf file about locations of this tree in Dundee"
	   tree_text=$(cat <<- _END_
	   
					<h1>$1</h1>
					
					$tree_fact
					$tree_picture
					$copyright
					$links
		  
					_END_
					);
					formatted_text+=$tree_text
}

# tree_names=$(cat )
# for tree_name in $tree_names
# do
# 	add_element $tree_name
# done

IFS=
while read -r line
do
	add_element $line
done < ../required-trees.txt

cat <<- _EOF_
	<html>
      <head>
        <title>
            $title 
        </title>
      </head>
      
      <body>
           <h1>$title</h1>
		   $formatted_text
           	<p>generated on $timestamp by $USER<p>
      </body>
</html>
_EOF_
