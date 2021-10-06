#!/bin/bash

# sysinfo_page - A script to produce an html file

title="System Information for $HOSTNAME"
timestamp=$(date +"%x %r %Z")

echo "<html>
      <head>
        <title>
            $title 
        </title>
      </head>
      
      <body>
           <h1>$title</h1>
           <p>generated on $timestamp by $USER<p>
      </body>
</html>"
