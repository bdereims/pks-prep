#/bin/bash

PASSWD="PKS1!"
USER="demo"
MAX=70

I=1
while [ ${I} -le ${MAX} ]
do
	echo ${USER}${I}
	deluser --remove-home --quiet ${USER}${I} 
	#gpasswd -d ${USER}${I} docker
	I=$[$I+1]
done
