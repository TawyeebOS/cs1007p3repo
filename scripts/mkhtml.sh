#!/bin/bash

#  A script to produce a template html file for tree in Dundee

title="Trees in Dundee"
timestamp=$(date +"%x %r %Z")

formatted_text=""

add_element() {
   new_text=$(cat <<- _END_
   
	      		<p>
	        		$1
	      		</p>
		  
_END_
);
formatted_text+=$new_text
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
