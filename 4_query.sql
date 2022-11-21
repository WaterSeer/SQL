--4 решение если обходить все дочерние элементы дерева
With n as 
(
select unit_dict.unit_id, unit_dict.parent_id, unit_dict.unit_id as top_node, unit_dict.parametr_count as stack
from unit_dict

union all

select c.unit_id, c.parent_id, n.top_node, stack + c.parametr_count as stack
from unit_dict as c
join n on n.unit_id=c.parent_id)

select * 
from unit_dict u
left join 
		(
		select top_node,count(*) as 'sum_nodes', sum(stack) as 'sum_parameter'
		from n
		group by top_node
		) as r
		on u.unit_id = r.top_node
		where sum_nodes > 1 and parametr_count >= sum_parameter