# coding=utf-8

# traceback

import traceback

print(traceback.format_exc())


# get current dir

import os

BASE_DIR = os.path.normpath(os.path.join(os.path.dirname(__file__), '../'))
CUR_DIR = os.path.abspath(os.path.dirname(__file__))

print(BASE_DIR)
print(CUR_DIR)

# logging.basicConfig

import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s %(levelname)s %(message)s')

# Type Check

val = u"ああああ"
isinstance(val, basestring)

# Write to File with encoding

import codecs

with codecs.open("test.txt", "w", "utf-8") as file:
    file.write(u"ああああ")


with codecs.open("test.txt", "w", "utf-8") as file:
    file.write(json.dumps(obj, encoding='utf-8', ensure_ascii=False, indent=2)


# Read file with encoding
with codecs.open('./ad.tsv', 'r', 'utf-8') as file:
    for line in file:
        print(line)


# datetime to string

import datetime

datetime.datetime.now().strftime('%Y%m%d')

# Inverse dictionary

# Class Decorator (Mixin)

def HogeMixin(clazz):
    def methodA(self, foo):
        return foo + bar

    @property
    def propB(self):
        return self.B

    setattr(clazz, 'methodA', methodA)
    setattr(clazz, 'propB', propB)
    return clazz

@HogeMixin
class Base(object):
    pass

# Boot point

def main():
    pass

if __name__ == '__main__':
    main()

# JSON dumps

import json

def default_serializer(obj):
    """Default JSON serializer"""
    if isinstance(obj, datetime):
        return obj.strftime('%Y/%m/%d %H:%M:%S')
    if isinstance(obj, date):
        return obj.strftime('%Y/%m/%d')

json.dumps(data, default=default_serializer, ensure_ascii=False)

# setup.py

import os
from setuptools import setup

version = '0.0.1'
name = 'package-name'
short_description = 'mypackage'

setup(
    name=name,
    version=version,
    author='Takashi Nishibayashi(hagino3000)',
    author_email="takashi.nishibayashi@gmail.com",
    description=short_description,
    install_requires=open('requirements_prod.txt').read().splitlines(),
    url='https://github.com/hagino3000/xxxxxx',
    packages=['mypackage'],
    classifiers=[
        "Development Status :: 4 - Beta",
        "Topic :: Utilities",
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
    ],
)

# replace

u"これは。すごい。ですね。".replace('。', u'。<br>')
