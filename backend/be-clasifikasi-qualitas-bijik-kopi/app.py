import ast
import csv
import os
import SVMM
import cv2
import lbp
from flask import Flask, redirect, render_template, request, send_file, jsonify
import numpy as np
from resizes import resizes

PEOPLE_FOLDER = os.path.join('static', 'TES')

app = Flask(__name__, template_folder='mypackage')
app.config['UPLOAD_FOLDER'] = PEOPLE_FOLDER


def crop(f, name):
    if name == "latih":
        # reading image
        image = cv2.imread("./static/DataLatih/"+f.filename)
    else:
        image = cv2.imread("./static/TES/"+f.filename)

        # convert to gray
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # blur
    blur = cv2.GaussianBlur(gray, (0, 0), sigmaX=230, sigmaY=230)

    # divide
    divide = cv2.divide(gray, blur, scale=255)

    # threshold
    thresh = cv2.threshold(divide, 180, 255, cv2.THRESH_BINARY)[1]

    # morphology edgeout = dilated_mask - mask
    # morphology dilate
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (8, 8))
    dilate = cv2.morphologyEx(thresh, cv2.MORPH_DILATE, kernel)

    # get absolute difference between dilate and thresh
    diff = cv2.absdiff(dilate, thresh)

    # invert
    edges = 255 - diff
    cv2.medianBlur(edges, 5)

    # # finding contours
    # (_, cnts, _) = cv2.findContours(edges,
    #                                 cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts, hierarchy = cv2.findContours(
        edges.copy(), cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    idx = 0
    for c in cnts:
        x, y, w, h = cv2.boundingRect(c)
        if w > 150 and h > 150:
            idx += 1
            new_img = image[y:y+h, x:x+w]
            # cropping images
            cv2.imwrite("./static/CROPING/"+f.filename, new_img)
            print('>> Objects Cropped Successfully!')


@app.route('/', methods=['GET'])
def main():
    return render_template('home.html')


@app.route('/ss', methods=['GET'])
def tess():
    return jsonify(
        {
            'urlGry': 2**2,
            'urlLbp': 2**2,
            'nilaiLbp': 2**2,
            'nilaiHSV': 2**2,
            'clasifikasi': 2**2,
        }
    )


@app.route('/pengujian')
def pengujian():
    return render_template('index.html')


@app.route('/tambah')
def tambah():
    return render_template('tambah_latih.html')


@app.route('/downloadDataLatih')
def downloadDataLatih():
    return send_file('./csv/latih.csv', as_attachment=True)


@app.route('/downloadDatauji', methods=['POST'])
def downloadDatauji():
    return send_file('./csv/hasil-uji.csv', as_attachment=True)


@app.route('/tambahData', methods=['POST'])
def tambahData():
    if request.method == 'POST':
        f = request.files['file']
        pathGambar = "./static/DataLatih/"+f.filename
        f.save(pathGambar)

    img = resizes(f.filename, 'DataLatih')
    img.resize()

    crop(f, "latih")

    img_bgr = cv2.imread("./static/CROPING/"+f.filename, 1)
    img_bgr = cv2.medianBlur(img_bgr, 5)
    cv2.imwrite("./static/FILTER/"+f.filename, img_bgr)

    height, width, _ = img_bgr.shape
    img_gray = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2GRAY)
    img_lbp = np.zeros((height, width), np.uint8)
    for i in range(0, height):
        for j in range(0, width):
            img_lbp[i, j] = lbp.lbp_calculated_pixel(img_gray, i, j)

    warnaImage = cv2.imread("./static/FILTER/"+f.filename, 1)

    fitur = {
        "lbp_mean": np.round(np.mean(img_lbp), 2),
        "lbp_stdev": np.round(np.std(img_lbp), 2),
        "rgb_mean": np.round(np.mean(warnaImage), 2),
        "rgb_stdev": np.round(np.std(warnaImage), 2),
        "kelas": request.form['mutu']
    }

    csv_column = ["lbp_mean", "lbp_stdev", "rgb_mean", "rgb_stdev", "kelas"]

    with open('csv/latih.csv', 'a', newline='', encoding='utf-8') as f_object:

        dictwriter_object = csv.DictWriter(f_object, fieldnames=csv_column)
        dictwriter_object.writerow(fitur)
        f_object.close()

    return redirect('/dataLatih')


