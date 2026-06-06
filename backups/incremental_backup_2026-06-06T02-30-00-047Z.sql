# The proper term is pseudo_replica_mode, but we use this compatibility alias
# to make the statement usable on server versions 8.0.24 and older.
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#260604  6:20:51 server id 1  end_log_pos 126 CRC32 0x8d89f5df 	Start: binlog v 4, server v 8.0.44 created 260604  6:20:51 at startup
# Warning: this binlog is either in use or was not closed properly.
ROLLBACK/*!*/;
# at 12386
#260605  8:52:00 server id 1  end_log_pos 12465 CRC32 0x6f101269 	Anonymous_GTID	last_committed=32	sequence_number=33	rbr_only=yes	original_committed_timestamp=1780620720924793	immediate_commit_timestamp=1780620720924793	transaction_length=355
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780620720924793 (2026-06-05 08:52:00.924793 China Standard Time)
# immediate_commit_timestamp=1780620720924793 (2026-06-05 08:52:00.924793 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780620720924793*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 12465
#260605  8:52:00 server id 1  end_log_pos 12550 CRC32 0xf67446b7 	Query	thread_id=35	exec_time=0	error_code=0
SET TIMESTAMP=1780620720/*!*/;
SET @@session.pseudo_thread_id=35/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1168113704/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=224,@@session.collation_connection=224,@@session.collation_server=255/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
/*!80011 SET @@session.default_collation_for_utf8mb4=255*//*!*/;
BEGIN
/*!*/;
# at 12550
#260605  8:52:00 server id 1  end_log_pos 12624 CRC32 0xaad518eb 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 12624
#260605  8:52:00 server id 1  end_log_pos 12710 CRC32 0xb29a6b7b 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1070
###   @2=1
###   @3='Login'
###   @4='Test Admin logged in as Admin'
###   @5='2026-06-05 08:52:00'
# at 12710
#260605  8:52:00 server id 1  end_log_pos 12741 CRC32 0x8cdb9e7e 	Xid = 1713
COMMIT/*!*/;
# at 12741
#260605  8:52:11 server id 1  end_log_pos 12820 CRC32 0xf75cb44e 	Anonymous_GTID	last_committed=33	sequence_number=34	rbr_only=yes	original_committed_timestamp=1780620731753521	immediate_commit_timestamp=1780620731753521	transaction_length=350
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780620731753521 (2026-06-05 08:52:11.753521 China Standard Time)
# immediate_commit_timestamp=1780620731753521 (2026-06-05 08:52:11.753521 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780620731753521*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 12820
#260605  8:52:11 server id 1  end_log_pos 12905 CRC32 0x995e7831 	Query	thread_id=35	exec_time=0	error_code=0
SET TIMESTAMP=1780620731/*!*/;
BEGIN
/*!*/;
# at 12905
#260605  8:52:11 server id 1  end_log_pos 12973 CRC32 0xc60263ce 	Table_map: `udicon`.`backup` mapped to number 87
# has_generated_invisible_primary_key=0
# at 12973
#260605  8:52:11 server id 1  end_log_pos 13060 CRC32 0x8330c71d 	Write_rows: table id 87 flags: STMT_END_F
### INSERT INTO `udicon`.`backup`
### SET
###   @1=134
###   @2=1
###   @3='2026-06-05 08:52:11'
###   @4='backup_2026-06-05T00-52-11-213Z.sql'
###   @5=1
# at 13060
#260605  8:52:11 server id 1  end_log_pos 13091 CRC32 0xf8d1cffa 	Xid = 1956
COMMIT/*!*/;
# at 13091
#260605  8:52:12 server id 1  end_log_pos 13170 CRC32 0x2127cb2a 	Anonymous_GTID	last_committed=34	sequence_number=35	rbr_only=yes	original_committed_timestamp=1780620732910951	immediate_commit_timestamp=1780620732910951	transaction_length=350
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780620732910951 (2026-06-05 08:52:12.910951 China Standard Time)
# immediate_commit_timestamp=1780620732910951 (2026-06-05 08:52:12.910951 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780620732910951*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 13170
#260605  8:52:12 server id 1  end_log_pos 13255 CRC32 0x83d187c9 	Query	thread_id=35	exec_time=0	error_code=0
SET TIMESTAMP=1780620732/*!*/;
BEGIN
/*!*/;
# at 13255
#260605  8:52:12 server id 1  end_log_pos 13323 CRC32 0x2672d884 	Table_map: `udicon`.`backup` mapped to number 87
# has_generated_invisible_primary_key=0
# at 13323
#260605  8:52:12 server id 1  end_log_pos 13410 CRC32 0xe8bfabf5 	Write_rows: table id 87 flags: STMT_END_F
### INSERT INTO `udicon`.`backup`
### SET
###   @1=135
###   @2=1
###   @3='2026-06-05 08:52:12'
###   @4='backup_2026-06-05T00-52-12-490Z.sql'
###   @5=1
# at 13410
#260605  8:52:12 server id 1  end_log_pos 13441 CRC32 0xfdf5c715 	Xid = 2179
COMMIT/*!*/;
# at 13441
#260605  8:52:17 server id 1  end_log_pos 13520 CRC32 0xae54462a 	Anonymous_GTID	last_committed=35	sequence_number=36	rbr_only=yes	original_committed_timestamp=1780620737216243	immediate_commit_timestamp=1780620737216243	transaction_length=342
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780620737216243 (2026-06-05 08:52:17.216243 China Standard Time)
# immediate_commit_timestamp=1780620737216243 (2026-06-05 08:52:17.216243 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780620737216243*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 13520
#260605  8:52:17 server id 1  end_log_pos 13597 CRC32 0x697080c0 	Query	thread_id=35	exec_time=0	error_code=0
SET TIMESTAMP=1780620737/*!*/;
BEGIN
/*!*/;
# at 13597
#260605  8:52:17 server id 1  end_log_pos 13665 CRC32 0x67258f28 	Table_map: `udicon`.`backup` mapped to number 87
# has_generated_invisible_primary_key=0
# at 13665
#260605  8:52:17 server id 1  end_log_pos 13752 CRC32 0x2c362efd 	Delete_rows: table id 87 flags: STMT_END_F
### DELETE FROM `udicon`.`backup`
### WHERE
###   @1=134
###   @2=1
###   @3='2026-06-05 08:52:11'
###   @4='backup_2026-06-05T00-52-11-213Z.sql'
###   @5=1
# at 13752
#260605  8:52:17 server id 1  end_log_pos 13783 CRC32 0x3a3b60bb 	Xid = 2182
COMMIT/*!*/;
# at 13783
#260605  9:30:00 server id 1  end_log_pos 13862 CRC32 0xa6c40a88 	Anonymous_GTID	last_committed=36	sequence_number=37	rbr_only=yes	original_committed_timestamp=1780623000368851	immediate_commit_timestamp=1780623000368851	transaction_length=362
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780623000368851 (2026-06-05 09:30:00.368851 China Standard Time)
# immediate_commit_timestamp=1780623000368851 (2026-06-05 09:30:00.368851 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780623000368851*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 13862
#260605  9:30:00 server id 1  end_log_pos 13947 CRC32 0x6380ba68 	Query	thread_id=35	exec_time=0	error_code=0
SET TIMESTAMP=1780623000/*!*/;
BEGIN
/*!*/;
# at 13947
#260605  9:30:00 server id 1  end_log_pos 14015 CRC32 0x4852519e 	Table_map: `udicon`.`backup` mapped to number 87
# has_generated_invisible_primary_key=0
# at 14015
#260605  9:30:00 server id 1  end_log_pos 14114 CRC32 0x976cb0f1 	Write_rows: table id 87 flags: STMT_END_F
### INSERT INTO `udicon`.`backup`
### SET
###   @1=136
###   @2=1
###   @3='2026-06-05 09:30:00'
###   @4='incremental_backup_2026-06-05T01-30-00-071Z.sql'
###   @5=3
# at 14114
#260605  9:30:00 server id 1  end_log_pos 14145 CRC32 0xabda9d98 	Xid = 2196
COMMIT/*!*/;
# at 14145
#260605 10:30:00 server id 1  end_log_pos 14224 CRC32 0xcadb0d72 	Anonymous_GTID	last_committed=37	sequence_number=38	rbr_only=yes	original_committed_timestamp=1780626600319020	immediate_commit_timestamp=1780626600319020	transaction_length=362
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780626600319020 (2026-06-05 10:30:00.319020 China Standard Time)
# immediate_commit_timestamp=1780626600319020 (2026-06-05 10:30:00.319020 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780626600319020*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 14224
#260605 10:30:00 server id 1  end_log_pos 14309 CRC32 0xc94365c2 	Query	thread_id=35	exec_time=0	error_code=0
SET TIMESTAMP=1780626600/*!*/;
BEGIN
/*!*/;
# at 14309
#260605 10:30:00 server id 1  end_log_pos 14377 CRC32 0xa43f8f67 	Table_map: `udicon`.`backup` mapped to number 87
# has_generated_invisible_primary_key=0
# at 14377
#260605 10:30:00 server id 1  end_log_pos 14476 CRC32 0x13a940a8 	Write_rows: table id 87 flags: STMT_END_F
### INSERT INTO `udicon`.`backup`
### SET
###   @1=137
###   @2=1
###   @3='2026-06-05 10:30:00'
###   @4='incremental_backup_2026-06-05T02-30-00-096Z.sql'
###   @5=3
# at 14476
#260605 10:30:00 server id 1  end_log_pos 14507 CRC32 0x4e931868 	Xid = 2198
COMMIT/*!*/;
# at 14507
#260605 11:30:00 server id 1  end_log_pos 14586 CRC32 0x9646c11e 	Anonymous_GTID	last_committed=38	sequence_number=39	rbr_only=yes	original_committed_timestamp=1780630200254870	immediate_commit_timestamp=1780630200254870	transaction_length=362
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780630200254870 (2026-06-05 11:30:00.254870 China Standard Time)
# immediate_commit_timestamp=1780630200254870 (2026-06-05 11:30:00.254870 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780630200254870*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 14586
#260605 11:30:00 server id 1  end_log_pos 14671 CRC32 0x8e32d9db 	Query	thread_id=35	exec_time=0	error_code=0
SET TIMESTAMP=1780630200/*!*/;
BEGIN
/*!*/;
# at 14671
#260605 11:30:00 server id 1  end_log_pos 14739 CRC32 0x8f6d4f78 	Table_map: `udicon`.`backup` mapped to number 87
# has_generated_invisible_primary_key=0
# at 14739
#260605 11:30:00 server id 1  end_log_pos 14838 CRC32 0x72382395 	Write_rows: table id 87 flags: STMT_END_F
### INSERT INTO `udicon`.`backup`
### SET
###   @1=138
###   @2=1
###   @3='2026-06-05 11:30:00'
###   @4='incremental_backup_2026-06-05T03-30-00-057Z.sql'
###   @5=3
# at 14838
#260605 11:30:00 server id 1  end_log_pos 14869 CRC32 0x588cbbc9 	Xid = 2200
COMMIT/*!*/;
# at 14869
#260605 15:33:24 server id 1  end_log_pos 14948 CRC32 0x7644bbd1 	Anonymous_GTID	last_committed=39	sequence_number=40	rbr_only=yes	original_committed_timestamp=1780644805009404	immediate_commit_timestamp=1780644805009404	transaction_length=355
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780644805009404 (2026-06-05 15:33:25.009404 China Standard Time)
# immediate_commit_timestamp=1780644805009404 (2026-06-05 15:33:25.009404 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780644805009404*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 14948
#260605 15:33:24 server id 1  end_log_pos 15033 CRC32 0x85c419a8 	Query	thread_id=39	exec_time=1	error_code=0
SET TIMESTAMP=1780644804/*!*/;
BEGIN
/*!*/;
# at 15033
#260605 15:33:24 server id 1  end_log_pos 15107 CRC32 0x6ef16448 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 15107
#260605 15:33:24 server id 1  end_log_pos 15193 CRC32 0xed124e9f 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1071
###   @2=1
###   @3='Login'
###   @4='Test Admin logged in as Admin'
###   @5='2026-06-05 15:33:24'
# at 15193
#260605 15:33:24 server id 1  end_log_pos 15224 CRC32 0x4e391803 	Xid = 2204
COMMIT/*!*/;
# at 15224
#260605 15:33:54 server id 1  end_log_pos 15303 CRC32 0xb5e6c42a 	Anonymous_GTID	last_committed=40	sequence_number=41	rbr_only=yes	original_committed_timestamp=1780644834460698	immediate_commit_timestamp=1780644834460698	transaction_length=369
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780644834460698 (2026-06-05 15:33:54.460698 China Standard Time)
# immediate_commit_timestamp=1780644834460698 (2026-06-05 15:33:54.460698 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780644834460698*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 15303
#260605 15:33:54 server id 1  end_log_pos 15388 CRC32 0x4970aea4 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1780644834/*!*/;
BEGIN
/*!*/;
# at 15388
#260605 15:33:54 server id 1  end_log_pos 15462 CRC32 0x809ff94a 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 15462
#260605 15:33:54 server id 1  end_log_pos 15562 CRC32 0x2d3c14c5 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1072
###   @2=1
###   @3='Login'
###   @4='Test switched from Admin view to Sales view'
###   @5='2026-06-05 15:33:54'
# at 15562
#260605 15:33:54 server id 1  end_log_pos 15593 CRC32 0x742d4c1f 	Xid = 2234
COMMIT/*!*/;
# at 15593
#260605 15:35:55 server id 1  end_log_pos 15672 CRC32 0xb8480a36 	Anonymous_GTID	last_committed=41	sequence_number=42	rbr_only=yes	original_committed_timestamp=1780644955100413	immediate_commit_timestamp=1780644955100413	transaction_length=7583
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780644955100413 (2026-06-05 15:35:55.100413 China Standard Time)
# immediate_commit_timestamp=1780644955100413 (2026-06-05 15:35:55.100413 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780644955100413*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 15672
#260605 15:35:55 server id 1  end_log_pos 15759 CRC32 0xa356fb83 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1780644955/*!*/;
BEGIN
/*!*/;
# at 15759
#260605 15:35:55 server id 1  end_log_pos 15869 CRC32 0x8a2d96cc 	Table_map: `udicon`.`sales_transaction` mapped to number 95
# has_generated_invisible_primary_key=0
# at 15869
#260605 15:35:55 server id 1  end_log_pos 16018 CRC32 0x47ef8eac 	Write_rows: table id 95 flags: STMT_END_F
### INSERT INTO `udicon`.`sales_transaction`
### SET
###   @1=173
###   @2=1
###   @3='2026-06-05 15:35:55'
###   @4=19020.00
###   @5='E-wallet'
###   @6='UT-060526-0001'
###   @7=1
###   @8=0.00
###   @9=0.00
###   @10=19020.00
###   @11='121312313213'
###   @12='Eriii'
###   @13='097576564'
###   @14='Antipolo City'
###   @15=NULL
###   @16=0.00
# at 16018
#260605 15:35:55 server id 1  end_log_pos 16096 CRC32 0xb506bd22 	Table_map: `udicon`.`sales_item` mapped to number 98
# has_generated_invisible_primary_key=0
# at 16096
#260605 15:35:55 server id 1  end_log_pos 16900 CRC32 0x1c2b1237 	Write_rows: table id 98 flags: STMT_END_F
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=268
###   @2=173
###   @3=77
###   @4=1
###   @5=450.00
###   @6='Adjustable Wrench'
###   @7=450.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=269
###   @2=173
###   @3=157
###   @4=6
###   @5=900.00
###   @6='Boysen B600 Paint - Black - 1 Kilo'
###   @7=150.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=270
###   @2=173
###   @3=9
###   @4=5
###   @5=660.00
###   @6='cement'
###   @7=132.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=271
###   @2=173
###   @3=111
###   @4=2
###   @5=900.00
###   @6='Circuit Breaker'
###   @7=450.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=272
###   @2=173
###   @3=74
###   @4=1
###   @5=350.00
###   @6='Claw Hammer'
###   @7=350.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=273
###   @2=173
###   @3=81
###   @4=2
###   @5=6400.00
###   @6='Cordless Drill'
###   @7=3200.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=274
###   @2=173
###   @3=110
###   @4=1
###   @5=1450.00
###   @6='Electrical Wire 2.0mm'
###   @7=1450.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=275
###   @2=173
###   @3=116
###   @4=1
###   @5=650.00
###   @6='Faucet Stainless'
###   @7=650.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=276
###   @2=173
###   @3=75
###   @4=2
###   @5=240.00
###   @6='Flat Screwdriver'
###   @7=120.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=277
###   @2=173
###   @3=123
###   @4=1
###   @5=750.00
###   @6='GI Sheet'
###   @7=750.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=278
###   @2=173
###   @3=196
###   @4=1
###   @5=120.00
###   @6='LED Bulb  - 24W'
###   @7=120.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=279
###   @2=173
###   @3=93
###   @4=1
###   @5=1450.00
###   @6='Marine Plywood'
###   @7=1450.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=280
###   @2=173
###   @3=95
###   @4=1
###   @5=420.00
###   @6='Metal Roof Ridge'
###   @7=420.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=281
###   @2=173
###   @3=170
###   @4=16
###   @5=240.00
###   @6='Nail - 4 inch'
###   @7=15.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=282
###   @2=173
###   @3=106
###   @4=1
###   @5=760.00
###   @6='Primer Gray'
###   @7=760.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=283
###   @2=173
###   @3=186
###   @4=2
###   @5=80.00
###   @6='Safety Gloves - Large'
###   @7=40.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=284
###   @2=173
###   @3=117
###   @4=1
###   @5=3200.00
###   @6='Toilet Bowl'
###   @7=3200.00
###   @8=1
# at 16900
#260605 15:35:55 server id 1  end_log_pos 16991 CRC32 0xca8d1de0 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 16991
#260605 15:35:55 server id 1  end_log_pos 17255 CRC32 0x460f60a7 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=77
###   @2='Adjustable Wrench'
###   @3='200000000004'
###   @4='Tools'
###   @5=54
###   @6=400.00
###   @7=450.00
###   @8='Ingco'
###   @9='Adjustable steel wrench'
###   @10='images/wrench.jpg'
###   @11=1
###   @12=10
###   @13=NULL
### SET
###   @1=77
###   @2='Adjustable Wrench'
###   @3='200000000004'
###   @4='Tools'
###   @5=53
###   @6=400.00
###   @7=450.00
###   @8='Ingco'
###   @9='Adjustable steel wrench'
###   @10='images/wrench.jpg'
###   @11=1
###   @12=10
###   @13=NULL
# at 17255
#260605 15:35:55 server id 1  end_log_pos 17346 CRC32 0x72f83338 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 17346
#260605 15:35:55 server id 1  end_log_pos 17780 CRC32 0xc703319a 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=157
###   @2='Boysen B600 Paint - Black - 1 Kilo'
###   @3='527591125902'
###   @4='Paints'
###   @5=23
###   @6=120.00
###   @7=150.00
###   @8='Boysen'
###   @9=NULL
###   @10='/uploads/prod-1780280062165-816482018.jpg'
###   @11=1
###   @12=10
###   @13='[{"name":"Option 1","values":[]},{"name":"Option 2","values":[]}]'
### SET
###   @1=157
###   @2='Boysen B600 Paint - Black - 1 Kilo'
###   @3='527591125902'
###   @4='Paints'
###   @5=17
###   @6=120.00
###   @7=150.00
###   @8='Boysen'
###   @9=NULL
###   @10='/uploads/prod-1780280062165-816482018.jpg'
###   @11=1
###   @12=10
###   @13='[{"name":"Option 1","values":[]},{"name":"Option 2","values":[]}]'
# at 17780
#260605 15:35:55 server id 1  end_log_pos 17871 CRC32 0xb4eb8ab6 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 17871
#260605 15:35:55 server id 1  end_log_pos 18035 CRC32 0x0b38bb08 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=9
###   @2='cement'
###   @3='539883117643'
###   @4='Cement'
###   @5=54
###   @6=105.00
###   @7=132.00
###   @8='afsdf'
###   @9='da'
###   @10=NULL
###   @11=1
###   @12=10
###   @13=NULL
### SET
###   @1=9
###   @2='cement'
###   @3='539883117643'
###   @4='Cement'
###   @5=49
###   @6=105.00
###   @7=132.00
###   @8='afsdf'
###   @9='da'
###   @10=NULL
###   @11=1
###   @12=10
###   @13=NULL
# at 18035
#260605 15:35:55 server id 1  end_log_pos 18126 CRC32 0x908189be 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 18126
#260605 15:35:55 server id 1  end_log_pos 18398 CRC32 0xaa1c744c 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=111
###   @2='Circuit Breaker'
###   @3='200000000038'
###   @4='Electrical'
###   @5=50
###   @6=450.00
###   @7=450.00
###   @8='Panasonic'
###   @9='20A circuit breaker'
###   @10='images/breaker.jpg'
###   @11=1
###   @12=10
###   @13=NULL
### SET
###   @1=111
###   @2='Circuit Breaker'
###   @3='200000000038'
###   @4='Electrical'
###   @5=48
###   @6=450.00
###   @7=450.00
###   @8='Panasonic'
###   @9='20A circuit breaker'
###   @10='images/breaker.jpg'
###   @11=1
###   @12=10
###   @13=NULL
# at 18398
#260605 15:35:55 server id 1  end_log_pos 18489 CRC32 0x4627cac2 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 18489
#260605 15:35:55 server id 1  end_log_pos 18743 CRC32 0xa0245255 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=74
###   @2='Claw Hammer'
###   @3='200000000001'
###   @4='Tools'
###   @5=65
###   @6=300.00
###   @7=350.00
###   @8='Stanley'
###   @9='Heavy duty claw hammer'
###   @10='images/hammer.jpg'
###   @11=1
###   @12=10
###   @13=NULL
### SET
###   @1=74
###   @2='Claw Hammer'
###   @3='200000000001'
###   @4='Tools'
###   @5=64
###   @6=300.00
###   @7=350.00
###   @8='Stanley'
###   @9='Heavy duty claw hammer'
###   @10='images/hammer.jpg'
###   @11=1
###   @12=10
###   @13=NULL
# at 18743
#260605 15:35:55 server id 1  end_log_pos 18834 CRC32 0xea8ac78a 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 18834
#260605 15:35:55 server id 1  end_log_pos 19100 CRC32 0xc7073526 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=81
###   @2='Cordless Drill'
###   @3='200000000008'
###   @4='Tools'
###   @5=25
###   @6=2900.00
###   @7=3200.00
###   @8='Makita'
###   @9='Rechargeable cordless drill'
###   @10='images/drill.jpg'
###   @11=1
###   @12=5
###   @13=NULL
### SET
###   @1=81
###   @2='Cordless Drill'
###   @3='200000000008'
###   @4='Tools'
###   @5=23
###   @6=2900.00
###   @7=3200.00
###   @8='Makita'
###   @9='Rechargeable cordless drill'
###   @10='images/drill.jpg'
###   @11=1
###   @12=5
###   @13=NULL
# at 19100
#260605 15:35:55 server id 1  end_log_pos 19191 CRC32 0xb0eb907e 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 19191
#260605 15:35:55 server id 1  end_log_pos 19481 CRC32 0xc6cb6643 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=110
###   @2='Electrical Wire 2.0mm'
###   @3='200000000037'
###   @4='Electrical'
###   @5=76
###   @6=1350.00
###   @7=1450.00
###   @8='Phelps Dodge'
###   @9='Copper electrical wire'
###   @10='images/wire.jpg'
###   @11=1
###   @12=10
###   @13=NULL
### SET
###   @1=110
###   @2='Electrical Wire 2.0mm'
###   @3='200000000037'
###   @4='Electrical'
###   @5=75
###   @6=1350.00
###   @7=1450.00
###   @8='Phelps Dodge'
###   @9='Copper electrical wire'
###   @10='images/wire.jpg'
###   @11=1
###   @12=10
###   @13=NULL
# at 19481
#260605 15:35:55 server id 1  end_log_pos 19572 CRC32 0x64965932 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 19572
#260605 15:35:55 server id 1  end_log_pos 19838 CRC32 0x735260c9 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=116
###   @2='Faucet Stainless'
###   @3='200000000043'
###   @4='Plumbing'
###   @5=15
###   @6=580.00
###   @7=650.00
###   @8='Grohe'
###   @9='Stainless steel faucet'
###   @10='images/faucet.jpg'
###   @11=1
###   @12=8
###   @13=NULL
### SET
###   @1=116
###   @2='Faucet Stainless'
###   @3='200000000043'
###   @4='Plumbing'
###   @5=14
###   @6=580.00
###   @7=650.00
###   @8='Grohe'
###   @9='Stainless steel faucet'
###   @10='images/faucet.jpg'
###   @11=1
###   @12=8
###   @13=NULL
# at 19838
#260605 15:35:55 server id 1  end_log_pos 19929 CRC32 0xf6081963 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 19929
#260605 15:35:55 server id 1  end_log_pos 20207 CRC32 0x682c35b4 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=75
###   @2='Flat Screwdriver'
###   @3='200000000002'
###   @4='Tools'
###   @5=80
###   @6=90.00
###   @7=120.00
###   @8='Bosch'
###   @9='Flat head screwdriver'
###   @10='images/screwdriver_flat.jpg'
###   @11=1
###   @12=15
###   @13=NULL
### SET
###   @1=75
###   @2='Flat Screwdriver'
###   @3='200000000002'
###   @4='Tools'
###   @5=78
###   @6=90.00
###   @7=120.00
###   @8='Bosch'
###   @9='Flat head screwdriver'
###   @10='images/screwdriver_flat.jpg'
###   @11=1
###   @12=15
###   @13=NULL
# at 20207
#260605 15:35:55 server id 1  end_log_pos 20298 CRC32 0xe4d08b2d 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 20298
#260605 15:35:55 server id 1  end_log_pos 20548 CRC32 0xbe174228 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=123
###   @2='GI Sheet'
###   @3='200000000050'
###   @4='Steel'
###   @5=20
###   @6=620.00
###   @7=750.00
###   @8='DN Steel'
###   @9='Galvanized iron sheet'
###   @10='images/gisheet.jpg'
###   @11=1
###   @12=19
###   @13=NULL
### SET
###   @1=123
###   @2='GI Sheet'
###   @3='200000000050'
###   @4='Steel'
###   @5=19
###   @6=620.00
###   @7=750.00
###   @8='DN Steel'
###   @9='Galvanized iron sheet'
###   @10='images/gisheet.jpg'
###   @11=1
###   @12=19
###   @13=NULL
# at 20548
#260605 15:35:55 server id 1  end_log_pos 20639 CRC32 0x29f5ed30 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 20639
#260605 15:35:55 server id 1  end_log_pos 21019 CRC32 0x45533326 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=196
###   @2='LED Bulb  - 24W'
###   @3='741516032980'
###   @4='Electrical'
###   @5=89
###   @6=95.00
###   @7=120.00
###   @8='Firefly'
###   @9='Energy saving bulb '
###   @10='/uploads/prod-1780278243046-966712377.jfif'
###   @11=1
###   @12=20
###   @13='[{"name":"Watts","values":[]}]'
### SET
###   @1=196
###   @2='LED Bulb  - 24W'
###   @3='741516032980'
###   @4='Electrical'
###   @5=88
###   @6=95.00
###   @7=120.00
###   @8='Firefly'
###   @9='Energy saving bulb '
###   @10='/uploads/prod-1780278243046-966712377.jfif'
###   @11=1
###   @12=20
###   @13='[{"name":"Watts","values":[]}]'
# at 21019
#260605 15:35:55 server id 1  end_log_pos 21110 CRC32 0x83d852ff 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 21110
#260605 15:35:55 server id 1  end_log_pos 21384 CRC32 0xd42571d4 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=93
###   @2='Marine Plywood'
###   @3='200000000020'
###   @4='Wood'
###   @5=40
###   @6=1350.00
###   @7=1450.00
###   @8='Santa Clara'
###   @9='Water resistant plywood'
###   @10='images/marineply.jpg'
###   @11=1
###   @12=8
###   @13=NULL
### SET
###   @1=93
###   @2='Marine Plywood'
###   @3='200000000020'
###   @4='Wood'
###   @5=39
###   @6=1350.00
###   @7=1450.00
###   @8='Santa Clara'
###   @9='Water resistant plywood'
###   @10='images/marineply.jpg'
###   @11=1
###   @12=8
###   @13=NULL
# at 21384
#260605 15:35:55 server id 1  end_log_pos 21475 CRC32 0x6c166ffb 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 21475
#260605 15:35:55 server id 1  end_log_pos 21729 CRC32 0x71ec57f6 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=95
###   @2='Metal Roof Ridge'
###   @3='200000000022'
###   @4='Roofing'
###   @5=38
###   @6=380.00
###   @7=420.00
###   @8='ColorRoof'
###   @9='Roof ridge cap'
###   @10='images/ridge.jpg'
###   @11=1
###   @12=8
###   @13=NULL
### SET
###   @1=95
###   @2='Metal Roof Ridge'
###   @3='200000000022'
###   @4='Roofing'
###   @5=37
###   @6=380.00
###   @7=420.00
###   @8='ColorRoof'
###   @9='Roof ridge cap'
###   @10='images/ridge.jpg'
###   @11=1
###   @12=8
###   @13=NULL
# at 21729
#260605 15:35:55 server id 1  end_log_pos 21820 CRC32 0xbb308f1e 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 21820
#260605 15:35:55 server id 1  end_log_pos 22046 CRC32 0x26ad7057 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=170
###   @2='Nail - 4 inch'
###   @3='612763069256'
###   @4='Tools'
###   @5=21
###   @6=10.00
###   @7=15.00
###   @8=NULL
###   @9=NULL
###   @10=NULL
###   @11=1
###   @12=10
###   @13='[{"name":"Option 1","values":[]}]'
### SET
###   @1=170
###   @2='Nail - 4 inch'
###   @3='612763069256'
###   @4='Tools'
###   @5=5
###   @6=10.00
###   @7=15.00
###   @8=NULL
###   @9=NULL
###   @10=NULL
###   @11=1
###   @12=10
###   @13='[{"name":"Option 1","values":[]}]'
# at 22046
#260605 15:35:55 server id 1  end_log_pos 22137 CRC32 0x64cc91db 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 22137
#260605 15:35:55 server id 1  end_log_pos 22383 CRC32 0xa7fd6f4a 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=106
###   @2='Primer Gray'
###   @3='200000000033'
###   @4='Paints'
###   @5=35
###   @6=700.00
###   @7=760.00
###   @8='Boysen'
###   @9='Metal primer paint'
###   @10='images/primer.jpg'
###   @11=1
###   @12=8
###   @13=NULL
### SET
###   @1=106
###   @2='Primer Gray'
###   @3='200000000033'
###   @4='Paints'
###   @5=34
###   @6=700.00
###   @7=760.00
###   @8='Boysen'
###   @9='Metal primer paint'
###   @10='images/primer.jpg'
###   @11=1
###   @12=8
###   @13=NULL
# at 22383
#260605 15:35:55 server id 1  end_log_pos 22474 CRC32 0x30aca8f7 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 22474
#260605 15:35:55 server id 1  end_log_pos 22808 CRC32 0x32bae1b5 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=186
###   @2='Safety Gloves - Large'
###   @3='570432048592'
###   @4='Safety & PPE'
###   @5=25
###   @6=30.00
###   @7=40.00
###   @8=NULL
###   @9=NULL
###   @10='/uploads/prod-1780279906057-570233654.png'
###   @11=1
###   @12=10
###   @13='[{"name":"Size","values":[]}]'
### SET
###   @1=186
###   @2='Safety Gloves - Large'
###   @3='570432048592'
###   @4='Safety & PPE'
###   @5=23
###   @6=30.00
###   @7=40.00
###   @8=NULL
###   @9=NULL
###   @10='/uploads/prod-1780279906057-570233654.png'
###   @11=1
###   @12=10
###   @13='[{"name":"Size","values":[]}]'
# at 22808
#260605 15:35:55 server id 1  end_log_pos 22899 CRC32 0x5fc9216d 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 22899
#260605 15:35:55 server id 1  end_log_pos 23145 CRC32 0xb3caf0a9 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=117
###   @2='Toilet Bowl'
###   @3='200000000044'
###   @4='Plumbing'
###   @5=20
###   @6=2900.00
###   @7=3200.00
###   @8='HCG'
###   @9='Ceramic toilet bowl'
###   @10='images/toilet.jpg'
###   @11=1
###   @12=5
###   @13=NULL
### SET
###   @1=117
###   @2='Toilet Bowl'
###   @3='200000000044'
###   @4='Plumbing'
###   @5=19
###   @6=2900.00
###   @7=3200.00
###   @8='HCG'
###   @9='Ceramic toilet bowl'
###   @10='images/toilet.jpg'
###   @11=1
###   @12=5
###   @13=NULL
# at 23145
#260605 15:35:55 server id 1  end_log_pos 23176 CRC32 0x5a03cfe2 	Xid = 2283
COMMIT/*!*/;
# at 23176
#260605 15:35:55 server id 1  end_log_pos 23255 CRC32 0xac5d31cf 	Anonymous_GTID	last_committed=42	sequence_number=43	rbr_only=yes	original_committed_timestamp=1780644955108203	immediate_commit_timestamp=1780644955108203	transaction_length=403
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780644955108203 (2026-06-05 15:35:55.108203 China Standard Time)
# immediate_commit_timestamp=1780644955108203 (2026-06-05 15:35:55.108203 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780644955108203*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 23255
#260605 15:35:55 server id 1  end_log_pos 23340 CRC32 0x3431ebdb 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1780644955/*!*/;
BEGIN
/*!*/;
# at 23340
#260605 15:35:55 server id 1  end_log_pos 23432 CRC32 0xf14d0104 	Table_map: `udicon`.`payment_log` mapped to number 99
# has_generated_invisible_primary_key=0
# at 23432
#260605 15:35:55 server id 1  end_log_pos 23548 CRC32 0xe9a6fe66 	Write_rows: table id 99 flags: STMT_END_F
### INSERT INTO `udicon`.`payment_log`
### SET
###   @1=152
###   @2='UT-060526-0001'
###   @3=NULL
###   @4=0.00
###   @5=0.00
###   @6=19020.00
###   @7='2026-06-05 15:35:55'
###   @8='E-wallet'
###   @9='121312313213'
###   @10='Paid'
###   @11='Initial'
# at 23548
#260605 15:35:55 server id 1  end_log_pos 23579 CRC32 0x1b8bd4e9 	Xid = 2304
COMMIT/*!*/;
# at 23579
#260605 15:35:55 server id 1  end_log_pos 23658 CRC32 0xaff0ad27 	Anonymous_GTID	last_committed=43	sequence_number=44	rbr_only=yes	original_committed_timestamp=1780644955117902	immediate_commit_timestamp=1780644955117902	transaction_length=384
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780644955117902 (2026-06-05 15:35:55.117902 China Standard Time)
# immediate_commit_timestamp=1780644955117902 (2026-06-05 15:35:55.117902 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780644955117902*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 23658
#260605 15:35:55 server id 1  end_log_pos 23743 CRC32 0x2c9c9dfe 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1780644955/*!*/;
BEGIN
/*!*/;
# at 23743
#260605 15:35:55 server id 1  end_log_pos 23817 CRC32 0x929293c1 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 23817
#260605 15:35:55 server id 1  end_log_pos 23932 CRC32 0x9c11e40b 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1073
###   @2=1
###   @3='Sale'
###   @4='Transaction UT-060526-0001 - Amount: ₱19020.00 - E-wallet'
###   @5='2026-06-05 15:35:55'
# at 23932
#260605 15:35:55 server id 1  end_log_pos 23963 CRC32 0x89c4e210 	Xid = 2305
COMMIT/*!*/;
# at 23963
#260605 15:53:31 server id 1  end_log_pos 24042 CRC32 0x8128f6b1 	Anonymous_GTID	last_committed=44	sequence_number=45	rbr_only=yes	original_committed_timestamp=1780646011175232	immediate_commit_timestamp=1780646011175232	transaction_length=355
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780646011175232 (2026-06-05 15:53:31.175232 China Standard Time)
# immediate_commit_timestamp=1780646011175232 (2026-06-05 15:53:31.175232 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780646011175232*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 24042
#260605 15:53:31 server id 1  end_log_pos 24127 CRC32 0x6841fcca 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1780646011/*!*/;
BEGIN
/*!*/;
# at 24127
#260605 15:53:31 server id 1  end_log_pos 24201 CRC32 0xdd01a2ec 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 24201
#260605 15:53:31 server id 1  end_log_pos 24287 CRC32 0x8cc52b9e 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1074
###   @2=1
###   @3='Login'
###   @4='Test Admin logged in as Admin'
###   @5='2026-06-05 15:53:31'
# at 24287
#260605 15:53:31 server id 1  end_log_pos 24318 CRC32 0xc8f6c845 	Xid = 2309
COMMIT/*!*/;
# at 24318
#260605 15:53:35 server id 1  end_log_pos 24397 CRC32 0xdbe846fe 	Anonymous_GTID	last_committed=45	sequence_number=46	rbr_only=yes	original_committed_timestamp=1780646015375337	immediate_commit_timestamp=1780646015375337	transaction_length=369
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780646015375337 (2026-06-05 15:53:35.375337 China Standard Time)
# immediate_commit_timestamp=1780646015375337 (2026-06-05 15:53:35.375337 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780646015375337*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 24397
#260605 15:53:35 server id 1  end_log_pos 24482 CRC32 0x9f0e4f2f 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1780646015/*!*/;
BEGIN
/*!*/;
# at 24482
#260605 15:53:35 server id 1  end_log_pos 24556 CRC32 0x3bc50b65 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 24556
#260605 15:53:35 server id 1  end_log_pos 24656 CRC32 0xdeff43b5 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1075
###   @2=1
###   @3='Login'
###   @4='Test switched from Admin view to Sales view'
###   @5='2026-06-05 15:53:35'
# at 24656
#260605 15:53:35 server id 1  end_log_pos 24687 CRC32 0x18bd4f28 	Xid = 2320
COMMIT/*!*/;
# at 24687
#260605 16:30:00 server id 1  end_log_pos 24766 CRC32 0x1698f73b 	Anonymous_GTID	last_committed=46	sequence_number=47	rbr_only=yes	original_committed_timestamp=1780648200708259	immediate_commit_timestamp=1780648200708259	transaction_length=362
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780648200708259 (2026-06-05 16:30:00.708259 China Standard Time)
# immediate_commit_timestamp=1780648200708259 (2026-06-05 16:30:00.708259 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780648200708259*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 24766
#260605 16:30:00 server id 1  end_log_pos 24851 CRC32 0x990d9062 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1780648200/*!*/;
BEGIN
/*!*/;
# at 24851
#260605 16:30:00 server id 1  end_log_pos 24919 CRC32 0xbbfa60ce 	Table_map: `udicon`.`backup` mapped to number 87
# has_generated_invisible_primary_key=0
# at 24919
#260605 16:30:00 server id 1  end_log_pos 25018 CRC32 0x1e0e2edb 	Write_rows: table id 87 flags: STMT_END_F
### INSERT INTO `udicon`.`backup`
### SET
###   @1=139
###   @2=1
###   @3='2026-06-05 16:30:00'
###   @4='incremental_backup_2026-06-05T08-30-00-066Z.sql'
###   @5=3
# at 25018
#260605 16:30:00 server id 1  end_log_pos 25049 CRC32 0x623cf845 	Xid = 2332
COMMIT/*!*/;
# at 25049
#260606  6:59:09 server id 1  end_log_pos 25128 CRC32 0x50b11c94 	Anonymous_GTID	last_committed=47	sequence_number=48	rbr_only=yes	original_committed_timestamp=1780700349252374	immediate_commit_timestamp=1780700349252374	transaction_length=355
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780700349252374 (2026-06-06 06:59:09.252374 China Standard Time)
# immediate_commit_timestamp=1780700349252374 (2026-06-06 06:59:09.252374 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780700349252374*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 25128
#260606  6:59:09 server id 1  end_log_pos 25213 CRC32 0x629441f1 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780700349/*!*/;
BEGIN
/*!*/;
# at 25213
#260606  6:59:09 server id 1  end_log_pos 25287 CRC32 0x644c055f 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 25287
#260606  6:59:09 server id 1  end_log_pos 25373 CRC32 0x9a736bcd 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1076
###   @2=1
###   @3='Login'
###   @4='Test Admin logged in as Admin'
###   @5='2026-06-06 06:59:09'
# at 25373
#260606  6:59:09 server id 1  end_log_pos 25404 CRC32 0xc34e4f15 	Xid = 2675
COMMIT/*!*/;
# at 25404
#260606  6:59:09 server id 1  end_log_pos 25483 CRC32 0xf1a4d29c 	Anonymous_GTID	last_committed=48	sequence_number=49	rbr_only=yes	original_committed_timestamp=1780700349325569	immediate_commit_timestamp=1780700349325569	transaction_length=355
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780700349325569 (2026-06-06 06:59:09.325569 China Standard Time)
# immediate_commit_timestamp=1780700349325569 (2026-06-06 06:59:09.325569 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780700349325569*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 25483
#260606  6:59:09 server id 1  end_log_pos 25568 CRC32 0xf9adf999 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780700349/*!*/;
BEGIN
/*!*/;
# at 25568
#260606  6:59:09 server id 1  end_log_pos 25642 CRC32 0x4aaea9f5 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 25642
#260606  6:59:09 server id 1  end_log_pos 25728 CRC32 0xd84cf463 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1077
###   @2=1
###   @3='Login'
###   @4='Test Admin logged in as Admin'
###   @5='2026-06-06 06:59:09'
# at 25728
#260606  6:59:09 server id 1  end_log_pos 25759 CRC32 0x4a24f22b 	Xid = 2677
COMMIT/*!*/;
# at 25759
#260606  7:02:37 server id 1  end_log_pos 25838 CRC32 0xd62b5a60 	Anonymous_GTID	last_committed=49	sequence_number=50	rbr_only=yes	original_committed_timestamp=1780700557158416	immediate_commit_timestamp=1780700557158416	transaction_length=369
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780700557158416 (2026-06-06 07:02:37.158416 China Standard Time)
# immediate_commit_timestamp=1780700557158416 (2026-06-06 07:02:37.158416 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780700557158416*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 25838
#260606  7:02:37 server id 1  end_log_pos 25923 CRC32 0x3b592a80 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780700557/*!*/;
BEGIN
/*!*/;
# at 25923
#260606  7:02:37 server id 1  end_log_pos 25997 CRC32 0xe88c0a73 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 25997
#260606  7:02:37 server id 1  end_log_pos 26097 CRC32 0x879f88d7 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1078
###   @2=1
###   @3='Login'
###   @4='Test switched from Admin view to Sales view'
###   @5='2026-06-06 07:02:37'
# at 26097
#260606  7:02:37 server id 1  end_log_pos 26128 CRC32 0x4d945d32 	Xid = 2688
COMMIT/*!*/;
# at 26128
#260606  7:05:27 server id 1  end_log_pos 26207 CRC32 0xee241248 	Anonymous_GTID	last_committed=50	sequence_number=51	rbr_only=yes	original_committed_timestamp=1780700727921005	immediate_commit_timestamp=1780700727921005	transaction_length=4240
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780700727921005 (2026-06-06 07:05:27.921005 China Standard Time)
# immediate_commit_timestamp=1780700727921005 (2026-06-06 07:05:27.921005 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780700727921005*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 26207
#260606  7:05:27 server id 1  end_log_pos 26294 CRC32 0x9e89c193 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780700727/*!*/;
BEGIN
/*!*/;
# at 26294
#260606  7:05:27 server id 1  end_log_pos 26404 CRC32 0x4c3c3950 	Table_map: `udicon`.`sales_transaction` mapped to number 95
# has_generated_invisible_primary_key=0
# at 26404
#260606  7:05:27 server id 1  end_log_pos 26543 CRC32 0xb08529d4 	Write_rows: table id 95 flags: STMT_END_F
### INSERT INTO `udicon`.`sales_transaction`
### SET
###   @1=174
###   @2=1
###   @3='2026-06-06 07:05:27'
###   @4=12819.00
###   @5='Pay Later'
###   @6='UT-060626-0001'
###   @7=2
###   @8=0.00
###   @9=0.00
###   @10=0.00
###   @11=NULL
###   @12='Rachelle'
###   @13='09632124444'
###   @14='Marikina'
###   @15='2026:07:18'
###   @16=0.00
# at 26543
#260606  7:05:27 server id 1  end_log_pos 26621 CRC32 0xc8cca284 	Table_map: `udicon`.`sales_item` mapped to number 98
# has_generated_invisible_primary_key=0
# at 26621
#260606  7:05:27 server id 1  end_log_pos 27007 CRC32 0x3349e32e 	Write_rows: table id 98 flags: STMT_END_F
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=285
###   @2=174
###   @3=162
###   @4=2
###   @5=300.00
###   @6='Boysen B600 Paint - Red - 2 Kilo'
###   @7=150.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=286
###   @2=174
###   @3=101
###   @4=2
###   @5=24.00
###   @6='Clay Brick'
###   @7=12.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=287
###   @2=174
###   @3=123
###   @4=1
###   @5=750.00
###   @6='GI Sheet'
###   @7=750.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=288
###   @2=174
###   @3=191
###   @4=5
###   @5=600.00
###   @6='LED Bulb  - 20W'
###   @7=120.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=289
###   @2=174
###   @3=78
###   @4=2
###   @5=360.00
###   @6='Measuring Tape'
###   @7=180.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=290
###   @2=174
###   @3=174
###   @4=17
###   @5=425.00
###   @6='Nut - 1 inch'
###   @7=25.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=291
###   @2=174
###   @3=119
###   @4=20
###   @5=6400.00
###   @6='Steel Bar 10mm'
###   @7=320.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=292
###   @2=174
###   @3=9
###   @4=30
###   @5=3960.00
###   @6='cement'
###   @7=132.00
###   @8=1
# at 27007
#260606  7:05:27 server id 1  end_log_pos 27099 CRC32 0xe2d6ee07 	Table_map: `udicon`.`payment_log` mapped to number 99
# has_generated_invisible_primary_key=0
# at 27099
#260606  7:05:27 server id 1  end_log_pos 27327 CRC32 0x47bd0016 	Write_rows: table id 99 flags: STMT_END_F
### INSERT INTO `udicon`.`payment_log`
### SET
###   @1=153
###   @2='UT-060626-0001'
###   @3='2026:06:20'
###   @4=4273.00
###   @5=0.00
###   @6=0.00
###   @7=NULL
###   @8=NULL
###   @9=NULL
###   @10='Scheduled'
###   @11='Installment'
### INSERT INTO `udicon`.`payment_log`
### SET
###   @1=154
###   @2='UT-060626-0001'
###   @3='2026:07:04'
###   @4=4273.00
###   @5=0.00
###   @6=0.00
###   @7=NULL
###   @8=NULL
###   @9=NULL
###   @10='Scheduled'
###   @11='Installment'
### INSERT INTO `udicon`.`payment_log`
### SET
###   @1=155
###   @2='UT-060626-0001'
###   @3='2026:07:18'
###   @4=4273.00
###   @5=0.00
###   @6=0.00
###   @7=NULL
###   @8=NULL
###   @9=NULL
###   @10='Scheduled'
###   @11='Installment'
# at 27327
#260606  7:05:27 server id 1  end_log_pos 27418 CRC32 0xc000cdd7 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 27418
#260606  7:05:27 server id 1  end_log_pos 27848 CRC32 0xdcc19be3 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=162
###   @2='Boysen B600 Paint - Red - 2 Kilo'
###   @3='564684199829'
###   @4='Paints'
###   @5=23
###   @6=120.00
###   @7=150.00
###   @8='Boysen'
###   @9=NULL
###   @10='/uploads/prod-1780280062165-816482018.jpg'
###   @11=1
###   @12=10
###   @13='[{"name":"Option 1","values":[]},{"name":"Option 2","values":[]}]'
### SET
###   @1=162
###   @2='Boysen B600 Paint - Red - 2 Kilo'
###   @3='564684199829'
###   @4='Paints'
###   @5=21
###   @6=120.00
###   @7=150.00
###   @8='Boysen'
###   @9=NULL
###   @10='/uploads/prod-1780280062165-816482018.jpg'
###   @11=1
###   @12=10
###   @13='[{"name":"Option 1","values":[]},{"name":"Option 2","values":[]}]'
# at 27848
#260606  7:05:27 server id 1  end_log_pos 27939 CRC32 0x0725933e 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 27939
#260606  7:05:27 server id 1  end_log_pos 28191 CRC32 0xb59a88f9 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=101
###   @2='Clay Brick'
###   @3='200000000028'
###   @4='Bricks'
###   @5=498
###   @6=9.00
###   @7=12.00
###   @8='Metro Brick'
###   @9='Red clay brick'
###   @10='images/claybrick.jpg'
###   @11=1
###   @12=100
###   @13=NULL
### SET
###   @1=101
###   @2='Clay Brick'
###   @3='200000000028'
###   @4='Bricks'
###   @5=496
###   @6=9.00
###   @7=12.00
###   @8='Metro Brick'
###   @9='Red clay brick'
###   @10='images/claybrick.jpg'
###   @11=1
###   @12=100
###   @13=NULL
# at 28191
#260606  7:05:27 server id 1  end_log_pos 28282 CRC32 0x0bc93071 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 28282
#260606  7:05:27 server id 1  end_log_pos 28532 CRC32 0x75ec0ea1 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=123
###   @2='GI Sheet'
###   @3='200000000050'
###   @4='Steel'
###   @5=19
###   @6=620.00
###   @7=750.00
###   @8='DN Steel'
###   @9='Galvanized iron sheet'
###   @10='images/gisheet.jpg'
###   @11=1
###   @12=19
###   @13=NULL
### SET
###   @1=123
###   @2='GI Sheet'
###   @3='200000000050'
###   @4='Steel'
###   @5=18
###   @6=620.00
###   @7=750.00
###   @8='DN Steel'
###   @9='Galvanized iron sheet'
###   @10='images/gisheet.jpg'
###   @11=1
###   @12=19
###   @13=NULL
# at 28532
#260606  7:05:27 server id 1  end_log_pos 28623 CRC32 0x619a4444 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 28623
#260606  7:05:27 server id 1  end_log_pos 29003 CRC32 0x97572e7a 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=191
###   @2='LED Bulb  - 20W'
###   @3='308006042986'
###   @4='Electrical'
###   @5=91
###   @6=95.00
###   @7=120.00
###   @8='Firefly'
###   @9='Energy saving bulb '
###   @10='/uploads/prod-1780278243046-966712377.jfif'
###   @11=1
###   @12=20
###   @13='[{"name":"Watts","values":[]}]'
### SET
###   @1=191
###   @2='LED Bulb  - 20W'
###   @3='308006042986'
###   @4='Electrical'
###   @5=86
###   @6=95.00
###   @7=120.00
###   @8='Firefly'
###   @9='Energy saving bulb '
###   @10='/uploads/prod-1780278243046-966712377.jfif'
###   @11=1
###   @12=20
###   @13='[{"name":"Watts","values":[]}]'
# at 29003
#260606  7:05:27 server id 1  end_log_pos 29094 CRC32 0x7618a4eb 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 29094
#260606  7:05:27 server id 1  end_log_pos 29350 CRC32 0xf4325ad6 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=78
###   @2='Measuring Tape'
###   @3='200000000005'
###   @4='Tools'
###   @5=70
###   @6=150.00
###   @7=180.00
###   @8='Stanley'
###   @9='5-meter measuring tape'
###   @10='images/tape.jpg'
###   @11=1
###   @12=10
###   @13=NULL
### SET
###   @1=78
###   @2='Measuring Tape'
###   @3='200000000005'
###   @4='Tools'
###   @5=68
###   @6=150.00
###   @7=180.00
###   @8='Stanley'
###   @9='5-meter measuring tape'
###   @10='images/tape.jpg'
###   @11=1
###   @12=10
###   @13=NULL
# at 29350
#260606  7:05:27 server id 1  end_log_pos 29441 CRC32 0x65f6d1c2 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 29441
#260606  7:05:27 server id 1  end_log_pos 29723 CRC32 0x8bf76afd 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=174
###   @2='Nut - 1 inch'
###   @3='910434005905'
###   @4='Tools'
###   @5=25
###   @6=20.00
###   @7=25.00
###   @8='afd'
###   @9=NULL
###   @10=NULL
###   @11=1
###   @12=10
###   @13='[{"name":"Size","values":[]},{"name":"Color","values":[]}]'
### SET
###   @1=174
###   @2='Nut - 1 inch'
###   @3='910434005905'
###   @4='Tools'
###   @5=8
###   @6=20.00
###   @7=25.00
###   @8='afd'
###   @9=NULL
###   @10=NULL
###   @11=1
###   @12=10
###   @13='[{"name":"Size","values":[]},{"name":"Color","values":[]}]'
# at 29723
#260606  7:05:27 server id 1  end_log_pos 29814 CRC32 0xecdc19c3 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 29814
#260606  7:05:27 server id 1  end_log_pos 30082 CRC32 0xf24a7c03 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=119
###   @2='Steel Bar 10mm'
###   @3='200000000046'
###   @4='Steel'
###   @5=120
###   @6=280.00
###   @7=320.00
###   @8='Pagasa'
###   @9='10mm reinforcing steel bar'
###   @10='images/steel10.jpg'
###   @11=1
###   @12=20
###   @13=NULL
### SET
###   @1=119
###   @2='Steel Bar 10mm'
###   @3='200000000046'
###   @4='Steel'
###   @5=100
###   @6=280.00
###   @7=320.00
###   @8='Pagasa'
###   @9='10mm reinforcing steel bar'
###   @10='images/steel10.jpg'
###   @11=1
###   @12=20
###   @13=NULL
# at 30082
#260606  7:05:27 server id 1  end_log_pos 30173 CRC32 0x4071148b 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 30173
#260606  7:05:27 server id 1  end_log_pos 30337 CRC32 0x344a9f72 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=9
###   @2='cement'
###   @3='539883117643'
###   @4='Cement'
###   @5=49
###   @6=105.00
###   @7=132.00
###   @8='afsdf'
###   @9='da'
###   @10=NULL
###   @11=1
###   @12=10
###   @13=NULL
### SET
###   @1=9
###   @2='cement'
###   @3='539883117643'
###   @4='Cement'
###   @5=19
###   @6=105.00
###   @7=132.00
###   @8='afsdf'
###   @9='da'
###   @10=NULL
###   @11=1
###   @12=10
###   @13=NULL
# at 30337
#260606  7:05:27 server id 1  end_log_pos 30368 CRC32 0xc69318a9 	Xid = 2776
COMMIT/*!*/;
# at 30368
#260606  7:05:27 server id 1  end_log_pos 30447 CRC32 0xb50bdc77 	Anonymous_GTID	last_committed=51	sequence_number=52	rbr_only=yes	original_committed_timestamp=1780700727927861	immediate_commit_timestamp=1780700727927861	transaction_length=385
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780700727927861 (2026-06-06 07:05:27.927861 China Standard Time)
# immediate_commit_timestamp=1780700727927861 (2026-06-06 07:05:27.927861 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780700727927861*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 30447
#260606  7:05:27 server id 1  end_log_pos 30532 CRC32 0xd81e4c65 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780700727/*!*/;
BEGIN
/*!*/;
# at 30532
#260606  7:05:27 server id 1  end_log_pos 30606 CRC32 0x43c75c2e 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 30606
#260606  7:05:27 server id 1  end_log_pos 30722 CRC32 0xfd981c3f 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1079
###   @2=1
###   @3='Sale'
###   @4='Transaction UT-060626-0001 - Amount: ₱12819.00 - Pay Later'
###   @5='2026-06-06 07:05:27'
# at 30722
#260606  7:05:27 server id 1  end_log_pos 30753 CRC32 0x3cc15c21 	Xid = 2789
COMMIT/*!*/;
# at 30753
#260606  7:09:58 server id 1  end_log_pos 30832 CRC32 0x6683904d 	Anonymous_GTID	last_committed=52	sequence_number=53	rbr_only=yes	original_committed_timestamp=1780700998188233	immediate_commit_timestamp=1780700998188233	transaction_length=2378
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780700998188233 (2026-06-06 07:09:58.188233 China Standard Time)
# immediate_commit_timestamp=1780700998188233 (2026-06-06 07:09:58.188233 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780700998188233*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 30832
#260606  7:09:58 server id 1  end_log_pos 30919 CRC32 0x0030c541 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780700998/*!*/;
BEGIN
/*!*/;
# at 30919
#260606  7:09:58 server id 1  end_log_pos 31029 CRC32 0x7fe8f946 	Table_map: `udicon`.`sales_transaction` mapped to number 95
# has_generated_invisible_primary_key=0
# at 31029
#260606  7:09:58 server id 1  end_log_pos 31168 CRC32 0x84d1f305 	Write_rows: table id 95 flags: STMT_END_F
### INSERT INTO `udicon`.`sales_transaction`
### SET
###   @1=175
###   @2=1
###   @3='2026-06-06 07:09:58'
###   @4=22875.00
###   @5='Pay Later'
###   @6='UT-060626-0002'
###   @7=2
###   @8=0.00
###   @9=0.00
###   @10=0.00
###   @11=NULL
###   @12='Eriii'
###   @13='097576564'
###   @14='Antipolo City'
###   @15='2026:09:06'
###   @16=0.00
# at 31168
#260606  7:09:58 server id 1  end_log_pos 31246 CRC32 0x218c0d24 	Table_map: `udicon`.`sales_item` mapped to number 98
# has_generated_invisible_primary_key=0
# at 31246
#260606  7:09:58 server id 1  end_log_pos 31439 CRC32 0xcd580bcd 	Write_rows: table id 98 flags: STMT_END_F
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=293
###   @2=175
###   @3=188
###   @4=20
###   @5=15600.00
###   @6='Angle Bar - 90'
###   @7=780.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=294
###   @2=175
###   @3=163
###   @4=20
###   @5=3000.00
###   @6='Boysen B600 Paint - Black - 2 Kilo'
###   @7=150.00
###   @8=1
### INSERT INTO `udicon`.`sales_item`
### SET
###   @1=295
###   @2=175
###   @3=84
###   @4=15
###   @5=4275.00
###   @6='Portland Cement 40kg'
###   @7=285.00
###   @8=1
# at 31439
#260606  7:09:58 server id 1  end_log_pos 31531 CRC32 0xa5eb1940 	Table_map: `udicon`.`payment_log` mapped to number 99
# has_generated_invisible_primary_key=0
# at 31531
#260606  7:09:58 server id 1  end_log_pos 31759 CRC32 0xb21a381d 	Write_rows: table id 99 flags: STMT_END_F
### INSERT INTO `udicon`.`payment_log`
### SET
###   @1=156
###   @2='UT-060626-0002'
###   @3='2026:07:06'
###   @4=7625.00
###   @5=0.00
###   @6=0.00
###   @7=NULL
###   @8=NULL
###   @9=NULL
###   @10='Scheduled'
###   @11='Installment'
### INSERT INTO `udicon`.`payment_log`
### SET
###   @1=157
###   @2='UT-060626-0002'
###   @3='2026:08:06'
###   @4=7625.00
###   @5=0.00
###   @6=0.00
###   @7=NULL
###   @8=NULL
###   @9=NULL
###   @10='Scheduled'
###   @11='Installment'
### INSERT INTO `udicon`.`payment_log`
### SET
###   @1=158
###   @2='UT-060626-0002'
###   @3='2026:09:06'
###   @4=7625.00
###   @5=0.00
###   @6=0.00
###   @7=NULL
###   @8=NULL
###   @9=NULL
###   @10='Scheduled'
###   @11='Installment'
# at 31759
#260606  7:09:58 server id 1  end_log_pos 31850 CRC32 0xaac1fb8a 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 31850
#260606  7:09:58 server id 1  end_log_pos 32210 CRC32 0xbf1cff4c 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=188
###   @2='Angle Bar - 90'
###   @3='701055001766'
###   @4='Steel'
###   @5=50
###   @6=700.00
###   @7=780.00
###   @8='Capitol'
###   @9='Steel angle bar'
###   @10='/uploads/prod-1780279963921-843396538.jfif'
###   @11=1
###   @12=10
###   @13='[{"name":"Angle","values":[]}]'
### SET
###   @1=188
###   @2='Angle Bar - 90'
###   @3='701055001766'
###   @4='Steel'
###   @5=30
###   @6=700.00
###   @7=780.00
###   @8='Capitol'
###   @9='Steel angle bar'
###   @10='/uploads/prod-1780279963921-843396538.jfif'
###   @11=1
###   @12=10
###   @13='[{"name":"Angle","values":[]}]'
# at 32210
#260606  7:09:58 server id 1  end_log_pos 32301 CRC32 0x971f7db6 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 32301
#260606  7:09:58 server id 1  end_log_pos 32735 CRC32 0xbfd87180 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=163
###   @2='Boysen B600 Paint - Black - 2 Kilo'
###   @3='564684227706'
###   @4='Paints'
###   @5=24
###   @6=120.00
###   @7=150.00
###   @8='Boysen'
###   @9=NULL
###   @10='/uploads/prod-1780280062165-816482018.jpg'
###   @11=1
###   @12=10
###   @13='[{"name":"Option 1","values":[]},{"name":"Option 2","values":[]}]'
### SET
###   @1=163
###   @2='Boysen B600 Paint - Black - 2 Kilo'
###   @3='564684227706'
###   @4='Paints'
###   @5=4
###   @6=120.00
###   @7=150.00
###   @8='Boysen'
###   @9=NULL
###   @10='/uploads/prod-1780280062165-816482018.jpg'
###   @11=1
###   @12=10
###   @13='[{"name":"Option 1","values":[]},{"name":"Option 2","values":[]}]'
# at 32735
#260606  7:09:58 server id 1  end_log_pos 32826 CRC32 0x974bad0b 	Table_map: `udicon`.`product` mapped to number 92
# has_generated_invisible_primary_key=0
# at 32826
#260606  7:09:58 server id 1  end_log_pos 33100 CRC32 0x0c4e20a6 	Update_rows: table id 92 flags: STMT_END_F
### UPDATE `udicon`.`product`
### WHERE
###   @1=84
###   @2='Portland Cement 40kg'
###   @3='200000000011'
###   @4='Cement'
###   @5=107
###   @6=250.00
###   @7=285.00
###   @8='Holcim'
###   @9='General purpose cement'
###   @10='images/cement1.jpg'
###   @11=1
###   @12=20
###   @13=NULL
### SET
###   @1=84
###   @2='Portland Cement 40kg'
###   @3='200000000011'
###   @4='Cement'
###   @5=92
###   @6=250.00
###   @7=285.00
###   @8='Holcim'
###   @9='General purpose cement'
###   @10='images/cement1.jpg'
###   @11=1
###   @12=20
###   @13=NULL
# at 33100
#260606  7:09:58 server id 1  end_log_pos 33131 CRC32 0x273a858f 	Xid = 2853
COMMIT/*!*/;
# at 33131
#260606  7:09:58 server id 1  end_log_pos 33210 CRC32 0xad666f4a 	Anonymous_GTID	last_committed=53	sequence_number=54	rbr_only=yes	original_committed_timestamp=1780700998193278	immediate_commit_timestamp=1780700998193278	transaction_length=385
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780700998193278 (2026-06-06 07:09:58.193278 China Standard Time)
# immediate_commit_timestamp=1780700998193278 (2026-06-06 07:09:58.193278 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780700998193278*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 33210
#260606  7:09:58 server id 1  end_log_pos 33295 CRC32 0xf15de85e 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780700998/*!*/;
BEGIN
/*!*/;
# at 33295
#260606  7:09:58 server id 1  end_log_pos 33369 CRC32 0x8a1249d9 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 33369
#260606  7:09:58 server id 1  end_log_pos 33485 CRC32 0xa4d71bfa 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1080
###   @2=1
###   @3='Sale'
###   @4='Transaction UT-060626-0002 - Amount: ₱22875.00 - Pay Later'
###   @5='2026-06-06 07:09:58'
# at 33485
#260606  7:09:58 server id 1  end_log_pos 33516 CRC32 0xafabb7d6 	Xid = 2861
COMMIT/*!*/;
# at 33516
#260606  7:13:17 server id 1  end_log_pos 33595 CRC32 0x8a23e664 	Anonymous_GTID	last_committed=54	sequence_number=55	rbr_only=yes	original_committed_timestamp=1780701197797601	immediate_commit_timestamp=1780701197797601	transaction_length=373
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780701197797601 (2026-06-06 07:13:17.797601 China Standard Time)
# immediate_commit_timestamp=1780701197797601 (2026-06-06 07:13:17.797601 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780701197797601*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 33595
#260606  7:13:17 server id 1  end_log_pos 33680 CRC32 0x0aae9dab 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780701197/*!*/;
BEGIN
/*!*/;
# at 33680
#260606  7:13:17 server id 1  end_log_pos 33754 CRC32 0x7d547b42 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 33754
#260606  7:13:17 server id 1  end_log_pos 33858 CRC32 0x4ac3fd11 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1081
###   @2=1
###   @3='Login'
###   @4='Test switched from Sales view to Inventory view'
###   @5='2026-06-06 07:13:17'
# at 33858
#260606  7:13:17 server id 1  end_log_pos 33889 CRC32 0x27bdf609 	Xid = 2863
COMMIT/*!*/;
# at 33889
#260606  7:13:24 server id 1  end_log_pos 33968 CRC32 0xe5b423a3 	Anonymous_GTID	last_committed=55	sequence_number=56	rbr_only=yes	original_committed_timestamp=1780701204423812	immediate_commit_timestamp=1780701204423812	transaction_length=373
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780701204423812 (2026-06-06 07:13:24.423812 China Standard Time)
# immediate_commit_timestamp=1780701204423812 (2026-06-06 07:13:24.423812 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780701204423812*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 33968
#260606  7:13:24 server id 1  end_log_pos 34053 CRC32 0xc53aa547 	Query	thread_id=44	exec_time=0	error_code=0
SET TIMESTAMP=1780701204/*!*/;
BEGIN
/*!*/;
# at 34053
#260606  7:13:24 server id 1  end_log_pos 34127 CRC32 0x9175c609 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 34127
#260606  7:13:24 server id 1  end_log_pos 34231 CRC32 0xa9ac0f56 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1082
###   @2=1
###   @3='Login'
###   @4='Test switched from Inventory view to Admin view'
###   @5='2026-06-06 07:13:24'
# at 34231
#260606  7:13:24 server id 1  end_log_pos 34262 CRC32 0x26cd6284 	Xid = 2870
COMMIT/*!*/;
# at 34262
#260606  7:24:53 server id 1  end_log_pos 34341 CRC32 0xb8370249 	Anonymous_GTID	last_committed=56	sequence_number=57	rbr_only=yes	original_committed_timestamp=1780701893718753	immediate_commit_timestamp=1780701893718753	transaction_length=355
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780701893718753 (2026-06-06 07:24:53.718753 China Standard Time)
# immediate_commit_timestamp=1780701893718753 (2026-06-06 07:24:53.718753 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780701893718753*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 34341
#260606  7:24:53 server id 1  end_log_pos 34426 CRC32 0x3a9087c8 	Query	thread_id=45	exec_time=0	error_code=0
SET TIMESTAMP=1780701893/*!*/;
BEGIN
/*!*/;
# at 34426
#260606  7:24:53 server id 1  end_log_pos 34500 CRC32 0x59fbafb3 	Table_map: `udicon`.`activity_log` mapped to number 91
# has_generated_invisible_primary_key=0
# at 34500
#260606  7:24:53 server id 1  end_log_pos 34586 CRC32 0x735630ea 	Write_rows: table id 91 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1083
###   @2=1
###   @3='Login'
###   @4='Test Admin logged in as Admin'
###   @5='2026-06-06 07:24:53'
# at 34586
#260606  7:24:53 server id 1  end_log_pos 34617 CRC32 0xe23c9c03 	Xid = 2883
COMMIT/*!*/;
# at 34617
#260606 10:15:12 server id 1  end_log_pos 34696 CRC32 0x21120a0f 	Anonymous_GTID	last_committed=57	sequence_number=58	rbr_only=no	original_committed_timestamp=1780712112560776	immediate_commit_timestamp=1780712112560776	transaction_length=317
# original_commit_timestamp=1780712112560776 (2026-06-06 10:15:12.560776 China Standard Time)
# immediate_commit_timestamp=1780712112560776 (2026-06-06 10:15:12.560776 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712112560776*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 34696
#260606 10:15:12 server id 1  end_log_pos 34934 CRC32 0xa46ee7da 	Query	thread_id=48	exec_time=0	error_code=0	Xid = 2962
use `udicon`/*!*/;
SET TIMESTAMP=1780712112/*!*/;
SET @@session.sql_mode=1168113696/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE users
    ADD COLUMN security_question VARCHAR(255) NULL DEFAULT NULL,
    ADD COLUMN security_answer   VARCHAR(255) NULL DEFAULT NULL
