server {

	listen   80; ## listen for ipv4

	server_name  jira.tensaininaru.com;

	location / {
		proxy_pass http://localhost:8080;

		# Allow receiving bigger files
                client_max_body_size 500M;

                # Fixes jira base url proxy shitfest
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;

	}
}

