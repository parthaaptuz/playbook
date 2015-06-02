mkdir /home/ubuntu/myserver &&
sudo apt-get -y update &&
sudo apt-get -y install debconf-utils &&
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password wppass123' &&
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password wppass123' &&
sudo apt-get -y install lamp-server^ &&
sudo sed -i 's/\/var\/www\//'"\/home\/ubuntu\/myserver\/"'/g' /etc/apache2/apache2.conf &&
sudo sed -i 's/\/var\/www\/html/'"\/home\/ubuntu\/myserver\/"'/g' /etc/apache2/sites-available/000-default.conf &&
mysql -u root '-pwppass123' -e 'create database wordpress;create user wpuser@localhost;set password for wpuser@localhost= password("wppass123");grant all privileges on wordpress.* to wpuser@localhost identified by "wppass123";flush privileges;' &&
sudo service apache2 restart &&
wget http://wordpress.org/latest.tar.gz &&
tar -xzvf latest.tar.gz &&
cp /home/ubuntu/wordpress/wp-config-sample.php /home/ubuntu/wordpress/wp-config.php &&
sed -i 's/database_name_here/'"wordpress"'/g' /home/ubuntu/wordpress/wp-config.php &&
sed -i 's/username_here/'"wpuser"'/g' /home/ubuntu/wordpress/wp-config.php &&
sed -i 's/password_here/'"wppass123"'/g' /home/ubuntu/wordpress/wp-config.php &&
mv /home/ubuntu/wordpress/* /home/ubuntu/myserver/ &&
echo "Wordpress installed successfully. Please verify your domain"