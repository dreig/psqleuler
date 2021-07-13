\set n 20
with recursive t(a, b) as (
	values(1, 1)
	union all
	select a+1, lcm(a+1, b) from t where a < :n
)
	select a,b from t;
