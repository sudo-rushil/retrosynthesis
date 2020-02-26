
import flask
from flask_cors import CORS
from flask import request, jsonify

from odachi.engine.model import Odachi

app = flask.Flask(__name__)
CORS(app)
app.config["DEBUG"] = True
odachi = Odachi(0.05)


@app.route('/', methods=['GET'])
def home():
    return '''<h1>Odachi Engine API</h1>
<p>Usage: /v1/run?smiles=$(molecule SMILES) </p>'''


@app.route('/v1/run', methods=['GET'])
def run_odachi():
    if 'smiles' in request.args:
        smiles = request.args['smiles']
    else:
        return "Error: no SMILES provided. Please specify a molecular SMILES."

    clusters = 2 if 'clusters' not in request.args else request.args['clusters']

    return jsonify(odachi(smiles, clusters))


@app.route('/v2/run', methods=['GET'])
def run_odachi_versioned():
    if 'smiles' in request.args:
        smiles = request.args['smiles']
    else:
        return "Error: no SMILES provided. Please specify a molecular SMILES."

    clusters = 2 if 'clusters' not in request.args else request.args['clusters']
    version = 9 if 'ver' not in request.args else int(request.args['ver'])

    return jsonify(odachi(smiles, clusters, version))


if __name__ == '__main__':
    app.run()
