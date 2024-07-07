## instructions
I have used minikube for the kubernetes cluster. The following steps are to be followed to deploy the application on the cluster.
minikube start

First:kubectl apply -f python-http-server/namespace.yaml

Second: helm install my-http-server ./python-http-server --namespace my-http-server

minikube tunnel

minikube ip

third:
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

## Optional points has been implemented sucessfully
Optional:

Generate documentation for Helm chart (norwoodj/helm-docs)
Test end-to-end Helm chart with Github Action: helm/chart-testing-action
Validate values.yaml with values.schema.json