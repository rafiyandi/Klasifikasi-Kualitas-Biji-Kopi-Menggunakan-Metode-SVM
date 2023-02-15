#!/usr/bin/python
from PIL import Image
import os, sys

class resizes:
    def __init__(self, img, path):
        self.img = img
        self.path = "static/"+path+"/"
        
    def resize(self):
        im = Image.open(self.path+self.img)
        f, e = os.path.splitext(self.path+self.img)
        imResize = im.resize((300,300), Image.ANTIALIAS)
        imResize.save("static/RESIZE/"+self.img, 'PNG', quality=90)
        return f+' resized.png'
