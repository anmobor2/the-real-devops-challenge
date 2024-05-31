import http.server
import argparse
from datetime import datetime

class MyHTTPRequestHandler(http.server.BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        timestamp = datetime.now().strftime("%d/%b/%Y %H:%M:%S")
        client_ip = self.client_address[0]

        log_message = f"{client_ip} - - [{timestamp}] {format % args}"
        print(log_message)
        print(log_message)

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()

        if self.path == "/":
            self.wfile.write(b"Hello, World!")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Simple HTTP server with logging")
    parser.add_argument("--host", type=str, default="0.0.0.0")
    parser.add_argument("--port", type=int, default=8000)

    args = parser.parse_args()

    server_address = (args.host, args.port)
    httpd = http.server.HTTPServer(server_address, MyHTTPRequestHandler)
    server_name = "[my-web-server]"
    print(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} {server_name} - [INFO]: Webserver listening: http://{args.host}:{args.port}")
    httpd.serve_forever()