from Tkinter import *
import Tkinter
from PIL import Image, ImageTk
import sys
import glob
import os

#sudo apt-get install python-imaging-tk
#sudo apt-get install pyton-tk

master = Tk()

mainFrame = Tkinter.Frame(master)
mainFrame.grid()

entryFrame = Tkinter.Frame(mainFrame, width=120, height=120)
entryFrame.grid(row=0, column=0)

# allow the column inside the entryFrame to grow    
entryFrame.columnconfigure(0, weight=10)  

# By default the frame will shrink to whatever is inside of it and 
# ignore width & height. We change that:
entryFrame.grid_propagate(False)


image_list = []
for arg in sys.argv:
	if(arg!='IQPlot.py'):
		for filename in glob.glob(os.path.join('data/'+arg+'/train/','*.jpg')): #assuming jpg
			#im=Image.open(filename)
			image_list.append(filename)

for arg in sys.argv:
	if(arg!='IQPlot.py'):
		#fIRST IMAGE
		image1 = Image.open(image_list[1])
		tkimage = ImageTk.PhotoImage(image1)
		myvar=Label(master, image = tkimage)
		myvar.image = tkimage
		myvar.grid(row=1,column=0)

		#secon IMAGE
		image2 = Image.open(image_list[2])
		tkimage2 = ImageTk.PhotoImage(image2)
		myvar2=Label(master, image = tkimage2)
		myvar2.image = tkimage2
		myvar2.grid(row=1,column=1)

		#thir IMAGE
		image3 = Image.open(image_list[3])
		tkimage3 = ImageTk.PhotoImage(image3)
		myvar3=Label(master, image = tkimage3)
		myvar3.image = tkimage3
		myvar3.grid(row=1,column=2)
	
		#fourth IMAGE
		image4 = Image.open(image_list[4])
		tkimage4 = ImageTk.PhotoImage(image4)
		myvar4=Label(master, image = tkimage4)
		myvar4.image = tkimage4
		myvar4.grid(row=2,column=0)

		#fifth IMAGE
		image5 = Image.open(image_list[5])
		tkimage5 = ImageTk.PhotoImage(image5)
		myvar5=Label(master, image = tkimage5)
		myvar5.image = tkimage5
		myvar5.grid(row=2,column=1)

		#sizth IMAGE
		image6 = Image.open(image_list[6])
		tkimage6 = ImageTk.PhotoImage(image6)
		myvar6=Label(master, image = tkimage6)
		myvar6.image = tkimage
		myvar6.grid(row=2,column=2)


		w = Label(master, text="It's a: "+ arg, font = "Helvetica 46 bold italic")
		w.grid(row=0,column=1)

mainloop()
