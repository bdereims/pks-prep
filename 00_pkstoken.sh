apt install jq -y

curl -LO $(curl -sL https://api.github.com/repos/pivotal/pkstoken/releases/latest | jq -r '.assets[].browser_download_url' | grep Linux_x86_64)

tar -xf pkstoken*
sudo cp pkstoken /usr/local/bin/pkstoken
rm pkstoken*
