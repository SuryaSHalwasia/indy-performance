from flask import Flask
from flask import Response

app = Flask(__name__)


@app.route('/genesis')
def get_genesis():
    with open('/var/lib/indy/sandbox/pool_transactions_genesis', 'r') as manifest:
        genesis = manifest.read(int(1E9))
        return Response(genesis, mimetype='text/plain')


@app.route('/domain')
def get_domain():
    with open('/var/lib/indy/sandbox/domain_transactions_genesis', 'r') as manifest:
        domain = manifest.read(int(1E9))
        return Response(domain, mimetype='text/plain')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000)
