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
    _to = request.args.get('To')
    _from = request.args.get('From')
    _dest = request.args.get('Dest')
    _dest_encoded = quote(_dest)
    if all(v is not None for v in [_api_key, _to, _from, _dest_encode]):
        _data = json.loads(requests.get('https://enterprise-api.robokiller.com/v1/reputation?from=' + _from + '&to=' + _to + '&api_key=' + _api_key).content)

        if _data and _data["classification"] == 'blacklist':
            return '<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Reject/></Response>'
        return '<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Dial><Number>' + _dest_encoded + '</Number></Dial></Response>'
    return '<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Say>Number is misconfigured or invalid</Say></Response>'


if __name__ == '__main__':
    robokiller.run()
