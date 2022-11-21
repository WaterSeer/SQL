USE pipes;

--1
select ud.unit_id, ud.unit_name 
from unit_dict ud join unit_dict parent_ud 
	on ud.parent_id = parent_ud.unit_id 
where ud.parametr_count > parent_ud.parametr_count

--2
select * 
from unit_dict 
right join (select ud.location_id, MAX(ud.parametr_count) as 'max_count'
            from unit_dict ud
            group by ud.location_id) as ud 
            on unit_dict.location_id = ud.location_id and unit_dict.parametr_count = ud.max_count
order by ud.max_count desc

--3
select location_dict.id 
from location_dict 
left join 
		(select location_id, count(location_id) as location_count
		from unit_dict 
		group by location_id) as ud
		on location_dict.id = ud.location_id
where ud.location_count < 3 or ud.location_count is null

--4
select u.unit_id 
from unit_dict u
join 
	(select parent_u.parent_id, sum(parent_u.parametr_count) as sum_parameters 
	from unit_dict u 
		join unit_dict parent_u
		on u.unit_id = parent_u.parent_id
	group by parent_u.parent_id) as p
	on u.unit_id = p.parent_id
	where u.parametr_count >= p.sum_parameters

--5	
select location_dict.location_name 
from location_dict
right join (
		select * 
		from unit_dict
		where parametr_count = (
			select min(parametr_count)
			from unit_dict)
		) as u
		on location_dict.id = u.location_id
		group by location_dict.location_name

--6
select p.pipe_no, up.duration 
from unit_passes up
right join (	
	  select u.matid, max(u.dt) as 'last_date'
	  from unit_passes u
	  where  u.dt > ('01.05.2016') and u.dt < ('20.05.2016') 
	  group by u.matid
	  ) as u
	  on up.matid = u.matid and up.dt = u.last_date 
join pipes as p
on up.matid = p.matid

--7
select p.pipe_no
from pipes p
join (
			select *
			from unit_passes up
			where up.unitid = 22) as up
			on up.matid != p.matid
group by p.pipe_no

--8
select p.pipe_no, u.dt, u.duration, prev_u.duration as 'previous_duration' 
from unit_passes u 
join 
	(select *
	from pipes p 
	where p.pipe_no like lower('итз%')
	) as p 
	on p.matid = u.matid
join unit_passes prev_u
	on u.parent_pass_id = prev_u.pass_id
order by u.duration
