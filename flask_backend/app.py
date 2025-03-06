from flask import Flask, request, jsonify # type: ignore
from flask_cors import CORS # type: ignore

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get("username")
    password = data.get("password")

    if username == "admin" and password == "1234":  # Replace with actual authentication logic
        return jsonify({"message": "Login successful!"}), 200
    else:
        return jsonify({"message": "Invalid credentials"}), 401

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
