# coding=utf-8

# traceback

import traceback
import logging

try:
    pass
except Exception as e:
    traceback.print_exc(e)
    logging.exception('foo', e)

# string format
"File name is {year}/{month:0>2}/{day:0>2}.tar.gz".format(
    year=2015,
    month=1,
    day=31
)

# number format
>>> "{0:,d}".format(1234567)
'1,234,567'
>>> "{0:.3f}".format(12.34)
'12.340'


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

# String format with zero padding

print("gsutil list s3://xxxx/y=2015/m={month:0>2d}/d={day:0>2d}/\*/\* > 2015{month:0>2d}{day:0>2d}.dat".format(
    month=month, day=day
))

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


# datetime using arrow
import arrow
arrow.get().to('Asia/Tokyo').format()
target_date = arrow.get(self.date, 'Asia/Tokyo')

# datetime to string

import datetime

datetime.datetime.now().strftime('%Y%m%d')

datetime.datetime.strptime('2015-01-01 23:59:59', '%Y-%m-d %H:%M:%d')

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


# Memoize decorator
def memoize(f):
  class memodict(dict):
      __slots__ = ()
      def __missing__(self, key):
          self[key] = ret = f(key)
          return ret
  return memodict().__getitem__


# Decorator which returns decorator (required parameter)
def retry_server_error(errors=(IOError), tries=5, delay=3, logger=None):
    def decorator(f):
        @functools.wraps(f)
        def with_retry(*args, **kwargs):
            current_try = 1
            current_delay = delay
            while True:
                try:
                    return f(*args, **kwargs)
                except errors, e:
                    if logger:
                        logger.warn(e)
                    if current_try >= tries:
                        raise
                    current_try += 1
                    time.sleep(current_delay)
                    current_delay *= 2
        return with_retry
    return decorator


@retry_server_error()
def do_something(hoge):
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

# LTSV string to dict

d = dict([x.split(':', 1) for x in line.split('\t')])


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

# UNIX time to datetime (Use system timezone)
datetime.fromtimestamp(1420037979)

# UTC to UNIX time
int(time.mktime(datetime.utcnow().timetuple()))

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

# comments

def read(self, first_date, last_date=None, query={}, fields=None, with_id=False):
    """
    日付指定でxxxを取得する

    Parameters
    ----------
    first_date : str or datetime.date
        取得対象日Start
    last_date : str or datetime.date
        取得対象日END
    query : dict<str: any>
        日付以外の検索条件
    fields : list<str>
        取得フィールド

    Returns
    -------
    gen : generator
        マッチしたドキュメントを返すジェネレータ

    Examples
    --------
    # Read one day
    >>> read('2014/07/01', query={'action': 'pv'}, fields=['target'])
    # Read range
    >>> read('2014/7/1', '2014/7/31')
    """


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


# S3 boto
s3 = boto3.resource('s3')
obj = s3.Object(bucket_name, key)
d = json.loads(obj.get()['Body'].read().decode('utf-8'))

# GCS
from google.cloud import storage

client = storage.Client(project=config.GCP_PROJECT_NAME)
bucket_name = "xxxx"
bucket = client.get_bucket(bucket_name)
blob = bucket.get_blob("yyyy")
contents = blob.download_as_string()



# argparse
import argparse
parser = argparse.ArgumentParser()
parser.add_argument(
    '--target_date', dest='target_date', required=True, type=lambda d: dt.datetime.strptime(d, '%Y-%m-%d'),
    help='Target Date of xxxx e.g. 2018-01-01')
parser.add_argument(
    '--hoge_id', dest='hoge_id', required=True,
    type=int, help='ssp_id')
args = parser.parse_args(argv)
target_date = args.target_date
hoge_id = args.hoge_id


# 逆アセンブリ
import dis

def xx():
    return [v**2 for v in range(10)]

dis.dis(xx)


