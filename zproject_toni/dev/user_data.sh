#!/bin/bash
#sudo yum update -y
# sudo yum install -y httpd
# sudo systemctl start httpd
# sudo systemctl enable httpd
# echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html


#!/bin/bash
yum update -y
yum install -y httpd
iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
systemctl start httpd
systemctl enable httpd
echo "It works!" > /var/www/html/index.html


# antiguo
# Install Python
# yum install -y python3

# # Configure SSH to use the ACM certificate
# cat << EOF > /etc/ssh/sshd_config.d/certificate.conf
# TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem
# HostCertificate /etc/ssh/ssh_host_ecdsa_key-cert.pem
# EOF

# aws acm get-certificate --certificate-arn CERTIFICATE_ARN --output text --query 'Certificate' > /etc/ssh/trusted-user-ca-keys.pem

# # Restart the SSH daemon
# systemctl restart sshd

# # Create a simple web server script
# cat << EOF > /var/www/html/server.py
# import http.server
# import socketserver

# PORT = 80

# Handler = http.server.SimpleHTTPRequestHandler

# with socketserver.TCPServer(("", PORT), Handler) as httpd:
#     print(f"Serving at port {PORT}")
#     httpd.serve_forever()
# EOF

# # Run the web server
# python3 /var/www/html/server.py &