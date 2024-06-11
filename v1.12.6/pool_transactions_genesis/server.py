from flask import Flask, Response

app = Flask(__name__)

@app.route('/genesis')
def get_genesis():
    file_path = '/home/ubuntu/indy-node/v1.12.6/pool_transactions_genesis/pool_transactions_genesis'
    
    # Set chunk size for reading the file
    CHUNK_SIZE = 1024
    
    def generate():
        with open(file_path, 'r') as f:
            while True:
                chunk = f.read(CHUNK_SIZE)
                if not chunk:
                    break
                yield chunk
    
    return Response(generate(), mimetype='text/plain')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

