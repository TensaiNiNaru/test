server {

	listen   80; ## listen for ipv4

	server_name  wiki.tensaininaru.com;

	location / {
		# Allow receiving bigger files
                client_max_body_size 1000M;
		proxy_pass http://localhost:8090;
      		proxy_set_header X-Real-IP $remote_addr;
	}
}

