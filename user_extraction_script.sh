##Please provide the Organisaion ID as an input to the program and it will create two files in the same folder
## all_users.text and groups.txt
## Please check for authorisation issues which might hinder in the output of the program.

read -p 'Please provide the Organisation ID: ' orgid
gcloud beta identity groups search --organization="$orgid" --labels="cloudidentity.googleapis.com/groups.discussion_forum" | grep id\: | sort | uniq | sed 's/^.\{7\}//' > groups.txt
while read line; do 
    echo "$line:" >> all_users.txt
    gcloud beta identity groups memberships list --group-email="$line" | grep id\:| sed 's/^.\{6\}//' | uniq  >> all_users.txt
    echo "\n" >> all_users.txt
    done < groups.txt
cat all_users.txt | sort | uniq > all_users1.txt ; mv all_users1.txt all_users.txt
echo "All the Groups in the ORG are specified in the groups.txt file and all the users of the ORG along with their group IDs are listed in the all_users.txt file under the same Folder"
