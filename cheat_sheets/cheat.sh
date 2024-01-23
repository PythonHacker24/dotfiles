#!/usr/bin/env bash  

languages=`echo "golang python rust javascript bash lua cpp c typescript nodejs" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk dmenu dwm nvim" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

if [ -z "$query" ]; then
  echo "Query is empty. Exiting."
  exit 1
fi

if printf "$languages" | grep -qs "$selected"; then 
  curl cht.sh/"$selected"/$(echo $query | tr ' ' '+')
else 
  curl cht.sh/"$selected~$query"
fi 
