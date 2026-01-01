from cmath import *
from tkinter import *
from tkinter import filedialog
from tkinter import ttk
def dist(a,b): 
    return abs(a-b)
hosei = 2.4 / 2 
yen = pi * 2
def fh (pcd, h, k): 
    pcr= (pcd / 2)
    return (rect (pcr, (yen / (h / 2) * (k - 1) / 2)) )
def fr (d, h):
    a =( d / 2)
    return (rect (a, (yen / h * (-1)))) 
def hypo (l, z):
    a = 0
    b = l + (z * 1j)
    return (dist (a, b))
def len (erd, h ,pcd, flc,k): 
    a = fh (pcd, h, k)
    b = fr (erd, h)
    c = dist (a,b)
    d = hypo(c, flc)  
    return (d - hosei)
def show():
    [erd,h,ew,pcd,e2f,k] = [i.get() for i in vList]
    fc = ew / 2
    f2fc=fc-e2f
    splen0=len(erd,h,pcd,f2fc,k)

    label.config(text= str(round(splen0,1)))
def callback(arg1, arg2, arg3): show()
w = Tk()
w.title('spoke length')
textList = ["rim erd(mm)","穴数","end幅(mm)","pcd(mm)","end-flange(mm)","組数","spoke length(mm)"]
fList = [ttk.LabelFrame(w,text=i) for i in textList]
for i in fList: i.pack()
vList = [DoubleVar() for i in range(6)]
valSetList = [552,32,100,38,16,6]
for i in range(6): vList[i].set(valSetList[i])
sp0=ttk.Spinbox(fList[0],format='%3.1f',textvariable=vList[0],from_=500,to=700,increment=0.1,command=show)
sp1=ttk.Spinbox(fList[1],format='%2.0f',state='readonly',textvariable=vList[1],from_=20,to=40,increment=4,command=show)
sp2=ttk.Spinbox(fList[2],format='%3.0f',state='readonly',textvariable=vList[2],from_=100,to=135,increment=1,command=show)
sp3=ttk.Spinbox(fList[3],format='%2.0f',state='readonly',textvariable=vList[3],from_=10,to=100,increment=1,command=show)
sp4=ttk.Spinbox(fList[4],format='%3.1f',state='readonly',textvariable=vList[4],from_=10,to=70,increment=1,command=show)
sp5=ttk.Spinbox(fList[5],format='%1.0f',state='readonly',textvariable=vList[5],from_=0,to=8,increment=2,command=show)
for i in [sp0, sp1, sp2, sp3, sp4, sp5]: i.pack()
label=ttk.Label(fList[6])
label.pack()
vList[0].trace_add(('write'),callback)
show()
w.mainloop()