@app.route('/dataLatih')
def dataLatih():
    try:
        latih = csv.reader(open('csv/latih.csv', 'r'))
        csvs = [row for row in latih]
        return render_template('dataLatih.html', rows=csvs, len=len(csvs))
    except:
        return render_template('dataLatih.html', rows=[0], len=0)


@app.route('/simpan', methods=['POST'])
def simpan():

    csv_column = ["lbp_mean", "lbp_stdev", "rgb_mean", "rgb_stdev", "kelas"]

    dicto = ast.literal_eval(request.form['prediction'])

    with open('csv/hasil-uji.csv', 'a', newline='', encoding='utf-8') as f_object:

        dictwriter_object = csv.DictWriter(f_object, fieldnames=csv_column)
        dictwriter_object.writerow(dicto)
        f_object.close()

    return redirect('/dataLatih')


@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        f = request.files['file']
        pathGambar = "./static/TES/"+f.filename
        f.save(pathGambar)

    img = resizes(f.filename, 'TES')
    img.resize()

    crop(f, "TES")

    img_bgr = cv2.imread("./static/CROPING/"+f.filename, 1)
    img_bgr = cv2.medianBlur(img_bgr, 5)
    cv2.imwrite("./static/FILTER/"+f.filename, img_bgr)
    height, width, _ = img_bgr.shape

    img_gray = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2GRAY)
    img_lbp = np.zeros((height, width), np.uint8)

    for i in range(0, height):
        for j in range(0, width):
            img_lbp[i, j] = lbp.lbp_calculated_pixel(img_gray, i, j)

    img = cv2.cvtColor(cv2.imread("./static/FILTER/" +
                       f.filename, 1), cv2.COLOR_BGR2GRAY)
    cv2.imwrite("./static/GRY/"+f.filename, img)

    image_fitur = []
    warnaImage = cv2.imread("./static/FILTER/"+f.filename, 1)

    fitur = {
        "lbp_mean":  np.round(np.mean(img_lbp), 2),
        "lbp_stdev": np.round(np.std(img_lbp), 2),
        "rgb_mean": np.round(np.mean(warnaImage), 2),
        "rgb_stdev": np.round(np.std(warnaImage), 2),
    }
    image_fitur.append(fitur)

    cv2.imwrite("./static/HSV/"+f.filename, warnaImage)
    cv2.imwrite("./static/LBP/"+f.filename, img_lbp)

    image_warna = []
    warna = {
        "rgb_mean": np.round(np.mean(warnaImage), 2),
        "rgb_stdev": np.round(np.std(warnaImage), 2),
    }
    image_warna.append(warna)

    csv_column = ["lbp_mean", "lbp_stdev", "rgb_mean", "rgb_stdev"]

    csv_file = "csv/uji1.csv"
    try:
        with open(csv_file, 'w', newline='', encoding='utf-8') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=csv_column)
            writer.writeheader()
            for data in image_fitur:
                writer.writerow(data)
    except IOError:
        print("I/O")
    svm = SVMM.SVMM().train()

    csv_column.append("kelas")
    fitur.update({"kelas": svm[0]})

    try:
        with open('csv/hasil-uji.csv', 'a', newline='', encoding='utf-8') as f_object:
            dictwriter_object = csv.DictWriter(f_object, fieldnames=csv_column)
            dictwriter_object.writerow(fitur)
            f_object.close()
    except IOError:
        print("I/O")

    image_fitur[0].pop('rgb_mean')
    image_fitur[0].pop('rgb_stdev')

    return render_template('hasil.html', hasil=svm, gambarLBP="./static/LBP/"+f.filename, gambarHsv="./static/GRY/"+f.filename, nilaihvs=image_warna, prediction=image_fitur, gambarAsli="./static/TES/"+f.filename)


