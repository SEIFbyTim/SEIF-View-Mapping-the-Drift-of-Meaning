
from flask import Flask, request, jsonify
import random
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for local development

def symbolic_drift_score(text):
    # Placeholder symbolic metrics
    drift = round(random.uniform(0.3, 0.9), 2)
    clarity = round(random.uniform(0.6, 1.0), 2)
    coherence = round(random.uniform(0.5, 0.95), 2)
    omega = round((clarity + coherence) / 2 * 100, 1)
    return drift, clarity, coherence, omega

@app.route("/analyze", methods=["POST"])
def analyze():
    data = request.get_json()
    text = data.get("text", "")
    if not text:
        return jsonify({"error": "Missing 'text' in request"}), 400

    drift, clarity, coherence, omega = symbolic_drift_score(text)
    return jsonify({
        "drift": drift,
        "clarity": clarity,
        "coherence": coherence,
        "omega": omega
    })

if __name__ == "__main__":
    app.run(debug=True)
