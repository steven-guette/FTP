#!/bin/bash

is_integer() {
  if [ "$1" -eq "$1" ] 2>/dev/null; then
    echo true
  else
    echo false
  fi
}

trim() {
  echo "$1" | tr -d ' \r'
}

#file_csv=$(curl -k https://raw.githubusercontent.com/steven-guette/FTP/main/Job09/Resources/Userlist.csv)

while IFS="," read -r id firstname name pwd rights || read -r || [ -n "$id" ]; do
  id=$(trim "$id")
  is_valid_id=$(is_integer "$id")

  if [ "$is_valid_id" == false ] || id -u "$id" 2>/dev/null; then
    continue
  fi

  firstname=$(trim "$firstname")
  rights=$(trim "$rights")
  name=$(trim "$name")
  pwd=$(trim "$pwd")

  username="${firstname^}_${name^}"
  user_description="${username/_/ }"
  home_directory="/home/$username"

  if [ "${rights^^}" = "ADMIN" ]; then
    useradd -m -G "sudo" -c "$user_description" -u "$id" -p "$pwd" \
        --shell "/bin/false" --home "$home_directory" "$username"
  else
    useradd -m -c "$user_description" -u "$id" -p "$pwd" \
        --shell "/bin/false" --home "$home_directory" "$username"
  fi
done < $(curl -k "https://raw.githubusercontent.com/steven-guette/FTP/main/Job09/Resources/Userlist.csv")