@app.route('/api/predict', methods=['POST'])
def apiPredict():
    if request.method == 'POST':
        f = request.files['gambar']
        pathGambar = "./static/TES/"+f.filename
        f.save(pathGambar)

    img = resizes(f.filename, 'TES')
    img.resize()

    crop(f, "TES")

    img_bgr = cv2.imread("./static/CROPING/"+f.filename, 1)
    img_bgr = cv2.medianBlur(img_bgr, 5)
    cv2.imwrite("./static/FILTER/"+f.filename, img_bgr)
    height, width, _ = img_bgr.shape

    img_gray = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2GRAY)
    img_lbp = np.zeros((height, width), np.uint8)

    for i in range(0, height):
        for j in range(0, width):
            img_lbp[i, j] = lbp.lbp_calculated_pixel(img_gray, i, j)

    img = cv2.cvtColor(cv2.imread("./static/FILTER/" +
                       f.filename, 1), cv2.COLOR_BGR2GRAY)
    cv2.imwrite("./static/GRY/"+f.filename, img)

    image_fitur = []
    warnaImage = cv2.imread("./static/FILTER/"+f.filename, 1)

    fitur = {
        "lbp_mean":  np.round(np.mean(img_lbp), 2),
        "lbp_stdev": np.round(np.std(img_lbp), 2),
        "rgb_mean": np.round(np.mean(warnaImage), 2),
        "rgb_stdev": np.round(np.std(warnaImage), 2),
    }
    image_fitur.append(fitur)

    cv2.imwrite("./static/HSV/"+f.filename, warnaImage)
    cv2.imwrite("./static/LBP/"+f.filename, img_lbp)

    image_warna = []
    warna = {
        "rgb_mean": np.round(np.mean(warnaImage), 2),
        "rgb_stdev": np.round(np.std(warnaImage), 2),
    }
    image_warna.append(warna)

    csv_column = ["lbp_mean", "lbp_stdev", "rgb_mean", "rgb_stdev"]

    csv_file = "csv/uji1.csv"
    try:
        with open(csv_file, 'w', newline='', encoding='utf-8') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=csv_column)
            writer.writeheader()
            for data in image_fitur:
                writer.writerow(data)
    except IOError:
        print("I/O")
    svm = SVMM.SVMM().train()

    csv_column.append("kelas")
    fitur.update({"kelas": svm[0]})

    try:
        with open('csv/hasil-uji.csv', 'a', newline='', encoding='utf-8') as f_object:
            dictwriter_object = csv.DictWriter(f_object, fieldnames=csv_column)
            dictwriter_object.writerow(fitur)
            f_object.close()
    except IOError:
        print("I/O")

    image_fitur[0].pop('rgb_mean')
    image_fitur[0].pop('rgb_stdev')

    return jsonify(
        {
            "urlAsli": "http://192.168.96.80:8000/static/TES/"+f.filename,
            "urlLBP": "http://192.168.96.80:8000/static/LBP/"+f.filename,
            "urlGRY": "http://192.168.96.80:8000/static/GRY/"+f.filename,
            "hasil":  "bagus" if svm[0] == 1 else "sedang" if svm[0] == 2 else "buruk"

        }
    )


@app.route('/svm', methods=['POST'])
def svm():

    prediction = request.form['prediction']
    my_dict = ast.literal_eval(prediction)
    lbp = [fitur for fitur in my_dict]
    print(lbp)

    csv_column = ["lbp_mean", "lbp_stdev", "rgb_mean", "rgb_stdev"]

    csv_file = "csv/uji1.csv"
    try:
        with open(csv_file, 'w') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=csv_column)
            writer.writeheader()
            for data in lbp:
                writer.writerow(data)
    except IOError:
        print("I/O")

    svm = SVMM.SVMM().train()
    print(svm)
    return render_template('hasil.html', hasil=svm)


if __name__ == "__main__":
    app.run(port=3000, debug=True)
