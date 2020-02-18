sudo yum install wget unzip vim -y
#install nginx
cd /tmp
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum --enablerepo=epel install nginx -y
wget https://github.com/BlackrockDigital/startbootstrap-grayscale/archive/gh-pages.zip
unzip gh-pages.zip
cp -r gh-pages/* /usr/share/nginx/html/
systemctl start nginx