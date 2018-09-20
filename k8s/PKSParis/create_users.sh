#/bin/bash

PASSWD="PKSParis"
USER="demo"
MAX=70

I=1
while [ ${I} -le ${MAX} ]
do
	echo ${USER}${I}
	useradd -m -p ${PASSWD} -s /bin/bash ${USER}${I} 
	echo "${USER}${I}:${PASSWD}" | chpasswd
	cp -R /home/demo/App /home/${USER}${I}
	cp -R /home/demo/Utils /home/${USER}${I}
	cp -R /home/demo/.bashrc /home/${USER}${I}
	cp -R /home/demo/.docker /home/${USER}${I}
	chown -R ${USER}${I}:${USER}${I} /home/${USER}${I} /home/${USER}${I}/.???*
	usermod -a -G docker ${USER}${I}
	I=$[$I+1]
done
