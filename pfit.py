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

fitbounds = [(2.1,2.5), (2.15,2.45), (2.15,2.4), (2.15,2.4), (2.2,2.38), (2.25,2.35)]
deg = 4
exponents = [str(i) for i in range(deg,-1,-1)]
with open('fits.txt','w') as f:
    for attr in ['e','c','m','x']:
        print(attr, [l.name for l in clist])
        for i in range(len(clist)):
            l = clist[i]
            coefs = l.polyfit(attr,False,fitbounds[i][0], fitbounds[i][1], deg)
            functxt = ''
            for c in range(deg+1):
                functxt += '{:+f}*x**{} '.format(coefs[c],exponents[c])
            f.write('f{}{}(x) = {}\n'.format(attr,l.name,functxt))

llist = []
tlist = []

with open('tc.txt','r') as f:
    lines = f.readlines()
    ch = False
    xx = []
    yy = []
    for l in lines:
        if '#' in l: continue
        if l == '\n':
            if ch:
                ch = False
                llist.append(xx)
                tlist.append(yy)
                xx = []
                yy = []
                continue
            ch = True
            continue
        spl = l.replace('\n','').split(' ')
        xx.append(float(spl[1]))
        yy.append(float(spl[2]))
    llist.append(xx)
    tlist.append(yy)

plt.figure()
for ll, tt in zip(llist,tlist):
    plt.plot((np.array(ll))**(-1), np.array(tt))