# You may add here your
# server {
#	...
# }
# statements for each of your virtual hosts

server {

	listen   80; ## listen for ipv4
	client_max_body_size 20M;

	server_name  www.tensaininaru.com;

	access_log  /srv/www/www.tensaininaru.com/logs/access.log;
	error_log   /srv/www/www.tensaininaru.com/logs/error.log;
	root	    /srv/www/www.tensaininaru.com/public_html;

	location / {
		index  index.php;
	}

	# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
	#
	location ~ \.php$ {
		fastcgi_pass   127.0.0.1:9000;
		fastcgi_index  index.php;
		fastcgi_param  SCRIPT_FILENAME  /srv/www/www.tensaininaru.com/public_html$fastcgi_script_name;
		include        /etc/nginx/fastcgi_params;
	}

	# deny access to .htaccess files, if Apache's document root
	# concurs with nginx's one
	#
	location ~ /\.ht {
		deny  all;
	}
}

