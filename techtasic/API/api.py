from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/register', methods=['POST'])
def register():
    data = request.form
    return jsonify({"message": f"User {data.get('name')} registered successfully!"})

@app.route('/login', methods=['POST'])
def login():
    data = request.form
    return jsonify({"message": f"Welcome back {data.get('email')}!"})

if __name__ == '__main__':
    app.run(debug=True)
