#!/bin/bash


# Downloads CSV file to directory
cat dundee-trees.url | xargs wget -O ./trees_public.csv 2> site/index.html
# Reads firsts line of each file in descriptions:

trees_list=()

for file in descriptions/*; do
	tree_list+=$(awk 'NR==1{print $2 $3}' $file)" " 
done

# Finds all records of CSV file that contains the specific trees and puts them in pdf files
for tree in $tree_list; do
	specific_tree=$(echo $tree | sed 's/[A-Z]/ &/g' | sed 's/ //')
	echo -e "$specific_tree\n\n" > reports/"$specific_tree".txt
	grep -i "$specific_tree" ./trees_public.csv | awk 'BEGIN { FS = "," } { OFS = "\n" } {print "Height: "$4, "Girth: "$5, "Age: " $6, "Latitude: "$13, "Longitude: "$14"\n"}' >> reports/"$specific_tree".txt
	enscript -B -p reports/"$specific_tree".ps reports/"$specific_tree".txt &>> site/index.html
	ps2pdf reports/"$specific_tree".ps reports/"$specific_tree".pdf &>> site/index.html
	rm reports/"$specific_tree".txt reports/"$specific_tree".ps

done


./mkhtml.sh
