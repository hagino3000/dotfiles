# coding=utf-8

# traceback

import traceback
import logging

try:
    pass
except Exception, e:
    traceback.print_exc(e)
    logging.exception(e)

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

# Pandas

df = pd.DataFrame.from_records(hoge.read()), index='time')
resampled = df.resample('10min', how='count')
resampled.fillna(value=0, inplace=True)

pd.rolling_mean(resample, 6).plot(figsize=(14, 5), title=u"10分間での獲得人数推移、60min移動平均")

# Secondary Y axis
df.B.plot(secondary_y=True, style='g')

# Legend
df.B.plot(label='Data B', legend=True)

# Pivot
df.pivot(index=xx, columns=yy, values=zz)

# Query with multiple index
g = df_A.groupby('creative_id').agg(['count', 'sum'])
g[(g.loc[:,('count', 'count')] > 200)&(g.loc[:,('count', 'sum')] > 3000)].head()

# Query with multiple value
df_A[df_A.loc[:,'creative_id'].isin(creative_ids)]

# Plot with confidence interval
import scipy.stats

def calc_confidence_interval(row):
    # alpha = 0.05の時に95%信頼区間となる
    # n = 試行回数
    # k = success
    alpha = 0.05
    k = row.conversion
    n = row.click
    lo = scipy.stats.beta.ppf(alpha/2, k, n-k+1)
    hi = scipy.stats.beta.ppf(1 - alpha/2, k+1, n-k)
    return hi - lo

# Plot for each values
fig = plt.figure(figsize=(14, 40))
for idx, x in enumerate(x_values):
    ax = fig.add_subplot(len(x_values), 1,idx + 1)
    df[df.x == x].plot(ax=ax)
    ax.set_title(xxxxxxxxx)



_df = _df.set_index('date_hour')
ix = pd.DatetimeIndex(start=start_date, end=end_date, freq='H')
_df = _df.reindex(ix)


df['error'] = df.apply(calc_confidence_interval, axis=1)

df.CVR.plot(subplots=True, yerr=df.error, figsize=(15, 45))
# OR
df.CVR.plot(figsize=(14, 4))
plt.fill_between(df.index, df.CVR - df.error/2, df.CVR + df.error/2, color='#AAAAAA')


def calc_xxx(df):
    return df.bbb + df.aaaa
df['xxx'] = df.apply(calc_xxx, axis=1)

# Caln bernoulli error with normal approximately
from scipy.stats import norm
def calc_error(df):
    p = df.x
    samples = df.trial
    rv = norm()
    t = rv.ppf(0.95)
    return t * np.sqrt(p*(1-p)/samples)

# seaborn
import seaborn as sns

plt.style.use('ggplot')
plt.rcParams['font.family'] = 'Osaka'

sns.jointplot("x", "y", df, kind='reg');


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


# 実行時間プロファイルの取得
import cProfile
import pstats

def do():
    xxx

prf = cProfile.Profile()
prf.runcall(do)
p = pstats.Stats(prf)
p.sort_stats('time').print_stats()


# ベルヌーイ分布の信頼区間Clopper and peason
https://gist.github.com/DavidWalz/8538435

def calc_clopper_peason_confidence_interval(trial, success, alpha):
    # alpha = 0.05の時に95%信頼区間となる
    lo = scipy.stats.beta.ppf(alpha/2, success, trial-success+1)
    hi = scipy.stats.beta.ppf(1 - alpha/2, success+1, trial-success)

# Wilson Score
statsmodels.stats.proportion.proportion_confint(3, 100, alpha=0.05, method='wilson')


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

# matplotlib

plt.figure(figsize=(20,10))
plt.plot(X, Y)
