/*
select sum(x)
from generate_series(1, 999) as t(x)
where (x % 3 = 0) or (x % 5 = 0);
*/
\set n 1000

with multiples(x) as (
  select generate_series(0, :n - 1, 3)
  union
  select generate_series(0, :n - 1, 5)
)
  select sum(x) from multiples;
