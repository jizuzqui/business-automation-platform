TYPE=VIEW
query=select `apromore`.`jbpt_petri_nets`.`id` AS `id` from `apromore`.`jbpt_petri_nets` where (not(`apromore`.`jbpt_petri_nets`.`id` in (select `apromore`.`pql_index_status`.`net_id` AS `id` from `apromore`.`pql_index_status`))) order by `apromore`.`jbpt_petri_nets`.`id`
md5=931462df600bf0076614596800be4498
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=1
with_check_option=0
timestamp=2019-11-11 23:24:12
create-version=1
source=select `jbpt_petri_nets`.`id` AS `id` from `jbpt_petri_nets` where (not(`jbpt_petri_nets`.`id` in (select `pql_index_status`.`net_id` AS `id` from `pql_index_status`))) order by `jbpt_petri_nets`.`id`
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `apromore`.`jbpt_petri_nets`.`id` AS `id` from `apromore`.`jbpt_petri_nets` where (not(`apromore`.`jbpt_petri_nets`.`id` in (select `apromore`.`pql_index_status`.`net_id` AS `id` from `apromore`.`pql_index_status`))) order by `apromore`.`jbpt_petri_nets`.`id`
