from urllib.parse import quote
import os
import json
import requests
from flask import Flask
from flask import request
robokiller = Flask(__name__)

@robokiller.route('/')
def go_robokiller():
    _api_key = os.environ.get('RK_API_KEY', None)
    _to = quote(request.args.get('To'))
    _from = quote(request.args.get('From'))
    _dest = quote(request.args.get('Dest'))
    if all(v is not None for v in [_api_key, _to, _from, _dest]):
        _data = json.loads(requests.get('https://enterprise-api.robokiller.com/v1/reputation?from=' + _from + '&to=' + _to + '&api_key=' + _api_key).content)

        if _data and _data["classification"] == 'blacklist':
            return '<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Reject/></Response>'
        return '<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Dial><Number>' + _dest + '</Number></Dial></Response>'
    return '<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Say>Number is misconfigured or invalid</Say></Response>'


if __name__ == '__main__':
    robokiller.run()