/*!*/;
# at 34934
#260606 10:18:37 server id 1  end_log_pos 35013 CRC32 0x5ac0555b 	Anonymous_GTID	last_committed=58	sequence_number=59	rbr_only=yes	original_committed_timestamp=1780712317810028	immediate_commit_timestamp=1780712317810028	transaction_length=355
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712317810028 (2026-06-06 10:18:37.810028 China Standard Time)
# immediate_commit_timestamp=1780712317810028 (2026-06-06 10:18:37.810028 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712317810028*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 35013
#260606 10:18:37 server id 1  end_log_pos 35098 CRC32 0xdeba225d 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712317/*!*/;
SET @@session.sql_mode=1168113704/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=224,@@session.collation_connection=224,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 35098
#260606 10:18:37 server id 1  end_log_pos 35172 CRC32 0x6a02dcd5 	Table_map: `udicon`.`activity_log` mapped to number 119
# has_generated_invisible_primary_key=0
# at 35172
#260606 10:18:37 server id 1  end_log_pos 35258 CRC32 0x24557b1a 	Write_rows: table id 119 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1084
###   @2=1
###   @3='Login'
###   @4='Test Admin logged in as Admin'
###   @5='2026-06-06 10:18:37'
# at 35258
#260606 10:18:37 server id 1  end_log_pos 35289 CRC32 0xe7568b8a 	Xid = 2965
COMMIT/*!*/;
# at 35289
#260606 10:19:49 server id 1  end_log_pos 35368 CRC32 0xbc4ce2c2 	Anonymous_GTID	last_committed=59	sequence_number=60	rbr_only=yes	original_committed_timestamp=1780712389552488	immediate_commit_timestamp=1780712389552488	transaction_length=563
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712389552488 (2026-06-06 10:19:49.552488 China Standard Time)
# immediate_commit_timestamp=1780712389552488 (2026-06-06 10:19:49.552488 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712389552488*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 35368
#260606 10:19:49 server id 1  end_log_pos 35456 CRC32 0x9cdfdea1 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712389/*!*/;
BEGIN
/*!*/;
# at 35456
#260606 10:19:49 server id 1  end_log_pos 35540 CRC32 0xcdb53a10 	Table_map: `udicon`.`users` mapped to number 118
# has_generated_invisible_primary_key=0
# at 35540
#260606 10:19:49 server id 1  end_log_pos 35821 CRC32 0x2084f395 	Update_rows: table id 118 flags: STMT_END_F
### UPDATE `udicon`.`users`
### WHERE
###   @1=1
###   @2='Test'
###   @3='Admin'
###   @4='$2b$10$XauwltJHiyWIeMa0.dV5reKXGsrrMgHzS7je1uGSYVc193lBGLJrm'
###   @5=b'00000111'
###   @6='09123456789'
###   @7='admin'
###   @8=1
###   @9=NULL
###   @10=NULL
### SET
###   @1=1
###   @2='Test'
###   @3='Admin'
###   @4='$2b$10$XauwltJHiyWIeMa0.dV5reKXGsrrMgHzS7je1uGSYVc193lBGLJrm'
###   @5=b'00000111'
###   @6='09123456789'
###   @7='admin'
###   @8=1
###   @9='What is your mother\'s maiden name?'
###   @10='Rodrigo'
# at 35821
#260606 10:19:49 server id 1  end_log_pos 35852 CRC32 0x650c5412 	Xid = 2977
COMMIT/*!*/;
# at 35852
#260606 10:19:49 server id 1  end_log_pos 35931 CRC32 0x6648fb42 	Anonymous_GTID	last_committed=60	sequence_number=61	rbr_only=yes	original_committed_timestamp=1780712389560611	immediate_commit_timestamp=1780712389560611	transaction_length=383
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712389560611 (2026-06-06 10:19:49.560611 China Standard Time)
# immediate_commit_timestamp=1780712389560611 (2026-06-06 10:19:49.560611 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712389560611*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 35931
#260606 10:19:49 server id 1  end_log_pos 36016 CRC32 0x8dae4e78 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712389/*!*/;
BEGIN
/*!*/;
# at 36016
#260606 10:19:49 server id 1  end_log_pos 36090 CRC32 0x88c91a91 	Table_map: `udicon`.`activity_log` mapped to number 119
# has_generated_invisible_primary_key=0
# at 36090
#260606 10:19:49 server id 1  end_log_pos 36204 CRC32 0x945ee227 	Write_rows: table id 119 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1085
###   @2=1
###   @3='Edit User'
###   @4='Updated user: admin (Admin,SalesStaff,InventoryStaff)'
###   @5='2026-06-06 10:19:49'
# at 36204
#260606 10:19:49 server id 1  end_log_pos 36235 CRC32 0xd0abcf56 	Xid = 2978
COMMIT/*!*/;
# at 36235
#260606 10:19:53 server id 1  end_log_pos 36314 CRC32 0x595fb13c 	Anonymous_GTID	last_committed=61	sequence_number=62	rbr_only=yes	original_committed_timestamp=1780712393564786	immediate_commit_timestamp=1780712393564786	transaction_length=342
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712393564786 (2026-06-06 10:19:53.564786 China Standard Time)
# immediate_commit_timestamp=1780712393564786 (2026-06-06 10:19:53.564786 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712393564786*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 36314
#260606 10:19:53 server id 1  end_log_pos 36399 CRC32 0x24c5f06a 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712393/*!*/;
BEGIN
/*!*/;
# at 36399
#260606 10:19:53 server id 1  end_log_pos 36473 CRC32 0x61256f2e 	Table_map: `udicon`.`activity_log` mapped to number 119
# has_generated_invisible_primary_key=0
# at 36473
#260606 10:19:53 server id 1  end_log_pos 36546 CRC32 0x855cca3b 	Write_rows: table id 119 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1086
###   @2=1
###   @3='Logout'
###   @4='Test logged out'
###   @5='2026-06-06 10:19:53'
# at 36546
#260606 10:19:53 server id 1  end_log_pos 36577 CRC32 0x56274262 	Xid = 2980
COMMIT/*!*/;
# at 36577
#260606 10:22:43 server id 1  end_log_pos 36656 CRC32 0xa364bfbd 	Anonymous_GTID	last_committed=62	sequence_number=63	rbr_only=yes	original_committed_timestamp=1780712563338433	immediate_commit_timestamp=1780712563338433	transaction_length=355
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712563338433 (2026-06-06 10:22:43.338433 China Standard Time)
# immediate_commit_timestamp=1780712563338433 (2026-06-06 10:22:43.338433 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712563338433*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 36656
#260606 10:22:43 server id 1  end_log_pos 36741 CRC32 0xa0304961 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712563/*!*/;
BEGIN
/*!*/;
# at 36741
#260606 10:22:43 server id 1  end_log_pos 36815 CRC32 0x67113a75 	Table_map: `udicon`.`activity_log` mapped to number 119
# has_generated_invisible_primary_key=0
# at 36815
#260606 10:22:43 server id 1  end_log_pos 36901 CRC32 0x386623ba 	Write_rows: table id 119 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1087
###   @2=1
###   @3='Login'
###   @4='Test Admin logged in as Admin'
###   @5='2026-06-06 10:22:43'
# at 36901
#260606 10:22:43 server id 1  end_log_pos 36932 CRC32 0xe70f2006 	Xid = 2983
COMMIT/*!*/;
# at 36932
#260606 10:24:28 server id 1  end_log_pos 37011 CRC32 0x164f063a 	Anonymous_GTID	last_committed=63	sequence_number=64	rbr_only=yes	original_committed_timestamp=1780712668224449	immediate_commit_timestamp=1780712668224449	transaction_length=410
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712668224449 (2026-06-06 10:24:28.224449 China Standard Time)
# immediate_commit_timestamp=1780712668224449 (2026-06-06 10:24:28.224449 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712668224449*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 37011
#260606 10:24:28 server id 1  end_log_pos 37090 CRC32 0x2119797f 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712668/*!*/;
BEGIN
/*!*/;
# at 37090
#260606 10:24:28 server id 1  end_log_pos 37174 CRC32 0x94f61354 	Table_map: `udicon`.`users` mapped to number 118
# has_generated_invisible_primary_key=0
# at 37174
#260606 10:24:28 server id 1  end_log_pos 37311 CRC32 0x83477c11 	Write_rows: table id 118 flags: STMT_END_F
### INSERT INTO `udicon`.`users`
### SET
###   @1=16
###   @2='admin'
###   @3='admin'
###   @4='$2b$10$A3YSrstN3D3nPXevpnHdC.CC7jWcuSoAfSRkVvlCzRqSIv9uhLb3W'
###   @5=b'00000001'
###   @6='09123456789'
###   @7='admin1'
###   @8=1
###   @9=NULL
###   @10=NULL
# at 37311
#260606 10:24:28 server id 1  end_log_pos 37342 CRC32 0xc716598a 	Xid = 2995
COMMIT/*!*/;
# at 37342
#260606 10:24:28 server id 1  end_log_pos 37421 CRC32 0x6b586ccc 	Anonymous_GTID	last_committed=64	sequence_number=65	rbr_only=yes	original_committed_timestamp=1780712668228928	immediate_commit_timestamp=1780712668228928	transaction_length=360
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712668228928 (2026-06-06 10:24:28.228928 China Standard Time)
# immediate_commit_timestamp=1780712668228928 (2026-06-06 10:24:28.228928 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712668228928*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 37421
#260606 10:24:28 server id 1  end_log_pos 37506 CRC32 0xa90fe17c 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712668/*!*/;
BEGIN
/*!*/;
# at 37506
#260606 10:24:28 server id 1  end_log_pos 37580 CRC32 0xa5dc4181 	Table_map: `udicon`.`activity_log` mapped to number 119
# has_generated_invisible_primary_key=0
# at 37580
#260606 10:24:28 server id 1  end_log_pos 37671 CRC32 0xdebe9b6c 	Write_rows: table id 119 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1088
###   @2=1
###   @3='Create User'
###   @4='Created user: admin1 (Admin)'
###   @5='2026-06-06 10:24:28'
# at 37671
#260606 10:24:28 server id 1  end_log_pos 37702 CRC32 0x7b172860 	Xid = 2996
COMMIT/*!*/;
# at 37702
#260606 10:24:50 server id 1  end_log_pos 37781 CRC32 0x1cac70d7 	Anonymous_GTID	last_committed=65	sequence_number=66	rbr_only=yes	original_committed_timestamp=1780712690253454	immediate_commit_timestamp=1780712690253454	transaction_length=342
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712690253454 (2026-06-06 10:24:50.253454 China Standard Time)
# immediate_commit_timestamp=1780712690253454 (2026-06-06 10:24:50.253454 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712690253454*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 37781
#260606 10:24:50 server id 1  end_log_pos 37866 CRC32 0x33f347b0 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712690/*!*/;
BEGIN
/*!*/;
# at 37866
#260606 10:24:50 server id 1  end_log_pos 37940 CRC32 0xfd7c24d1 	Table_map: `udicon`.`activity_log` mapped to number 119
# has_generated_invisible_primary_key=0
# at 37940
#260606 10:24:50 server id 1  end_log_pos 38013 CRC32 0xdbbca30c 	Write_rows: table id 119 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1089
###   @2=1
###   @3='Logout'
###   @4='Test logged out'
###   @5='2026-06-06 10:24:50'
# at 38013
#260606 10:24:50 server id 1  end_log_pos 38044 CRC32 0xe5b61874 	Xid = 3000
COMMIT/*!*/;
# at 38044
#260606 10:26:34 server id 1  end_log_pos 38123 CRC32 0x0258aff1 	Anonymous_GTID	last_committed=66	sequence_number=67	rbr_only=yes	original_committed_timestamp=1780712794945116	immediate_commit_timestamp=1780712794945116	transaction_length=608
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712794945116 (2026-06-06 10:26:34.945116 China Standard Time)
# immediate_commit_timestamp=1780712794945116 (2026-06-06 10:26:34.945116 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712794945116*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 38123
#260606 10:26:34 server id 1  end_log_pos 38211 CRC32 0x56a0fc00 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712794/*!*/;
BEGIN
/*!*/;
# at 38211
#260606 10:26:34 server id 1  end_log_pos 38295 CRC32 0x4e77d8e2 	Table_map: `udicon`.`users` mapped to number 118
# has_generated_invisible_primary_key=0
# at 38295
#260606 10:26:34 server id 1  end_log_pos 38621 CRC32 0xbeaaf4b9 	Update_rows: table id 118 flags: STMT_END_F
### UPDATE `udicon`.`users`
### WHERE
###   @1=1
###   @2='Test'
###   @3='Admin'
###   @4='$2b$10$XauwltJHiyWIeMa0.dV5reKXGsrrMgHzS7je1uGSYVc193lBGLJrm'
###   @5=b'00000111'
###   @6='09123456789'
###   @7='admin'
###   @8=1
###   @9='What is your mother\'s maiden name?'
###   @10='Rodrigo'
### SET
###   @1=1
###   @2='Test'
###   @3='Admin'
###   @4='$2b$10$ff0/Qvn8Rdcl.NUs5oh0V.9Ymusswj07rqIH57wWCEwCznaIK8y3m'
###   @5=b'00000111'
###   @6='09123456789'
###   @7='admin'
###   @8=1
###   @9='What is your mother\'s maiden name?'
###   @10='Rodrigo'
# at 38621
#260606 10:26:34 server id 1  end_log_pos 38652 CRC32 0xf588d015 	Xid = 3012
COMMIT/*!*/;
# at 38652
#260606 10:26:34 server id 1  end_log_pos 38731 CRC32 0xad02ba8a 	Anonymous_GTID	last_committed=67	sequence_number=68	rbr_only=yes	original_committed_timestamp=1780712794950754	immediate_commit_timestamp=1780712794950754	transaction_length=387
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780712794950754 (2026-06-06 10:26:34.950754 China Standard Time)
# immediate_commit_timestamp=1780712794950754 (2026-06-06 10:26:34.950754 China Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780712794950754*//*!*/;
/*!80014 SET @@session.original_server_version=80044*//*!*/;
/*!80014 SET @@session.immediate_server_version=80044*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 38731
#260606 10:26:34 server id 1  end_log_pos 38816 CRC32 0xef70c81c 	Query	thread_id=49	exec_time=0	error_code=0
SET TIMESTAMP=1780712794/*!*/;
BEGIN
/*!*/;
# at 38816
#260606 10:26:34 server id 1  end_log_pos 38890 CRC32 0x8df9e529 	Table_map: `udicon`.`activity_log` mapped to number 119
# has_generated_invisible_primary_key=0
# at 38890
#260606 10:26:34 server id 1  end_log_pos 39008 CRC32 0xcc82c3d7 	Write_rows: table id 119 flags: STMT_END_F
### INSERT INTO `udicon`.`activity_log`
### SET
###   @1=1090
###   @2=1
###   @3='Reset Password'
###   @4='Password reset via security question for user: admin'
###   @5='2026-06-06 10:26:34'
# at 39008
#260606 10:26:34 server id 1  end_log_pos 39039 CRC32 0x3cd61602 	Xid = 3013
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
