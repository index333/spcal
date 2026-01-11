from cmath import *
from tkinter import *
from tkinter import filedialog
from tkinter import ttk
def dist(a,b): 
    return abs(a-b)
p=12.7
yen = pi * 2
def f (h,l,t):
    print (h,l,t)
    if abs(h-l) < 0.1: return (h)
    else: 
        m = mid (h,l)
        a = cf(m,t)
        if a > p : return(f(m,l,t))
        else: return (f(h,m,t))
def f2(h,l,hyp,op):
    if abs(h-l) < 0.00001:
        (i,com) = cf2 (h,hyp)
        return (h,com.real)
    else:
        m = mid(h,l)
        (i,_) = cf2(m,hyp)
        if i > op: return(f2(m,l,hyp,op))
        else: return (f2(h,m,hyp,op))
def cf2 (x,mag) : 
    a = rect(mag,x)        
    return (a.imag,a)
def mid(h,l) : return((h+l) / 2)
def cf(x,t): 
    c0=rect(x,yen/t)
    c1=rect(x,0)
    return (dist(c0,c1))
def dist(a,b): 
    return abs(a-b)
def show(): 
    [ft,rt,cs] = [i.get() for i in vList]
    fpcr = f (200.0,0.0,ft)
    rpcr = f (200.0,0.0,rt)
    print (fpcr)
    print (rpcr)
    [hyp,op,h,l]=[cs,(fpcr-rpcr),yen/4,0]
    (a,b)=f2(h,l,hyp,op)
    print (a,b)
    l0=ft*(yen/4+a)/yen
    l1=rt*(yen/4-a)/yen
    l2=b/p
    clen= ((l0+l1+l2)*2)
    print (clen)
    label.config(text= str(clen))
def callback(arg1, arg2, arg3): show()
w = Tk()
textList = ["front(T)","rear(T)","chain stay(mm)","links"]
fList = [ttk.LabelFrame(w,text=i) for i in textList]
for i in fList: i.pack()
vList = [DoubleVar() for i in range(3)]
valSetList = [48.0,16.0,405.0]
for i in range(3): vList[i].set(valSetList[i])
sp0=ttk.Spinbox(fList[0],format='%2.0f',state='readonly',textvariable=vList[0],from_=20,to=60,increment=1,command=show)
sp1=ttk.Spinbox(fList[1],format='%2.0f',state='readonly',textvariable=vList[1],from_=6,to=35,increment=1,command=show)
sp2=ttk.Spinbox(fList[2],format='%3.0f',textvariable=vList[2],from_=100,to=700,increment=1,command=show)
for i in [sp0, sp1, sp2]: i.pack()
label=ttk.Label(fList[3])
label.pack()
vList[2].trace_add(('write'),callback)
show()
w.mainloop()
