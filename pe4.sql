create or replace function generate_mirror_palindrome
(
	in nn int,
	out pal bigint
)
returns bigint
language sql
as $$
	with recursive partial(n, rev, pw) as (
		values(nn, 0, 1)
		union all
		select n/10, rev*10 + n%10, pw*10 from partial where n > 0
	)
	select nn::bigint*max(pw) + max(rev)
	from partial;
$$;

with numbers(n) as (
	select generate_series(100, 999, 1)
),
palindromes as (
	select generate_mirror_palindrome(n) as pal
	from numbers
	order by pal desc
),
/*
	TODO: find a way to optimize this (it won't even work for 4 digits)
*/
products as (
	select distinct(t1.n * t2.n) as product
	from numbers as t1
	cross join numbers as t2
	order by product desc
)
	select product
	from products
	join palindromes on products.product = palindromes.pal
	order by product desc
	limit 10;
