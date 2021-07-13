\set n 100

select sum(n)*sum(n) - sum(n*n)
from generate_series(1, :n, 1) as t(n);
