# coding=utf-8

# traceback

import traceback

print(traceback.format_exc())


# get current dir

import os

BASE_DIR = os.path.normpath(os.path.join(os.path.dirname(__file__), '../'))

print(BASE_DIR)

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
