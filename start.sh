echo ' ################################################################################'
echo ' ################################################################################'
echo 'Enter your instance public IP'
read ip
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install nodejs -y
sudo npm install babel-cli -g
# source ~/.bashrc
#pm2 install
sudo npm install pm2 -g -y
git clone https://github.com/babadee001/DevOps-AWS-Intro
sudo apt-get install nginx
sudo rm /etc/nginx/sites-enabled/default
sudo bash -c 'cat > /etc/nginx/sites-available/HelloBooks <<EOF
 server {
  listen 80;
  server_name HelloBooks;
  location / {
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  Host       $http_host;
    proxy_pass        http://echo $ip:8000;
  }
}
EOF'
sudo ln -s /etc/nginx/sites-available/HelloBooks /etc/nginx/sites-enabled/HelloBooks
sudo /etc/init.d/nginx start
sudo /etc/init.d/nginx restart
cd DevOps-AWS-Intro
sudo npm install --unsafe-perm
pm2 startOrRestart ecosystem.config.js