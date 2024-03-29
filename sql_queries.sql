
/****** 1. For each user, count his/her friends  ******/
/****** Duration: 00:00:13  ******/
select top 1000 [user], count([friend]) as [totalfriends]
from [networks].[dbo].[soc-pokec-relationships]
where [friend] < 1000
group by [user]
order by [user]


/****** 2. For each user, count his/her friends of friends  ******/
--duration 00:00:36
SELECT [networks].[dbo].[soc-pokec-relationships].[user],  sum([total_friends]) as [friends_of_friends]
FROM [networks].[dbo].[soc-pokec-relationships]
INNER JOIN (select [user], count([friend]) as [total_friends]
from [networks].[dbo].[soc-pokec-relationships]
group by [user]) as friends ON [networks].[dbo].[soc-pokec-relationships].[friend]=friends.[user]
group by [networks].[dbo].[soc-pokec-relationships].[user]
order by [networks].[dbo].[soc-pokec-relationships].[user]

--check
SELECT [networks].[dbo].[soc-pokec-relationships].[user], [networks].[dbo].[soc-pokec-relationships].[friend], [total_friends]
FROM [networks].[dbo].[soc-pokec-relationships]
INNER JOIN [networks].[dbo].[total-friends] ON [networks].[dbo].[soc-pokec-relationships].[friend]=[networks].[dbo].[total-friends].[user]
where [networks].[dbo].[soc-pokec-relationships].[user]=1
order by [networks].[dbo].[soc-pokec-relationships].[user]


/****** 3. - For each user, count his/her friends that are over 30  ******/
--duration 00:00:11
SELECT [networks].[dbo].[soc-pokec-relationships].[user], count([networks].[dbo].[profile].[age]) as age30
FROM [networks].[dbo].[soc-pokec-relationships]
INNER JOIN [networks].[dbo].[profile] ON [networks].[dbo].[soc-pokec-relationships].[friend]=[networks].[dbo].[profile].[user]
where [networks].[dbo].[profile].[age] > 30
group by [networks].[dbo].[soc-pokec-relationships].[user]
order by [networks].[dbo].[soc-pokec-relationships].[user]

--check
select [networks].[dbo].[profile].[user], [networks].[dbo].[profile].[age]
from [networks].[dbo].[profile]
where [networks].[dbo].[profile].[user]=6

/****** 4. For each male user, count how many male and female friends he is having   ******/
--duration 00:00:11
SELECT table1.[user], 
count(case table4.[gender] when 1 then 1 else null end) as male, 
count(case table4.[gender] when 0 then 1 else null end) as female
FROM (select table2.[user], table2.[friend], table3.[gender] as user_gender 
from [networks].[dbo].[soc-pokec-relationships] as table2
INNER JOIN [networks].[dbo].[profile] as table3 ON table2.[user]=table3.[user]
where table3.[gender] = 1) as table1
INNER JOIN 
[networks].[dbo].[profile] as table4
ON table1.[friend]=table4.[user]
group by table1.[user]
order by table1.[user]

--check
SELECT [networks].[dbo].[soc-pokec-relationships].[user], [networks].[dbo].[soc-pokec-relationships].[friend], [networks].[dbo].[profile].[gender]--[networks].[dbo].[soc-pokec-relationships].[friend], [networks].[dbo].[profile].[age]  
FROM [networks].[dbo].[soc-pokec-relationships]
INNER JOIN [networks].[dbo].[profile] ON [networks].[dbo].[soc-pokec-relationships].[friend]=[networks].[dbo].[profile].[user]
where [networks].[dbo].[soc-pokec-relationships].[user] = 8
order by [networks].[dbo].[soc-pokec-relationships].[user]


