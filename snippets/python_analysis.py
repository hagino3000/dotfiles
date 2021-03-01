# Rolling Count

df = pd.DataFrame.from_records(hoge.read()), index='time')
resampled = df.resample('10min').count()
resampled.fillna(value=0, inplace=True)

resampled.rolling(6).mean().plot(figsize=(14, 5), title=u"10分間での獲得人数推移、60min移動平均")

resampled.plot() # 10分毎の獲得人数推移

# Rolling Value

c = df_timeline.resample('1min').count()  # 1分毎のカウント
s = df_timeline.resample('1min').sum()    # 1分毎の合計

(s.rolling(5).sum()/c.rolling(5).sum()).plot() # 5分移動平均

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

# Exact method
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

# wilson score

import statsmodels.stats.proportion

def calc_confidence_interval(row, alpha=0.05):
    # alpha = 0.05の時に95%信頼区間となる
    if row.click > 0:
        lo, hi = statsmodels.stats.proportion.proportion_confint(
            row.cv, row.click, alpha=alpha, method='wilson')
    else:
        lo = 0
        hi = 1
    return (lo, hi)


# Plot for each values
fig = plt.figure(figsize=(14, 40))
for idx, x in enumerate(x_values):
    ax = fig.add_subplot(len(x_values), 1,idx + 1)
    df[df.x == x].plot(ax=ax)
    ax.set_title(xxxxxxxxx)


fig, ax = plt.subplots(1, 3, figsize=(8, 3))
df['aaa'].plot(ax=ax[0])
df['bbb'].plot(ax=ax[1])



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


# plot with confidence and point estimate value

## tiny sample
x = ['a', 'b', 'c']
y = [0.1, 0.2, 0.3]
# 下側誤差と上側誤差
errs = [[0.01, 0.02, 0.03], [0.02, 0.04, 0.06]]
plt.errorbar(x, y, fmt='o', yerr=errs)
plt.ylabel('y with confidence')
plt.xlabel('x')


## e.g.
from  statsmodels.stats.proportion import proportion_confint

def calc_ucb(click, cv):
    return proportion_confint(cv, click, method='wilson')[1]

def calc_lcb(click, cv):
    return proportion_confint(cv, click, method='wilson')[0]

_df_cvr = df_click.groupby('xx')[['clicked', 'converted']].sum()
_df_cvr['cvr'] = _df_cvr['converted']/_df_cvr['clicked']
_df_cvr['ucb'] = _df_cvr.apply(lambda df: calc_ucb(df['clicked'], df['converted']) ,axis=1)
_df_cvr['lcb'] = _df_cvr.apply(lambda df: calc_lcb(df['clicked'], df['converted']) ,axis=1)
_df_cvr['err1'] = _df_cvr['ucb'] - _df_cvr['cvr']
_df_cvr['err2'] = _df_cvr['cvr'] - _df_cvr['lcb']
err = _df_cvr[['err2', 'err1']].to_numpy()
x = list(map(str, _d.cvr.index))
plt.errorbar(x, _d.cvr.values, fmt='o', yerr=err.T)
plt.xticks(rotation=50)



# seaborn
import seaborn as sns

plt.style.use('ggplot')
plt.rcParams['font.family'] = 'Osaka'

sns.jointplot("x", "y", df, kind='reg');

# print score
from sklearn.metrics import log_loss, f1_score, accuracy_score
def print_score(y, y_pred, prefix=""):
    import pandas
    if type(y) == pandas.core.sparse.series.SparseSeries:
        y = y.to_dense()
    print('{prefix}log loss {logloss:.3f}, f1 {f1:.3f}, accuracy {accuracy:.3f}'.format(
        prefix=prefix,
        logloss=log_loss(y, y_pred),
        f1=f1_score(y, np.round(y_pred)),
        accuracy=accuracy_score(y, np.round(y_pred))
    ))


# matplotlib

plt.figure(figsize=(20,10))
plt.plot(X, Y)
plt.savefig("./c.png", format='png', facecolor='white', transparent=False, dpi=92)


# secondaly axis
def plot_x(actual_df, plan_df, output_df, x):
    fig, ax = plt.subplots(figsize=(10, 4))
    ax.plot(np.cumsum(actual_df[x]), label='Plan')
    ax.plot(plan_df[x].cumsum(), label='Actual')

    ax2 = ax.twinx()
    ax2.plot(output_df[x], label='Output', linestyle='--', color='red')
    ax2.set_ylabel('Output')
    ax2.legend(loc='lower right')
    ax.legend(loc='best')


# Check nan
def check_nan(X):
    print(X.info())
    print('Ensure all finite:', np.isfinite(X).all().all())
    print('NaN count:', X.isnull().values.sum())


# 時間計測
from contextlib import contextmanager
import datetime as dt

@contextmanager
def measure_duration_time():
    start = dt.datetime.now()
    yield
    end = dt.datetime.now()
    print((end - start).seconds)


def convert_parameter_to_scipy_lognorm(mean, median):
    # scale parameter also the median
    scale = median
    # shape parameter also the standard deviation
    mu = np.log(median)
    shape = np.sqrt(2*(np.log(mean) - mu))
    return scipy.stats.lognorm(shape, 0, scale)


# Create utc datetime

import pytz
from datetime import datetime
datetime.now(pytz.utc)

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


# pandas format
NUMBER_FORMATS = {
    'rate': '{: <10.2%}',
    'counts': '{:,}',
    'float_field': '{:,.0f}'
}


def apply_format(_df):
    return _df.style.format(NUMBER_FORMATS)


# for Jupyter

import os, sys
sys.path.append(os.path.abspath('../src'))

