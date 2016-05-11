#!/bin/sh

for i in "$@"
	do

	FROM_PORT=$(echo $i | awk -F "=" '{print $1}')
	TO_HOST=$(echo $i | awk -F "=" '{print $2}')

		cat <<EOT >> /etc/nginx/nginx.conf
	server {
	        listen $FROM_PORT;
	        server_name localhost;
	        location / {
	            proxy_pass         $TO_HOST;
	            proxy_redirect     off;
	    	}
	}
EOT


done

echo '}' >> /etc/nginx/nginx.conf

cat /etc/nginx/nginx.conf

nginx -g "daemon off;"