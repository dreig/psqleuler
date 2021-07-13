\set n 4e6::int

with recursive t(a, b) as (
  values(1, 1)
  union all
  select a+b, a from t where a+b < :n
)
  select sum(a) from t where a % 2 = 0;
