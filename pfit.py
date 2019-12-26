#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 25 20:51:40 2019

@author: ivan
"""

import matplotlib.pyplot as plt
import numpy as np

plt.ion()

def polycoefs(x,coefs):
    y = 0
    for i in range(len(coefs)):
        y+= coefs[i]*x**(len(coefs)-i-1)
    return y

class ln:
    def __init__(self):
        self.l = []
        self.temp = []
        self.sum =[]
        self.sume = []
        self.sume2 = []
        self.vare = []
        self.summ = []
        self.sumam = []
        self.summ2 = []
        self.varm = []
    def __call__(self,lst):
        try:
            lst = [float(el) for el in lst[:-1]]
            lst[0] = int(lst[0])
        except:
            print(lst)
        self.l.append(lst[0])
        self.temp.append(lst[1])
        self.sum.append(lst[2])
        self.sume.append(lst[3])
        self.sume2.append(lst[4])
        self.vare.append(lst[5])
        self.summ.append(lst[6])
        self.sumam.append(lst[7])
        self.summ2.append(lst[8])
        self.varm.append(lst[9])
    def finish(self):
        self.name = self.l[0]
        self.e = np.array(self.sume)/(np.array(self.l))**2
        self.c = (np.array(self.vare))/((np.array(self.temp))**2*(np.array(self.l))**2)
        self.m = np.array(self.sumam)/(np.array(self.l))**2
        self.x = (np.array(self.summ2)-(np.array(self.sumam))**2)/((np.array(self.temp))*(np.array(self.l))**2)
    def plot(self,name,ax=None):
        attr = getattr(self,name)
        ax = ax or plt.gca()
        plt.plot(self.temp, attr,'x')
    def polyfit(self,name,show=False,lower=None,upper=None,deg=None):
        attr = getattr(self,name)
        if lower is None: lower = input('Lower bound: ')
        if upper is None:upper = input('Upper bound: ')
        lower = float(lower) if lower != '' else 0
        upper = float(upper) if upper != '' else 100
        ilow = np.argmin(np.abs(np.array(self.temp)-lower))
        iupp = np.argmin(np.abs(np.array(self.temp)-upper))
        tno = np.concatenate((self.temp[:ilow],self.temp[iupp:]))
        pno = np.concatenate((attr[:ilow],attr[iupp:]))
        tyes = self.temp[ilow:iupp]
        pyes = attr[ilow:iupp]
        if deg is None: deg = input('Degree: ')
        deg = int(deg)
        coefs = np.polyfit(tyes,pyes,deg)
        if show:
            plt.figure()
            plt.plot(tyes,pyes,'x')
            plt.plot(tno,pno,'x')
            xx = np.linspace(self.temp[0],self.temp[-1],1000)
            plt.plot(xx,polycoefs(xx,coefs))
        return coefs
        
        
    
        

clist = []

with open('MC-TOT.res','r') as f:
    lines = f.readlines()
    ch = False
    curcl = ln()
    for l in lines:
        if '#' in l: continue
        if l == '\n':
            if ch:
                ch = False
                curcl.finish()
                clist.append(curcl)
                curcl = ln()
                continue
            ch = True
            continue
        line = l
        while line[0] == ' ': line = line[1:]
        while '  ' in line: line = line.replace('  ',' ')
        curcl(line.split(' '))
    curcl.finish()
    clist.append(curcl)
    del curcl

fitbounds = [(2.2,2.5), (2.25,2.35), (2.25,2.35), (2.25,2.35), (2.25,2.35), (2.1,2.2), (2.25,2.31)]
degs = dict(e=3,m=3,c=2,x=2)
exponents = {el: [str(i) for i in range(degs[el],-1,-1)] for el in ['e','c','m','x']}
with open('fits.txt','w') as f:
    f.write('#Degs: '+str(degs)+'\n')
    f.write('#Fitbounds: '+str(fitbounds)+'\n')
    for attr in ['e','c','m','x']:
        print(attr, [l.name for l in clist])
        for i in range(len(clist)):
            l = clist[i]
            coefs = l.polyfit(attr,False,fitbounds[i][0], fitbounds[i][1], degs[attr])
            functxt = ''
            for c in range(degs[attr]+1):
                functxt += '{:+f}*x**{} '.format(coefs[c],exponents[attr][c])
            f.write('f{}{}(x) = {}\n'.format(attr,l.name,functxt))

llist = []
tlist = []
alist = []

with open('tc.txt','r') as f:
    lines = f.readlines()
    ch = False
    xx = []
    yy = []
    aa = []
    for l in lines:
        if '#' in l: continue
        if l == '\n':
            if ch:
                ch = False
                llist.append(xx)
                tlist.append(yy)
                alist.append(aa)
                aa = []
                xx = []
                yy = []
                continue
            ch = True
            continue
        spl = l.replace('\n','').split(' ')
        aa.append(spl[0])
        xx.append(float(spl[1]))
        yy.append(float(spl[2]))
    llist.append(xx)
    tlist.append(yy)
    alist.append(aa)

plt.figure()
coeflist = []
with open('fits2.txt','w') as f:
    for aa, ll, tt in zip(alist,llist,tlist):
        l1 = 1/np.array(ll)
        ans = np.polyfit(l1,tt,1,full=True)
        coefs2 = ans[0]
        coeflist.append(coefs2)
        functxt = ''
        for c in range(2):
            functxt += '{:+f}*x**{} '.format(coefs2[c],['1','0'][c])
        f.write('f{}(x) = {}\n'.format(aa[0],functxt))
        plt.plot(np.array(ll)**(-1), np.array(tt), 'x')

