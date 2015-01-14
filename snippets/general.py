# coding=utf-8

# traceback

import traceback

traceback.print_exc()


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
logger = logging.getLogger(__name__)

# Type Check

val = u"ああああ"
isinstance(val, basestring)

# Write to File with encoding

import codecs

with codecs.open("test.txt", "w", "utf-8") as file:
    file.write(u"ああああ")

import json

with codecs.open("test.txt", "w", "utf-8") as file:
    file.write(json.dumps(obj, encoding='utf-8', ensure_ascii=False, indent=2))


# Read file with encoding
with codecs.open('./ad.tsv', 'r', 'utf-8') as file:
    for line in file:
        print(line)


# Avoid UnicodeEncodeError
def encode_str():
    for w in [u'ああああ', u'ううううう', u'東方永夜抄']:
        print(w.encode('utf-8'))

import sys

def mod_stdout():
    sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
    for w in [u'ああああ', u'ううううう', u'東方永夜抄']:
        # sys.stdout.write(w)
        print(w)


# print unicode charactor
import re, pprint
def pp(obj):
    pp = pprint.PrettyPrinter(indent=4, width=160)
    str = pp.pformat(obj)
    return re.sub(r"\\u([0-9a-f]{4})", lambda x: unichr(int("0x"+x.group(1), 16)), str)


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

# Pandas

df = pd.DataFrame.from_records(hoge.read()), index='time')
resampled = df.resample('10min', how='count')
resampled.fillna(value=0, inplace=True)

pd.rolling_mean(resample, 6).plot(figsize=(14, 5), title=u"10分間での獲得人数推移、60min移動平均")


# Create utc datetime

import pytz
from datetime import datetime
datetime.now(pytz.utc)

# naive time to utc

d = datetime.now()
d.strftime('%Y-%m-%d %H:%M:%S') # 2014-08-01 16:00:00

jst = pytz.timezone('Asia/Tokyo')
localtime = jst.localize(d)
localtime.strftime('%Y-%m-%d %H:%M:%S %Z') # 2014-08-01 16:00:00 JST

utctime = localtime.astimezone(pytz.utc)
utctime.strftime('%Y-%m-%d %H:%M:%S %Z') # 2014-08-01 07:00:00 UTC

# UNIX time from utc

import calendar
calendar.timegm(datetime.utcnow().timetuple())

# Regexp

match = re.search(r'.*youtube.com/embed/([^?]+)', href)
if match:
    youtube_video_id = match.group(1)

# tornado server

import tornado.ioloop
import tornado.web


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write('Hello World')

    def post(self):
        """ echo server """
        self.write(self.request.body)


application = tornado.web.Application([
    (r"/", MainHandler),
])

if __name__ == "__main__":
    application.listen(8889)
    tornado.ioloop.IOLoop.instance().start()


# setup.py

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
