from flask import Flask, request, jsonify
from transformers import pipeline

app = Flask(__name__)
summarizer = pipeline("summarization", model="facebook/bart-large-cnn")
grammar_corrector = pipeline("text2text-generation", model="vennify/t5-base-grammar-correction")

@app.route('/summarize', methods=['POST'])
def summarize_text():
    data = request.get_json()
    if 'article' not in data:
        return jsonify({'error': 'Missing "article" in request data'}), 400

    try:
        article = data['article']
        summary = summarizer(article, max_length=130, min_length=30, do_sample=False)
        return jsonify({'summary': summary[0]['summary_text']})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/correct-grammar', methods=['POST'])
def correct_grammar():
    data = request.get_json()
    if 'text' not in data:
        return jsonify({'error': 'Missing "text" in request data'}), 400

    try:
        text_to_correct = data['text']
        corrected_text = grammar_corrector(text_to_correct, max_length=500, min_length=10)[0]['generated_text']
        return jsonify({'corrected_text': corrected_text})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=8080) 
