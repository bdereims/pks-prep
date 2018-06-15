while [ true ] ; do curl -X POST http://${OPENFAAS_URL}/function/figlet -d '-=< BRICE >=-' ; done
