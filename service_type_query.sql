select 
	cast(erts.load_dt_tm as date) as load_dt,  
 	cntnt_id, 
 	invt_space_id, 
	c.tdata_srv_type_id,
	c.srv_type_desc,
 	count(erts.tdata_hshld_id) as served_content_cnt
 	
  from VDWCPAVIEWS.evlt_resp_trck_scr erts
  inner join 
  (
 	
 	(SELECT
tdata_hshld_id
,b.tdata_srv_type_id
, b.srv_Type_desc
FROM
(
SELECT tdata_hshld_id
,MAX(bb_subsrptn_sts_ind) bb_subsrptn_sts_ind
,MAX(dial_up_subsrptn_sts_ind) dial_up_subsrptn_sts_ind
,MAX(telco_subsrptn_sts_ind) telco_subsrptn_sts_ind
,MAX(uvrs_hsi_subsrptn_ind) uvrs_hsi_subsrptn_ind
,MAX(uvrs_iptv_subsrptn_ind) uvrs_iptv_subsrptn_ind
,MAX(uvrs_voip_subsrptn_ind) uvrs_voip_subsrptn_ind
,MAX(wirls_subsrptn_sts_ind) wirls_subsrptn_sts_ind
,MAX(dtv_subsrptn_sts_ind) dtv_subsrptn_sts_ind
FROM
vdwcpaviews.tdata_cust_loc a
JOIN
vdwcpaviews.tdata_acct_mp_hist b
ON
a.cust_loc_id = b.cust_loc_id
WHERE b.tdata_acct_mp_end_dt = '9999-12-31'
GROUP BY 1
) a
JOIN
vdwcpaviews.srv_type_avt b
ON
a.bb_subsrptn_sts_ind = b.bb_subsrptn_sts_ind
AND a.dial_up_subsrptn_sts_ind = b.dial_up_subsrptn_sts_ind
AND a.telco_subsrptn_sts_ind = b.telco_subsrptn_sts_ind
AND a.uvrs_hsi_subsrptn_ind = b.uvrs_hsi_subsrptn_ind
AND a.uvrs_iptv_subsrptn_ind = b.uvrs_iptv_subsrptn_ind
AND a.uvrs_voip_subsrptn_ind = b.uvrs_voip_subsrptn_ind
AND a.wirls_subsrptn_sts_ind = b.wirls_subsrptn_sts_ind
AND a.dtv_subsrptn_sts_ind = b.dtv_subsrptn_sts_ind
	 )) c
	on c.tdata_hshld_id =erts.tdata_hshld_id
 where erts.tdata_hshld_id<>0
	and cast(erts.load_dt_tm as date) >= cast(now() as date)-7
 group by 
 cast(erts.load_dt_tm as date),  
 cntnt_id, 
 invt_space_id, 
c.tdata_srv_type_id,
c.srv_type_desc
