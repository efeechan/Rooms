import json
from flask import Flask, request, jsonify
import pytesseract
from werkzeug.datastructures import FileStorage
from datetime import datetime
import cv2
import numpy as np
from simulation import start_simulation
import room
app = Flask(__name__)
from PIL import Image, ImageFilter
ALLOWED_EXTENSIONS = ['jpg', 'jpeg', 'png', 'bmp']

start_simulation(room.room_data)


# Endpoint to handle image and perform OCR
@app.route('/process_image', methods=['POST'])
def process_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image found'})

    img_file = request.files['image']
    file_ext = img_file.filename.rsplit('.', 1)[1].lower()
    if file_ext not in ALLOWED_EXTENSIONS:
        return jsonify({'Error': 'Invalid file type'})

    img = convert_to_vector(img_file)
    if img is None:
        return jsonify({"Error": "Image could not be loaded."})

    text = perform_ocr(img)
    print(text)    
    text = text.replace(" ", "")
    found_entry = False
    for key in room.room_data.keys():
        if key in text:
            response = room.room_data.get(key)
            response = convert_to_json(response.copy())
            found_entry = True
            return jsonify(response)
    
    if not found_entry:
        return jsonify({"error": "No matching entry found"})

# Function to convert uploaded image to a vector for processing
def convert_to_vector(img_file):
    file_bytes = img_file.read()
    nparr = np.frombuffer(file_bytes, np.uint8)
    return cv2.imdecode(nparr, cv2.IMREAD_COLOR)

# Function to perform OCR on the image
def perform_ocr(img):
    # gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    # thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)[1]
    # kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (3,3))
    # dilated = cv2.dilate(thresh, kernel, iterations=1)
    return pytesseract.image_to_string(image=img).strip().upper()

# Function to convert Person instances to JSON
def convert_to_json(response):
    value = response.get('occupants')
    if value is not None:
        jsonified_data = [json.dumps(element, cls=room.PersonJSONEncoder) for element in value]
        response['occupants'] = jsonified_data
    return response


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
