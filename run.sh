#!/bin/bash
#codename	: MD5 Mass Decrypt
#author		: ./Lolz
#Thanks to	: JavaGhost - @bashid.org
#no color no problem:)

#masukkan list
read -p "Input your list: " list
if [[ ! -e $list ]]; then
	echo "File or list not found!"
	exit
fi

#memulai decrypt
start=$SECONDS
function decrypt(){
	check=$(curl -s "http://www.nitrxgen.net/md5db/${hash}.json")
	if [[ $check =~ "true" ]]; then
		#statements
		echo "hash: ${hash} => "$(curl -s "http://www.nitrxgen.net/md5db/${hash}.json" | jq -r '.result.pass')
		echo "${hash} : "$(curl -s "http://www.nitrxgen.net/md5db/${hash}.json" | jq -r '.result.pass') >> result.txt
	else
		echo "hash: ${hash} => not found"
	fi
}

(
	for hash in $(cat $list);do
		((thread=thread%100)); ((thread++==0))&& wait
		decrypt "$hash" &
		done
		wait
)

end=$SECONDS
echo -e "The process is complete in time :  $((end-start)) seconds"
echo "valid hash save in file : result.txt"
#mengakhiri proses decrypt
