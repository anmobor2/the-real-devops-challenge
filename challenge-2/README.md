## instructions
I have used minikube for the kubernetes cluster. The following steps are to be followed to deploy the application on the cluster.
minikube start
minikube addons enable ingress

kubectl apply -f python-http-server/namespace.yaml

helm install my-http-server ./python-http-server --namespace my-http-server

minikube tunnel

minikube ip

curl --resolve "python-http-server.<minikube-ip>.nip.io:80:127.0.0.1" -i http://python-http-server.<minikube-ip>.nip.io

my case the minikube ip is
curl --resolve "python-http-server.192.168.49.2.nip.io:80:127.0.0.1" -i http://python-http-server.192.168.49.2.nip.io

output:
HTTP/1.1 200 OK
Date: Mon, 03 Jun 2024 20:37:17 GMT
Content-Type: text/plain
Transfer-Encoding: chunked
Connection: keep-alive

Hello, World!%

