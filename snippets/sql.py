CREATE TEMP FUNCTION CalcUCBNorm(success INT64, trial INT64)
RETURNS FLOAT64
LANGUAGE js
AS r"""
  if (trial == 0) {
    return 1;
  }
  const n = trial;
  const phat = success/trial;
  const z = 1.96;
  
  return phat + z * Math.sqrt((phat*(1-phat)/n))
""";


CREATE TEMP FUNCTION CalcUCBWilson(success INT64, trial INT64)
RETURNS FLOAT64
LANGUAGE js
AS r"""
  if (trial == 0) {
    return 1;
  }
  const n = trial;
  const p = success/trial;
  const z = 1.96;

  const a = 1/(1+z*z/n);
  const b = p + z*z/(2*n)
  const c = z * Math.sqrt((p*(1-p)+z*z/(4*n))/n);
  return a*(b+c)
""";
