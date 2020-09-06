#!/bin/bash
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m' 
PUR='\033[0;35m'
GRN="\e[32m"
WHI="\e[37m"
NC='\033[0m'
reverse(){
	yourcode=$(cat code.txt | sort -R | head -1)
	curl=$(curl -s "https://priv8.nako.best/api.php?code=$yourcode&url=$1" --compressed)
	if [[ $curl =~ "Credits abis" ]]; then
		printf "${YELLOW}Credit Abis! Hubungi Admin ${ORANGE}$1\n"
	elif [[ $curl =~ "Gagal grab" ]]; then
		printf "${RED}GAGAL GRAB ${ORANGE}$1\n"
	elif [[ $curl =~ "Capcha" ]]; then
		printf "${RED}Captcha Please Wait..${ORANGE}$1\n"
	elif [[ $curl =~ "Code tidak tersedia" ]]; then
		printf "${RED}Code tidak tersedia! Contact Admin\n"
	else
		printf "${GRN}Berhasil GRAB ${ORANGE}$1\n"
		echo "$curl">>result/result.txt
	fi
}
if [[ ! -d result ]]; then
	mkdir result
fi
cat << "EOF"
                      .".
                     /  |
                    /  /
                   / ,"
       .-------.--- /
      "._ __.-/ o. o\
         "   (    Y  )
              )     /
             /     (
            /       Y
        .-"         |
       /  _     \    \
      /    `. ". ) /' )
     Y       )( / /(,/
    ,|      /     )
   ( |     /     /
    " \_  (__   (__        [HaruPremium V1 - Reverse IP Lookup]
        "-._,)--._,)
EOF
echo ""
echo -n "Masukan File List : "
read list
if [ ! -f $list ]; then
	echo "$list No Such File"
	exit
fi

persend=1
setleep=3

itung=1

x=$(gawk '{ print $1 }' $list)
IFS=$'\r\n' GLOBIGNORE='*' command eval  'url=($x)'
for (( i = 0; i < "${#url[@]}"; i++ )); do
	set_kirik=$(expr $itung % $persend)
	if [[ $set_kirik == 0 && $itung > 0 ]]; then
		sleep $setleep
	fi
	urlna="${url[$i]}"
	reverse $urlna &
	itung=$[$itung+1]
done
wait