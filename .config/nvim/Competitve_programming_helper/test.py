import sys
import http.server
import  json


json_data = None

class CompetitiveCompanionHandler(http.server.BaseHTTPRequestHandler):
    def do_POST(self):
        global json_data
        json_data = json.load(self.rfile)

with http.server.HTTPServer(('127.0.0.1', 10043), CompetitiveCompanionHandler) as server:
    server.timeout = None
    server.handle_request()

if json_data is not None:
    print(json.dumps(json_data, indent=4))
else:
    print("Got no data")
