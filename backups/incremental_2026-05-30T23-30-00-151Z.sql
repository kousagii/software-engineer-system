# The proper term is pseudo_replica_mode, but we use this compatibility alias
# to make the statement usable on server versions 8.0.24 and older.
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#260531  3:30:00 server id 1  end_log_pos 126 CRC32 0xd106a067 	Start: binlog v 4, server v 8.0.46 created 260531  3:30:00
BINLOG '
uDobag8BAAAAegAAAH4AAAAAAAQAOC4wLjQ2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAEwANAAgAAAAABAAEAAAAYgAEGggAAAAICAgCAAAACgoKKioAEjQA
CigAAWegBtE=
'/*!*/;
# at 126
#260531  3:30:00 server id 1  end_log_pos 157 CRC32 0x5cb05182 	Previous-GTIDs
# [empty]
# at 157
#260531  3:34:48 server id 1  end_log_pos 236 CRC32 0xba8b6597 	Anonymous_GTID	last_committed=0	sequence_number=1	rbr_only=no	original_committed_timestamp=1780169688323667	immediate_commit_timestamp=1780169688323667	transaction_length=748
# original_commit_timestamp=1780169688323667 (2026-05-31 03:34:48.323667 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169688323667 (2026-05-31 03:34:48.323667 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169688323667*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 236
#260531  3:34:48 server id 1  end_log_pos 905 CRC32 0xa7641a16 	Query	thread_id=118	exec_time=0	error_code=0
use `udicon_db`/*!*/;
SET TIMESTAMP=1780169688/*!*/;
SET @@session.pseudo_thread_id=118/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1168113704/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=224,@@session.collation_connection=224,@@session.collation_server=255/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
/*!80011 SET @@session.default_collation_for_utf8mb4=255*//*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS payment_log (
            paymentID INT AUTO_INCREMENT PRIMARY KEY,
            transactionCode VARCHAR(50) NOT NULL,
            dueDate DATE NULL,
            amountDue DECIMAL(12,2) DEFAULT 0.00,
            cashAmount DECIMAL(12,2) DEFAULT 0.00,
            digitalAmount DECIMAL(12,2) DEFAULT 0.00,
            paymentDate DATETIME NULL,
            paymentMethod VARCHAR(50) NULL,
            referenceNumber VARCHAR(100) NULL,
            status VARCHAR(20) DEFAULT 'Scheduled',
            paymentType VARCHAR(20) DEFAULT 'Installment'
        )
/*!*/;
# at 905
#260531  3:35:01 server id 1  end_log_pos 984 CRC32 0x5c2c4a86 	Anonymous_GTID	last_committed=1	sequence_number=2	rbr_only=yes	original_committed_timestamp=1780169701922287	immediate_commit_timestamp=1780169701922287	transaction_length=360
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169701922287 (2026-05-31 03:35:01.922287 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169701922287 (2026-05-31 03:35:01.922287 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169701922287*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 984
#260531  3:35:01 server id 1  end_log_pos 1072 CRC32 0xd70e337e 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169701/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
BEGIN
/*!*/;
# at 1072
#260531  3:35:01 server id 1  end_log_pos 1149 CRC32 0x605788cf 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 1149
#260531  3:35:01 server id 1  end_log_pos 1234 CRC32 0x6f2cb35e 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
5TsbahMBAAAATQAAAH0EAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AM+IV2A=
5Tsbah4BAAAAVQAAANIEAAAAAL8AAAAAAAEAAgAF/wBNAwAABQAAAAVMb2dpbhwAQXNpZSBVc2Vy
IGxvZ2dlZCBpbiBhcyBBZG1pbpm5/jjBXrMsbw==
'/*!*/;
# at 1234
#260531  3:35:01 server id 1  end_log_pos 1265 CRC32 0x0d419d5a 	Xid = 5984
COMMIT/*!*/;
# at 1265
#260531  3:35:24 server id 1  end_log_pos 1344 CRC32 0x6f0506c2 	Anonymous_GTID	last_committed=2	sequence_number=3	rbr_only=yes	original_committed_timestamp=1780169724097796	immediate_commit_timestamp=1780169724097796	transaction_length=375
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169724097796 (2026-05-31 03:35:24.097796 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169724097796 (2026-05-31 03:35:24.097796 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169724097796*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1344
#260531  3:35:24 server id 1  end_log_pos 1432 CRC32 0x29666913 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169724/*!*/;
BEGIN
/*!*/;
# at 1432
#260531  3:35:24 server id 1  end_log_pos 1509 CRC32 0x7359e633 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 1509
#260531  3:35:24 server id 1  end_log_pos 1609 CRC32 0x1452d846 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
/DsbahMBAAAATQAAAOUFAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/ADPmWXM=
/Dsbah4BAAAAZAAAAEkGAAAAAL8AAAAAAAEAAgAF/wBOAwAABQAAAAVMb2dpbisAQXNpZSBzd2l0
Y2hlZCBmcm9tIEFkbWluIHZpZXcgdG8gU2FsZXMgdmlld5m5/jjYRthSFA==
'/*!*/;
# at 1609
#260531  3:35:24 server id 1  end_log_pos 1640 CRC32 0xc17a7073 	Xid = 5998
COMMIT/*!*/;
# at 1640
#260531  3:35:27 server id 1  end_log_pos 1719 CRC32 0x04403e61 	Anonymous_GTID	last_committed=3	sequence_number=4	rbr_only=yes	original_committed_timestamp=1780169727851237	immediate_commit_timestamp=1780169727851237	transaction_length=379
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169727851237 (2026-05-31 03:35:27.851237 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169727851237 (2026-05-31 03:35:27.851237 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169727851237*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1719
#260531  3:35:27 server id 1  end_log_pos 1807 CRC32 0x116ca5d0 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169727/*!*/;
BEGIN
/*!*/;
# at 1807
#260531  3:35:27 server id 1  end_log_pos 1884 CRC32 0xbc641ba5 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 1884
#260531  3:35:27 server id 1  end_log_pos 1988 CRC32 0x96031512 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
/zsbahMBAAAATQAAAFwHAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AKUbZLw=
/zsbah4BAAAAaAAAAMQHAAAAAL8AAAAAAAEAAgAF/wBPAwAABQAAAAVMb2dpbi8AQXNpZSBzd2l0
Y2hlZCBmcm9tIFNhbGVzIHZpZXcgdG8gSW52ZW50b3J5IHZpZXeZuf442xIVA5Y=
'/*!*/;
# at 1988
#260531  3:35:27 server id 1  end_log_pos 2019 CRC32 0x0a027323 	Xid = 6000
COMMIT/*!*/;
# at 2019
#260531  3:35:51 server id 1  end_log_pos 2098 CRC32 0x7caac815 	Anonymous_GTID	last_committed=4	sequence_number=5	rbr_only=yes	original_committed_timestamp=1780169751593503	immediate_commit_timestamp=1780169751593503	transaction_length=379
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169751593503 (2026-05-31 03:35:51.593503 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169751593503 (2026-05-31 03:35:51.593503 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169751593503*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 2098
#260531  3:35:51 server id 1  end_log_pos 2186 CRC32 0xfdf873ca 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169751/*!*/;
BEGIN
/*!*/;
# at 2186
#260531  3:35:51 server id 1  end_log_pos 2263 CRC32 0x93cb836b 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 2263
#260531  3:35:51 server id 1  end_log_pos 2367 CRC32 0xb54ee70c 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
FzwbahMBAAAATQAAANcIAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AGuDy5M=
Fzwbah4BAAAAaAAAAD8JAAAAAL8AAAAAAAEAAgAF/wBQAwAABQAAAAVMb2dpbi8AQXNpZSBzd2l0
Y2hlZCBmcm9tIEludmVudG9yeSB2aWV3IHRvIFNhbGVzIHZpZXeZuf448wznTrU=
'/*!*/;
# at 2367
#260531  3:35:51 server id 1  end_log_pos 2398 CRC32 0xff43adff 	Xid = 6007
COMMIT/*!*/;
# at 2398
#260531  3:35:57 server id 1  end_log_pos 2477 CRC32 0x676a83fa 	Anonymous_GTID	last_committed=5	sequence_number=6	rbr_only=yes	original_committed_timestamp=1780169757643339	immediate_commit_timestamp=1780169757643339	transaction_length=375
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169757643339 (2026-05-31 03:35:57.643339 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169757643339 (2026-05-31 03:35:57.643339 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169757643339*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 2477
#260531  3:35:57 server id 1  end_log_pos 2565 CRC32 0x8bf32b72 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169757/*!*/;
BEGIN
/*!*/;
# at 2565
#260531  3:35:57 server id 1  end_log_pos 2642 CRC32 0x287df649 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 2642
#260531  3:35:57 server id 1  end_log_pos 2742 CRC32 0x01e46fef 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
HTwbahMBAAAATQAAAFIKAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AEn2fSg=
HTwbah4BAAAAZAAAALYKAAAAAL8AAAAAAAEAAgAF/wBRAwAABQAAAAVMb2dpbisAQXNpZSBzd2l0
Y2hlZCBmcm9tIFNhbGVzIHZpZXcgdG8gQWRtaW4gdmlld5m5/jj572/kAQ==
'/*!*/;
# at 2742
#260531  3:35:57 server id 1  end_log_pos 2773 CRC32 0x84d2e704 	Xid = 6009
COMMIT/*!*/;
# at 2773
#260531  3:36:00 server id 1  end_log_pos 2852 CRC32 0xad1268b8 	Anonymous_GTID	last_committed=6	sequence_number=7	rbr_only=yes	original_committed_timestamp=1780169760084708	immediate_commit_timestamp=1780169760084708	transaction_length=379
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169760084708 (2026-05-31 03:36:00.084708 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169760084708 (2026-05-31 03:36:00.084708 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169760084708*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 2852
#260531  3:36:00 server id 1  end_log_pos 2940 CRC32 0x05b71110 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169760/*!*/;
BEGIN
/*!*/;
# at 2940
#260531  3:36:00 server id 1  end_log_pos 3017 CRC32 0x2edc988d 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 3017
#260531  3:36:00 server id 1  end_log_pos 3121 CRC32 0xa0a9c6a7 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
IDwbahMBAAAATQAAAMkLAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AI2Y3C4=
IDwbah4BAAAAaAAAADEMAAAAAL8AAAAAAAEAAgAF/wBSAwAABQAAAAVMb2dpbi8AQXNpZSBzd2l0
Y2hlZCBmcm9tIEFkbWluIHZpZXcgdG8gSW52ZW50b3J5IHZpZXeZuf45AKfGqaA=
'/*!*/;
# at 3121
#260531  3:36:00 server id 1  end_log_pos 3152 CRC32 0x685be3bc 	Xid = 6020
COMMIT/*!*/;
# at 3152
#260531  3:36:36 server id 1  end_log_pos 3231 CRC32 0x4a645f6e 	Anonymous_GTID	last_committed=7	sequence_number=8	rbr_only=yes	original_committed_timestamp=1780169796193764	immediate_commit_timestamp=1780169796193764	transaction_length=1231
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169796193764 (2026-05-31 03:36:36.193764 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169796193764 (2026-05-31 03:36:36.193764 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169796193764*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 3231
#260531  3:36:36 server id 1  end_log_pos 3322 CRC32 0x89f350b5 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169796/*!*/;
BEGIN
/*!*/;
# at 3322
#260531  3:36:36 server id 1  end_log_pos 3424 CRC32 0x2de1805d 	Table_map: `udicon_db`.`purchase_order` mapped to number 210
# has_generated_invisible_primary_key=0
# at 3424
#260531  3:36:36 server id 1  end_log_pos 3536 CRC32 0x6d83c1b2 	Update_rows: table id 210 flags: STMT_END_F

BINLOG '
RDwbahMBAAAAZgAAAGANAAAAANIAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADgMD
AxL+Dw/+Dw8S9gEPEgD3AZAB/AP3AcgAkAEACgKQAeAvAQEAAgP8/wBdgOEt
RDwbah8BAAAAcAAAANANAAAAANIAAAAAAAEAAgAO/////2AiAwAAAAUAAAABAAAAmbnwFYMCAgRD
YXNombnyAACAAIi4AAFgIgMAAAAFAAAAAQAAAJm58BWDBAIEQ2FzaJm58gAAgACIuAABssGDbQ==
'/*!*/;
# at 3536
#260531  3:36:36 server id 1  end_log_pos 3609 CRC32 0xa54aa282 	Table_map: `udicon_db`.`purchase_item` mapped to number 212
# has_generated_invisible_primary_key=0
# at 3609
#260531  3:36:36 server id 1  end_log_pos 3709 CRC32 0x29104263 	Update_rows: table id 212 flags: STMT_END_F

BINLOG '
RDwbahMBAAAASQAAABkOAAAAANQAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAgqJKpQ==
RDwbah8BAAAAZAAAAH0OAAAAANQAAAAAAAEAAgAI//+ABgAAAAMAAAAIAAAADQAAAIAACyIAAAAA
AAAAAAAABgAAAAMAAAAIAAAADQAAAIAACyIADQAAAAAAAAAHAAAAY0IQKQ==
'/*!*/;
# at 3709
#260531  3:36:36 server id 1  end_log_pos 3809 CRC32 0x71f0a2b3 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 3809
#260531  3:36:36 server id 1  end_log_pos 4169 CRC32 0x78264783 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
RDwbahMBAAAAZAAAAOEOAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8As6LwcQ==
RDwbah8BAAAAaAEAAEkQAAAAAMAAAAAAAAEAAgAP/////wBYCAAAAA4ARWxlY3RyaWMgRHJpbGwM
Mjc0NDY3NjgxNjExBVRvb2xzBQAAAIAACDQAgAALIgAFQm9zY2gyAFJlbGlhYmxlIGRyaWxsIGZv
ciB3b29kLCBtZXRhbCwgYW5kIGNvbmNyZXRlIHdvcmsuKQAvdXBsb2Fkcy9wcm9kLTE3NzkxMjc0
NDc5ODMtMzEyNjgzODEzLnBuZwEKAAAAAFgIAAAADgBFbGVjdHJpYyBEcmlsbAwyNzQ0Njc2ODE2
MTEFVG9vbHMSAAAAgAAINACAAAsiAAVCb3NjaDIAUmVsaWFibGUgZHJpbGwgZm9yIHdvb2QsIG1l
dGFsLCBhbmQgY29uY3JldGUgd29yay4pAC91cGxvYWRzL3Byb2QtMTc3OTEyNzQ0Nzk4My0zMTI2
ODM4MTMucG5nAQoAAACDRyZ4
'/*!*/;
# at 4169
#260531  3:36:36 server id 1  end_log_pos 4246 CRC32 0x7ffbec48 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 4246
#260531  3:36:36 server id 1  end_log_pos 4352 CRC32 0x7e8b4889 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
RDwbahMBAAAATQAAAJYQAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AEjs+38=
RDwbah4BAAAAagAAAAARAAAAAL8AAAAAAAEAAgAF/wBTAwAABQAAAA1SZWNlaXZlIE9yZGVyKQBS
ZWNlaXZlZC9VcGRhdGVkIFBPLTMgKFN0YXR1czogQ29tcGxldGVkKZm5/jkkiUiLfg==
'/*!*/;
# at 4352
#260531  3:36:36 server id 1  end_log_pos 4383 CRC32 0x90a2dae5 	Xid = 6045
COMMIT/*!*/;
# at 4383
#260531  3:36:43 server id 1  end_log_pos 4462 CRC32 0x7301d884 	Anonymous_GTID	last_committed=8	sequence_number=9	rbr_only=yes	original_committed_timestamp=1780169803205135	immediate_commit_timestamp=1780169803205135	transaction_length=1201
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169803205135 (2026-05-31 03:36:43.205135 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169803205135 (2026-05-31 03:36:43.205135 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169803205135*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 4462
#260531  3:36:43 server id 1  end_log_pos 4553 CRC32 0xf8937f50 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169803/*!*/;
BEGIN
/*!*/;
# at 4553
#260531  3:36:43 server id 1  end_log_pos 4655 CRC32 0xa1f1642f 	Table_map: `udicon_db`.`purchase_order` mapped to number 210
# has_generated_invisible_primary_key=0
# at 4655
#260531  3:36:43 server id 1  end_log_pos 4737 CRC32 0x90b027b3 	Update_rows: table id 210 flags: STMT_END_F

BINLOG '
SzwbahMBAAAAZgAAAC8SAAAAANIAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADgMD
AxL+Dw/+Dw8S9gEPEgD3AZAB/AP3AcgAkAEACgKQAeAvAQEAAgP8/wAvZPGh
Szwbah8BAAAAUgAAAIESAAAAANIAAAAAAAEAAgAO/////2AvBAAAAAUAAAABAAAAmbnwFYwCAgFg
LwQAAAAFAAAAAQAAAJm58BWMBAIBsyewkA==
'/*!*/;
# at 4737
#260531  3:36:43 server id 1  end_log_pos 4810 CRC32 0xce8972d6 	Table_map: `udicon_db`.`purchase_item` mapped to number 212
# has_generated_invisible_primary_key=0
# at 4810
#260531  3:36:43 server id 1  end_log_pos 4910 CRC32 0xe8e32eb9 	Update_rows: table id 212 flags: STMT_END_F

BINLOG '
SzwbahMBAAAASQAAAMoSAAAAANQAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA1nKJzg==
Szwbah8BAAAAZAAAAC4TAAAAANQAAAAAAAEAAgAI//+ABwAAAAQAAAAIAAAADQAAAIAACyIAAAAA
AAAAAAAABwAAAAQAAAAIAAAADQAAAIAACyIADQAAAAAAAAAHAAAAuS7j6A==
'/*!*/;
# at 4910
#260531  3:36:43 server id 1  end_log_pos 5010 CRC32 0x2e4bbdad 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 5010
#260531  3:36:43 server id 1  end_log_pos 5370 CRC32 0x71131118 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
SzwbahMBAAAAZAAAAJITAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8Arb1LLg==
Szwbah8BAAAAaAEAAPoUAAAAAMAAAAAAAAEAAgAP/////wBYCAAAAA4ARWxlY3RyaWMgRHJpbGwM
Mjc0NDY3NjgxNjExBVRvb2xzEgAAAIAACDQAgAALIgAFQm9zY2gyAFJlbGlhYmxlIGRyaWxsIGZv
ciB3b29kLCBtZXRhbCwgYW5kIGNvbmNyZXRlIHdvcmsuKQAvdXBsb2Fkcy9wcm9kLTE3NzkxMjc0
NDc5ODMtMzEyNjgzODEzLnBuZwEKAAAAAFgIAAAADgBFbGVjdHJpYyBEcmlsbAwyNzQ0Njc2ODE2
MTEFVG9vbHMfAAAAgAAINACAAAsiAAVCb3NjaDIAUmVsaWFibGUgZHJpbGwgZm9yIHdvb2QsIG1l
dGFsLCBhbmQgY29uY3JldGUgd29yay4pAC91cGxvYWRzL3Byb2QtMTc3OTEyNzQ0Nzk4My0zMTI2
ODM4MTMucG5nAQoAAAAYERNx
'/*!*/;
# at 5370
#260531  3:36:43 server id 1  end_log_pos 5447 CRC32 0x75c70021 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 5447
#260531  3:36:43 server id 1  end_log_pos 5553 CRC32 0x803b3d2f 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
SzwbahMBAAAATQAAAEcVAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/ACEAx3U=
Szwbah4BAAAAagAAALEVAAAAAL8AAAAAAAEAAgAF/wBUAwAABQAAAA1SZWNlaXZlIE9yZGVyKQBS
ZWNlaXZlZC9VcGRhdGVkIFBPLTQgKFN0YXR1czogQ29tcGxldGVkKZm5/jkrLz07gA==
'/*!*/;
# at 5553
#260531  3:36:43 server id 1  end_log_pos 5584 CRC32 0xc01fc32f 	Xid = 6055
COMMIT/*!*/;
# at 5584
#260531  3:36:54 server id 1  end_log_pos 5663 CRC32 0x9fca7628 	Anonymous_GTID	last_committed=9	sequence_number=10	rbr_only=yes	original_committed_timestamp=1780169814446254	immediate_commit_timestamp=1780169814446254	transaction_length=1858
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169814446254 (2026-05-31 03:36:54.446254 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169814446254 (2026-05-31 03:36:54.446254 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169814446254*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 5663
#260531  3:36:54 server id 1  end_log_pos 5754 CRC32 0x36905355 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169814/*!*/;
BEGIN
/*!*/;
# at 5754
#260531  3:36:54 server id 1  end_log_pos 5856 CRC32 0xd1d8415c 	Table_map: `udicon_db`.`purchase_order` mapped to number 210
# has_generated_invisible_primary_key=0
# at 5856
#260531  3:36:54 server id 1  end_log_pos 5958 CRC32 0xb41b51eb 	Update_rows: table id 210 flags: STMT_END_F

BINLOG '
VjwbahMBAAAAZgAAAOAWAAAAANIAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADgMD
AxL+Dw/+Dw8S9gEPEgD3AZAB/AP3AcgAkAEACgKQAeAvAQEAAgP8/wBcQdjR
Vjwbah8BAAAAZgAAAEYXAAAAANIAAAAAAAEAAgAO/////2AqBQAAAAUAAAABAAAAmbnxNJcCAgRD
YXNombnyAAABYCoFAAAABQAAAAEAAACZufE0lwQCBENhc2iZufIAAAHrURu0
'/*!*/;
# at 5958
#260531  3:36:54 server id 1  end_log_pos 6031 CRC32 0x13943928 	Table_map: `udicon_db`.`purchase_item` mapped to number 212
# has_generated_invisible_primary_key=0
# at 6031
#260531  3:36:54 server id 1  end_log_pos 6131 CRC32 0x0513b0f8 	Update_rows: table id 212 flags: STMT_END_F

BINLOG '
VjwbahMBAAAASQAAAI8XAAAAANQAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAKDmUEw==
Vjwbah8BAAAAZAAAAPMXAAAAANQAAAAAAAEAAgAI//+ACAAAAAUAAAAEAAAACgAAAIAAARgAAAAA
AAAAAAAACAAAAAUAAAAEAAAACgAAAIAAARgACgAAAAAAAAAHAAAA+LATBQ==
'/*!*/;
# at 6131
#260531  3:36:54 server id 1  end_log_pos 6231 CRC32 0x475365bc 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 6231
#260531  3:36:54 server id 1  end_log_pos 6595 CRC32 0xdf46eff5 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
VjwbahMBAAAAZAAAAFcYAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8AvGVTRw==
Vjwbah8BAAAAbAEAAMMZAAAAAMAAAAAAAAEAAgAP/////wBYBAAAABEAQWRqdXN0YWJsZSBXcmVu
Y2gMNzkxNjI3MzI3MTYyBVRvb2xzAAAAAIAAAMgAgAABGAAGVG9sc2VuMABBZGp1c3RhYmxlIHdy
ZW5jaCBmb3IgdGlnaHRlbmluZyBudXRzIGFuZCBib2x0cy4pAC91cGxvYWRzL3Byb2QtMTc3OTEy
Njk0MDU0Ny0xMjE5MzYxNTEucG5nAQoAAAAAWAQAAAARAEFkanVzdGFibGUgV3JlbmNoDDc5MTYy
NzMyNzE2MgVUb29scwoAAACAAADIAIAAARgABlRvbHNlbjAAQWRqdXN0YWJsZSB3cmVuY2ggZm9y
IHRpZ2h0ZW5pbmcgbnV0cyBhbmQgYm9sdHMuKQAvdXBsb2Fkcy9wcm9kLTE3NzkxMjY5NDA1NDct
MTIxOTM2MTUxLnBuZwEKAAAA9e9G3w==
'/*!*/;
# at 6595
#260531  3:36:54 server id 1  end_log_pos 6668 CRC32 0x454b3548 	Table_map: `udicon_db`.`purchase_item` mapped to number 212
# has_generated_invisible_primary_key=0
# at 6668
#260531  3:36:54 server id 1  end_log_pos 6768 CRC32 0x19c57092 	Update_rows: table id 212 flags: STMT_END_F

BINLOG '
VjwbahMBAAAASQAAAAwaAAAAANQAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEASDVLRQ==
Vjwbah8BAAAAZAAAAHAaAAAAANQAAAAAAAEAAgAI//+ACQAAAAUAAAAIAAAACgAAAIAACyIAAAAA
AAAAAAAACQAAAAUAAAAIAAAACgAAAIAACyIACgAAAAAAAAAHAAAAknDFGQ==
'/*!*/;
# at 6768
#260531  3:36:54 server id 1  end_log_pos 6868 CRC32 0x8d69aff7 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 6868
#260531  3:36:54 server id 1  end_log_pos 7228 CRC32 0x885c863d 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
VjwbahMBAAAAZAAAANQaAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8A969pjQ==
Vjwbah8BAAAAaAEAADwcAAAAAMAAAAAAAAEAAgAP/////wBYCAAAAA4ARWxlY3RyaWMgRHJpbGwM
Mjc0NDY3NjgxNjExBVRvb2xzHwAAAIAACDQAgAALIgAFQm9zY2gyAFJlbGlhYmxlIGRyaWxsIGZv
ciB3b29kLCBtZXRhbCwgYW5kIGNvbmNyZXRlIHdvcmsuKQAvdXBsb2Fkcy9wcm9kLTE3NzkxMjc0
NDc5ODMtMzEyNjgzODEzLnBuZwEKAAAAAFgIAAAADgBFbGVjdHJpYyBEcmlsbAwyNzQ0Njc2ODE2
MTEFVG9vbHMpAAAAgAAINACAAAsiAAVCb3NjaDIAUmVsaWFibGUgZHJpbGwgZm9yIHdvb2QsIG1l
dGFsLCBhbmQgY29uY3JldGUgd29yay4pAC91cGxvYWRzL3Byb2QtMTc3OTEyNzQ0Nzk4My0zMTI2
ODM4MTMucG5nAQoAAAA9hlyI
'/*!*/;
# at 7228
#260531  3:36:54 server id 1  end_log_pos 7305 CRC32 0x574e8c5b 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 7305
#260531  3:36:54 server id 1  end_log_pos 7411 CRC32 0x70f61494 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
VjwbahMBAAAATQAAAIkcAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AFuMTlc=
Vjwbah4BAAAAagAAAPMcAAAAAL8AAAAAAAEAAgAF/wBVAwAABQAAAA1SZWNlaXZlIE9yZGVyKQBS
ZWNlaXZlZC9VcGRhdGVkIFBPLTUgKFN0YXR1czogQ29tcGxldGVkKZm5/jk2lBT2cA==
'/*!*/;
# at 7411
#260531  3:36:54 server id 1  end_log_pos 7442 CRC32 0x9057f98b 	Xid = 6065
COMMIT/*!*/;
# at 7442
#260531  3:37:03 server id 1  end_log_pos 7521 CRC32 0x63e7ff80 	Anonymous_GTID	last_committed=10	sequence_number=11	rbr_only=yes	original_committed_timestamp=1780169823649515	immediate_commit_timestamp=1780169823649515	transaction_length=1838
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780169823649515 (2026-05-31 03:37:03.649515 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780169823649515 (2026-05-31 03:37:03.649515 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780169823649515*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 7521
#260531  3:37:03 server id 1  end_log_pos 7612 CRC32 0x71ce735c 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780169823/*!*/;
BEGIN
/*!*/;
# at 7612
#260531  3:37:03 server id 1  end_log_pos 7714 CRC32 0xbc03be4c 	Table_map: `udicon_db`.`purchase_order` mapped to number 210
# has_generated_invisible_primary_key=0
# at 7714
#260531  3:37:03 server id 1  end_log_pos 7796 CRC32 0x440eeffa 	Update_rows: table id 210 flags: STMT_END_F

BINLOG '
XzwbahMBAAAAZgAAACIeAAAAANIAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADgMD
AxL+Dw/+Dw8S9gEPEgD3AZAB/AP3AcgAkAEACgKQAeAvAQEAAgP8/wBMvgO8
Xzwbah8BAAAAUgAAAHQeAAAAANIAAAAAAAEAAgAO/////2AvBgAAAAUAAAABAAAAmbnxNKQCAgFg
LwYAAAAFAAAAAQAAAJm58TSkBAIB+u8ORA==
'/*!*/;
# at 7796
#260531  3:37:03 server id 1  end_log_pos 7869 CRC32 0x0c2afedd 	Table_map: `udicon_db`.`purchase_item` mapped to number 212
# has_generated_invisible_primary_key=0
# at 7869
#260531  3:37:03 server id 1  end_log_pos 7969 CRC32 0x1dff647c 	Update_rows: table id 212 flags: STMT_END_F

BINLOG '
XzwbahMBAAAASQAAAL0eAAAAANQAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA3f4qDA==
Xzwbah8BAAAAZAAAACEfAAAAANQAAAAAAAEAAgAI//+ACgAAAAYAAAAEAAAACgAAAIAAARgAAAAA
AAAAAAAACgAAAAYAAAAEAAAACgAAAIAAARgACgAAAAAAAAAHAAAAfGT/HQ==
'/*!*/;
# at 7969
#260531  3:37:03 server id 1  end_log_pos 8069 CRC32 0x63ec996c 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 8069
#260531  3:37:03 server id 1  end_log_pos 8433 CRC32 0x4adaaa68 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
XzwbahMBAAAAZAAAAIUfAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8AbJnsYw==
Xzwbah8BAAAAbAEAAPEgAAAAAMAAAAAAAAEAAgAP/////wBYBAAAABEAQWRqdXN0YWJsZSBXcmVu
Y2gMNzkxNjI3MzI3MTYyBVRvb2xzCgAAAIAAAMgAgAABGAAGVG9sc2VuMABBZGp1c3RhYmxlIHdy
ZW5jaCBmb3IgdGlnaHRlbmluZyBudXRzIGFuZCBib2x0cy4pAC91cGxvYWRzL3Byb2QtMTc3OTEy
Njk0MDU0Ny0xMjE5MzYxNTEucG5nAQoAAAAAWAQAAAARAEFkanVzdGFibGUgV3JlbmNoDDc5MTYy
NzMyNzE2MgVUb29scxQAAACAAADIAIAAARgABlRvbHNlbjAAQWRqdXN0YWJsZSB3cmVuY2ggZm9y
IHRpZ2h0ZW5pbmcgbnV0cyBhbmQgYm9sdHMuKQAvdXBsb2Fkcy9wcm9kLTE3NzkxMjY5NDA1NDct
MTIxOTM2MTUxLnBuZwEKAAAAaKraSg==
'/*!*/;
# at 8433
#260531  3:37:03 server id 1  end_log_pos 8506 CRC32 0xbe5e9784 	Table_map: `udicon_db`.`purchase_item` mapped to number 212
# has_generated_invisible_primary_key=0
# at 8506
#260531  3:37:03 server id 1  end_log_pos 8606 CRC32 0x63f3d01d 	Update_rows: table id 212 flags: STMT_END_F

BINLOG '
XzwbahMBAAAASQAAADohAAAAANQAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAhJdevg==
Xzwbah8BAAAAZAAAAJ4hAAAAANQAAAAAAAEAAgAI//+ACwAAAAYAAAAIAAAACgAAAIAACyIAAAAA
AAAAAAAACwAAAAYAAAAIAAAACgAAAIAACyIACgAAAAAAAAAHAAAAHdDzYw==
'/*!*/;
# at 8606
#260531  3:37:03 server id 1  end_log_pos 8706 CRC32 0x3e2acc07 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 8706
#260531  3:37:03 server id 1  end_log_pos 9066 CRC32 0x54837c93 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
XzwbahMBAAAAZAAAAAIiAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8AB8wqPg==
Xzwbah8BAAAAaAEAAGojAAAAAMAAAAAAAAEAAgAP/////wBYCAAAAA4ARWxlY3RyaWMgRHJpbGwM
Mjc0NDY3NjgxNjExBVRvb2xzKQAAAIAACDQAgAALIgAFQm9zY2gyAFJlbGlhYmxlIGRyaWxsIGZv
ciB3b29kLCBtZXRhbCwgYW5kIGNvbmNyZXRlIHdvcmsuKQAvdXBsb2Fkcy9wcm9kLTE3NzkxMjc0
NDc5ODMtMzEyNjgzODEzLnBuZwEKAAAAAFgIAAAADgBFbGVjdHJpYyBEcmlsbAwyNzQ0Njc2ODE2
MTEFVG9vbHMzAAAAgAAINACAAAsiAAVCb3NjaDIAUmVsaWFibGUgZHJpbGwgZm9yIHdvb2QsIG1l
dGFsLCBhbmQgY29uY3JldGUgd29yay4pAC91cGxvYWRzL3Byb2QtMTc3OTEyNzQ0Nzk4My0zMTI2
ODM4MTMucG5nAQoAAACTfINU
'/*!*/;
# at 9066
#260531  3:37:03 server id 1  end_log_pos 9143 CRC32 0x329be3d3 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 9143
#260531  3:37:03 server id 1  end_log_pos 9249 CRC32 0x875d271d 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
XzwbahMBAAAATQAAALcjAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/ANPjmzI=
Xzwbah4BAAAAagAAACEkAAAAAL8AAAAAAAEAAgAF/wBWAwAABQAAAA1SZWNlaXZlIE9yZGVyKQBS
ZWNlaXZlZC9VcGRhdGVkIFBPLTYgKFN0YXR1czogQ29tcGxldGVkKZm5/jlDHSddhw==
'/*!*/;
# at 9249
#260531  3:37:03 server id 1  end_log_pos 9280 CRC32 0xa3f0ce1b 	Xid = 6078
COMMIT/*!*/;
# at 9280
#260531  3:40:29 server id 1  end_log_pos 9359 CRC32 0x96b16c4b 	Anonymous_GTID	last_committed=11	sequence_number=12	rbr_only=yes	original_committed_timestamp=1780170029966373	immediate_commit_timestamp=1780170029966373	transaction_length=379
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780170029966373 (2026-05-31 03:40:29.966373 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780170029966373 (2026-05-31 03:40:29.966373 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780170029966373*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 9359
#260531  3:40:29 server id 1  end_log_pos 9447 CRC32 0x8e7f64e0 	Query	thread_id=118	exec_time=0	error_code=0
SET TIMESTAMP=1780170029/*!*/;
BEGIN
/*!*/;
# at 9447
#260531  3:40:29 server id 1  end_log_pos 9524 CRC32 0xf67cc96b 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 9524
#260531  3:40:29 server id 1  end_log_pos 9628 CRC32 0x4e796360 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
LT0bahMBAAAATQAAADQlAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AGvJfPY=
LT0bah4BAAAAaAAAAJwlAAAAAL8AAAAAAAEAAgAF/wBXAwAABQAAAAVMb2dpbi8AQXNpZSBzd2l0
Y2hlZCBmcm9tIEludmVudG9yeSB2aWV3IHRvIFNhbGVzIHZpZXeZuf46HWBjeU4=
'/*!*/;
# at 9628
#260531  3:40:29 server id 1  end_log_pos 9659 CRC32 0x63520a58 	Xid = 6100
COMMIT/*!*/;
# at 9659
#260531  3:57:40 server id 1  end_log_pos 9736 CRC32 0xa603efe0 	Anonymous_GTID	last_committed=12	sequence_number=13	rbr_only=no	original_committed_timestamp=1780171060742701	immediate_commit_timestamp=1780171060742701	transaction_length=237
# original_commit_timestamp=1780171060742701 (2026-05-31 03:57:40.742701 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171060742701 (2026-05-31 03:57:40.742701 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171060742701*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 9736
#260531  3:57:40 server id 1  end_log_pos 9896 CRC32 0xa3c28890 	Query	thread_id=121	exec_time=0	error_code=0	Xid = 6171
SET TIMESTAMP=1780171060/*!*/;
SET @@session.sql_mode=1168113696/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE purchase_order 
ADD COLUMN shipToAddress TEXT NULL
/*!*/;
# at 9896
#260531  3:58:10 server id 1  end_log_pos 9975 CRC32 0x5b49d957 	Anonymous_GTID	last_committed=13	sequence_number=14	rbr_only=no	original_committed_timestamp=1780171090484451	immediate_commit_timestamp=1780171090484451	transaction_length=256
# original_commit_timestamp=1780171090484451 (2026-05-31 03:58:10.484451 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171090484451 (2026-05-31 03:58:10.484451 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171090484451*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 9975
#260531  3:58:10 server id 1  end_log_pos 10152 CRC32 0x6e7913da 	Query	thread_id=121	exec_time=0	error_code=0	Xid = 6173
SET TIMESTAMP=1780171090/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE purchase_order 
MODIFY COLUMN amountPaid DECIMAL(10,2) DEFAULT 0.00
/*!*/;
# at 10152
#260531  3:58:27 server id 1  end_log_pos 10231 CRC32 0xa965bfc7 	Anonymous_GTID	last_committed=14	sequence_number=15	rbr_only=no	original_committed_timestamp=1780171107606552	immediate_commit_timestamp=1780171107606552	transaction_length=748
# original_commit_timestamp=1780171107606552 (2026-05-31 03:58:27.606552 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171107606552 (2026-05-31 03:58:27.606552 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171107606552*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 10231
#260531  3:58:27 server id 1  end_log_pos 10900 CRC32 0x8a7155ea 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171107/*!*/;
SET @@session.sql_mode=1168113704/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=224,@@session.collation_connection=224,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS payment_log (
            paymentID INT AUTO_INCREMENT PRIMARY KEY,
            transactionCode VARCHAR(50) NOT NULL,
            dueDate DATE NULL,
            amountDue DECIMAL(12,2) DEFAULT 0.00,
            cashAmount DECIMAL(12,2) DEFAULT 0.00,
            digitalAmount DECIMAL(12,2) DEFAULT 0.00,
            paymentDate DATETIME NULL,
            paymentMethod VARCHAR(50) NULL,
            referenceNumber VARCHAR(100) NULL,
            status VARCHAR(20) DEFAULT 'Scheduled',
            paymentType VARCHAR(20) DEFAULT 'Installment'
        )
/*!*/;
# at 10900
#260531  3:58:40 server id 1  end_log_pos 10979 CRC32 0xfa03ee6b 	Anonymous_GTID	last_committed=15	sequence_number=16	rbr_only=yes	original_committed_timestamp=1780171120126923	immediate_commit_timestamp=1780171120126923	transaction_length=360
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171120126923 (2026-05-31 03:58:40.126923 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171120126923 (2026-05-31 03:58:40.126923 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171120126923*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 10979
#260531  3:58:40 server id 1  end_log_pos 11067 CRC32 0x2a55009c 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171120/*!*/;
BEGIN
/*!*/;
# at 11067
#260531  3:58:40 server id 1  end_log_pos 11144 CRC32 0x5dbe3cc1 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 11144
#260531  3:58:40 server id 1  end_log_pos 11229 CRC32 0x2707103b 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
cEEbahMBAAAATQAAAIgrAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AME8vl0=
cEEbah4BAAAAVQAAAN0rAAAAAL8AAAAAAAEAAgAF/wBYAwAABQAAAAVMb2dpbhwAQXNpZSBVc2Vy
IGxvZ2dlZCBpbiBhcyBBZG1pbpm5/j6oOxAHJw==
'/*!*/;
# at 11229
#260531  3:58:40 server id 1  end_log_pos 11260 CRC32 0x9fd1a0c6 	Xid = 6176
COMMIT/*!*/;
# at 11260
#260531  3:58:49 server id 1  end_log_pos 11339 CRC32 0xf8e081f4 	Anonymous_GTID	last_committed=16	sequence_number=17	rbr_only=yes	original_committed_timestamp=1780171129142230	immediate_commit_timestamp=1780171129142230	transaction_length=458
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171129142230 (2026-05-31 03:58:49.142230 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171129142230 (2026-05-31 03:58:49.142230 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171129142230*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 11339
#260531  3:58:49 server id 1  end_log_pos 11429 CRC32 0x1100a5e3 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171129/*!*/;
BEGIN
/*!*/;
# at 11429
#260531  3:58:49 server id 1  end_log_pos 11533 CRC32 0xb2ea9f70 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 11533
#260531  3:58:49 server id 1  end_log_pos 11687 CRC32 0x27e48b55 	Write_rows: table id 215 flags: STMT_END_F

BINLOG '
eUEbahMBAAAAaAAAAA0tAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AHCf6rI=
eUEbah4BAAAAmgAAAKctAAAAANcAAAAAAAEAAgAP//9gJw0AAAAFAAAAAgAAAJm5/j6xAQGAAAAA
AAFZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBKdWFuLApUYXl0YXksIFJpemFsLCBQaGls
aXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02ODAyVYvkJw==
'/*!*/;
# at 11687
#260531  3:58:49 server id 1  end_log_pos 11718 CRC32 0xbd7439b0 	Xid = 6188
COMMIT/*!*/;
# at 11718
#260531  3:58:49 server id 1  end_log_pos 11797 CRC32 0x58449454 	Anonymous_GTID	last_committed=17	sequence_number=18	rbr_only=yes	original_committed_timestamp=1780171129157801	immediate_commit_timestamp=1780171129157801	transaction_length=358
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171129157801 (2026-05-31 03:58:49.157801 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171129157801 (2026-05-31 03:58:49.157801 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171129157801*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 11797
#260531  3:58:49 server id 1  end_log_pos 11877 CRC32 0x001433cd 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171129/*!*/;
BEGIN
/*!*/;
# at 11877
#260531  3:58:49 server id 1  end_log_pos 11950 CRC32 0xf2631007 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 11950
#260531  3:58:49 server id 1  end_log_pos 12045 CRC32 0x953f9643 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
eUEbahMBAAAASQAAAK4uAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEABxBj8g==
eUEbah4BAAAAXwAAAA0vAAAAANgAAAAAAAEAAgAI/4AcAAAADQAAAAUAAAAKAAAAgAAD1AAAAAAA
AAAAAIAdAAAADQAAABMAAAAKAAAAgAAA7gAAAAAAAAAAAEOWP5U=
'/*!*/;
# at 12045
#260531  3:58:49 server id 1  end_log_pos 12076 CRC32 0xcc1b3635 	Xid = 6189
COMMIT/*!*/;
# at 12076
#260531  3:58:49 server id 1  end_log_pos 12155 CRC32 0x8a1472c0 	Anonymous_GTID	last_committed=18	sequence_number=19	rbr_only=yes	original_committed_timestamp=1780171129163635	immediate_commit_timestamp=1780171129163635	transaction_length=382
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171129163635 (2026-05-31 03:58:49.163635 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171129163635 (2026-05-31 03:58:49.163635 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171129163635*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 12155
#260531  3:58:49 server id 1  end_log_pos 12243 CRC32 0x1ee2d6ea 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171129/*!*/;
BEGIN
/*!*/;
# at 12243
#260531  3:58:49 server id 1  end_log_pos 12320 CRC32 0x1387be64 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 12320
#260531  3:58:49 server id 1  end_log_pos 12427 CRC32 0x9a91e874 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
eUEbahMBAAAATQAAACAwAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AGS+hxM=
eUEbah4BAAAAawAAAIswAAAAAL8AAAAAAAEAAgAF/wBZAwAABQAAAAxBdXRvIFJlb3JkZXIrAEF1
dG8tY3JlYXRlZCBQTy0xMyBmb3IgUmFjaGVsbGUgKDIgaXRlbShzKSmZuf4+sXTokZo=
'/*!*/;
# at 12427
#260531  3:58:49 server id 1  end_log_pos 12458 CRC32 0xaa52e66d 	Xid = 6190
COMMIT/*!*/;
# at 12458
#260531  3:58:49 server id 1  end_log_pos 12537 CRC32 0x4c5304d4 	Anonymous_GTID	last_committed=19	sequence_number=20	rbr_only=yes	original_committed_timestamp=1780171129168467	immediate_commit_timestamp=1780171129168467	transaction_length=458
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171129168467 (2026-05-31 03:58:49.168467 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171129168467 (2026-05-31 03:58:49.168467 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171129168467*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 12537
#260531  3:58:49 server id 1  end_log_pos 12627 CRC32 0x5f5b817e 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171129/*!*/;
BEGIN
/*!*/;
# at 12627
#260531  3:58:49 server id 1  end_log_pos 12731 CRC32 0x0b606cfd 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 12731
#260531  3:58:49 server id 1  end_log_pos 12885 CRC32 0xdf39cba6 	Write_rows: table id 215 flags: STMT_END_F

BINLOG '
eUEbahMBAAAAaAAAALsxAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AP1sYAs=
eUEbah4BAAAAmgAAAFUyAAAAANcAAAAAAAEAAgAP//9gJw4AAAAFAAAAAwAAAJm5/j6xAQGAAAAA
AAFZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBKdWFuLApUYXl0YXksIFJpemFsLCBQaGls
aXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02ODAypss53w==
'/*!*/;
# at 12885
#260531  3:58:49 server id 1  end_log_pos 12916 CRC32 0x69472247 	Xid = 6191
COMMIT/*!*/;
# at 12916
#260531  3:58:49 server id 1  end_log_pos 12995 CRC32 0x3ae6a3a7 	Anonymous_GTID	last_committed=20	sequence_number=21	rbr_only=yes	original_committed_timestamp=1780171129172950	immediate_commit_timestamp=1780171129172950	transaction_length=328
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171129172950 (2026-05-31 03:58:49.172950 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171129172950 (2026-05-31 03:58:49.172950 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171129172950*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 12995
#260531  3:58:49 server id 1  end_log_pos 13075 CRC32 0x01e42caa 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171129/*!*/;
BEGIN
/*!*/;
# at 13075
#260531  3:58:49 server id 1  end_log_pos 13148 CRC32 0xfa6195e4 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 13148
#260531  3:58:49 server id 1  end_log_pos 13213 CRC32 0xc8e1fd0f 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
eUEbahMBAAAASQAAAFwzAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA5JVh+g==
eUEbah4BAAAAQQAAAJ0zAAAAANgAAAAAAAEAAgAI/4AeAAAADgAAABYAAAAKAAAAgAAA7gAAAAAA
AAAAAA/94cg=
'/*!*/;
# at 13213
#260531  3:58:49 server id 1  end_log_pos 13244 CRC32 0xe0d9de60 	Xid = 6192
COMMIT/*!*/;
# at 13244
#260531  3:58:49 server id 1  end_log_pos 13323 CRC32 0x97c8152b 	Anonymous_GTID	last_committed=21	sequence_number=22	rbr_only=yes	original_committed_timestamp=1780171129178086	immediate_commit_timestamp=1780171129178086	transaction_length=378
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171129178086 (2026-05-31 03:58:49.178086 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171129178086 (2026-05-31 03:58:49.178086 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171129178086*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 13323
#260531  3:58:49 server id 1  end_log_pos 13411 CRC32 0x8cbc2bf1 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171129/*!*/;
BEGIN
/*!*/;
# at 13411
#260531  3:58:49 server id 1  end_log_pos 13488 CRC32 0xaffbfe02 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 13488
#260531  3:58:49 server id 1  end_log_pos 13591 CRC32 0x60a1df89 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
eUEbahMBAAAATQAAALA0AAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AAL++68=
eUEbah4BAAAAZwAAABc1AAAAAL8AAAAAAAEAAgAF/wBaAwAABQAAAAxBdXRvIFJlb3JkZXInAEF1
dG8tY3JlYXRlZCBQTy0xNCBmb3IgSm9zZSAoMSBpdGVtKHMpKZm5/j6xid+hYA==
'/*!*/;
# at 13591
#260531  3:58:49 server id 1  end_log_pos 13622 CRC32 0xddd2345a 	Xid = 6193
COMMIT/*!*/;
# at 13622
#260531  3:58:59 server id 1  end_log_pos 13701 CRC32 0xff09ab56 	Anonymous_GTID	last_committed=22	sequence_number=23	rbr_only=yes	original_committed_timestamp=1780171139650727	immediate_commit_timestamp=1780171139650727	transaction_length=458
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171139650727 (2026-05-31 03:58:59.650727 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171139650727 (2026-05-31 03:58:59.650727 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171139650727*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 13701
#260531  3:58:59 server id 1  end_log_pos 13791 CRC32 0x3c5e408e 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171139/*!*/;
BEGIN
/*!*/;
# at 13791
#260531  3:58:59 server id 1  end_log_pos 13895 CRC32 0xf6d7221c 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 13895
#260531  3:58:59 server id 1  end_log_pos 14049 CRC32 0x345eeeef 	Write_rows: table id 215 flags: STMT_END_F

BINLOG '
g0EbahMBAAAAaAAAAEc2AAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/ABwi1/Y=
g0Ebah4BAAAAmgAAAOE2AAAAANcAAAAAAAEAAgAP//9gJw8AAAAFAAAAAgAAAJm5/j7AAQGAAAAA
AAFZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBKdWFuLApUYXl0YXksIFJpemFsLCBQaGls
aXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02ODAy7+5eNA==
'/*!*/;
# at 14049
#260531  3:58:59 server id 1  end_log_pos 14080 CRC32 0x6d2d6fe7 	Xid = 6195
COMMIT/*!*/;
# at 14080
#260531  3:58:59 server id 1  end_log_pos 14159 CRC32 0xa249e0a1 	Anonymous_GTID	last_committed=23	sequence_number=24	rbr_only=yes	original_committed_timestamp=1780171139655527	immediate_commit_timestamp=1780171139655527	transaction_length=358
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171139655527 (2026-05-31 03:58:59.655527 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171139655527 (2026-05-31 03:58:59.655527 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171139655527*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 14159
#260531  3:58:59 server id 1  end_log_pos 14239 CRC32 0x6a710be7 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171139/*!*/;
BEGIN
/*!*/;
# at 14239
#260531  3:58:59 server id 1  end_log_pos 14312 CRC32 0xfd90a2d8 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 14312
#260531  3:58:59 server id 1  end_log_pos 14407 CRC32 0x120abff7 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
g0EbahMBAAAASQAAAOg3AAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA2KKQ/Q==
g0Ebah4BAAAAXwAAAEc4AAAAANgAAAAAAAEAAgAI/4AfAAAADwAAAAUAAAAKAAAAgAAD1AAAAAAA
AAAAAIAgAAAADwAAABMAAAAKAAAAgAAA7gAAAAAAAAAAAPe/ChI=
'/*!*/;
# at 14407
#260531  3:58:59 server id 1  end_log_pos 14438 CRC32 0x34877754 	Xid = 6196
COMMIT/*!*/;
# at 14438
#260531  3:58:59 server id 1  end_log_pos 14517 CRC32 0x11a1b936 	Anonymous_GTID	last_committed=24	sequence_number=25	rbr_only=yes	original_committed_timestamp=1780171139662129	immediate_commit_timestamp=1780171139662129	transaction_length=382
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171139662129 (2026-05-31 03:58:59.662129 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171139662129 (2026-05-31 03:58:59.662129 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171139662129*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 14517
#260531  3:58:59 server id 1  end_log_pos 14605 CRC32 0x0d1905f8 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171139/*!*/;
BEGIN
/*!*/;
# at 14605
#260531  3:58:59 server id 1  end_log_pos 14682 CRC32 0x76d0ffa1 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 14682
#260531  3:58:59 server id 1  end_log_pos 14789 CRC32 0x7c2dab52 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
g0EbahMBAAAATQAAAFo5AAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AKH/0HY=
g0Ebah4BAAAAawAAAMU5AAAAAL8AAAAAAAEAAgAF/wBbAwAABQAAAAxBdXRvIFJlb3JkZXIrAEF1
dG8tY3JlYXRlZCBQTy0xNSBmb3IgUmFjaGVsbGUgKDIgaXRlbShzKSmZuf4+u1KrLXw=
'/*!*/;
# at 14789
#260531  3:58:59 server id 1  end_log_pos 14820 CRC32 0x47a68500 	Xid = 6197
COMMIT/*!*/;
# at 14820
#260531  3:58:59 server id 1  end_log_pos 14899 CRC32 0x166e57cc 	Anonymous_GTID	last_committed=25	sequence_number=26	rbr_only=yes	original_committed_timestamp=1780171139665671	immediate_commit_timestamp=1780171139665671	transaction_length=458
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171139665671 (2026-05-31 03:58:59.665671 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171139665671 (2026-05-31 03:58:59.665671 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171139665671*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 14899
#260531  3:58:59 server id 1  end_log_pos 14989 CRC32 0xd3d6e796 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171139/*!*/;
BEGIN
/*!*/;
# at 14989
#260531  3:58:59 server id 1  end_log_pos 15093 CRC32 0x8835272e 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 15093
#260531  3:58:59 server id 1  end_log_pos 15247 CRC32 0x00522784 	Write_rows: table id 215 flags: STMT_END_F

BINLOG '
g0EbahMBAAAAaAAAAPU6AAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AC4nNYg=
g0Ebah4BAAAAmgAAAI87AAAAANcAAAAAAAEAAgAP//9gJxAAAAAFAAAAAwAAAJm5/j7AAQGAAAAA
AAFZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBKdWFuLApUYXl0YXksIFJpemFsLCBQaGls
aXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02ODAyhCdSAA==
'/*!*/;
# at 15247
#260531  3:58:59 server id 1  end_log_pos 15278 CRC32 0x3afb1ac2 	Xid = 6198
COMMIT/*!*/;
# at 15278
#260531  3:58:59 server id 1  end_log_pos 15357 CRC32 0x73f8134d 	Anonymous_GTID	last_committed=26	sequence_number=27	rbr_only=yes	original_committed_timestamp=1780171139669276	immediate_commit_timestamp=1780171139669276	transaction_length=328
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171139669276 (2026-05-31 03:58:59.669276 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171139669276 (2026-05-31 03:58:59.669276 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171139669276*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 15357
#260531  3:58:59 server id 1  end_log_pos 15437 CRC32 0x07285eea 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171139/*!*/;
BEGIN
/*!*/;
# at 15437
#260531  3:58:59 server id 1  end_log_pos 15510 CRC32 0xffcebef4 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 15510
#260531  3:58:59 server id 1  end_log_pos 15575 CRC32 0x48cc608c 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
g0EbahMBAAAASQAAAJY8AAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA9L7O/w==
g0Ebah4BAAAAQQAAANc8AAAAANgAAAAAAAEAAgAI/4AhAAAAEAAAABYAAAAKAAAAgAAA7gAAAAAA
AAAAAIxgzEg=
'/*!*/;
# at 15575
#260531  3:58:59 server id 1  end_log_pos 15606 CRC32 0x9f70c9af 	Xid = 6199
COMMIT/*!*/;
# at 15606
#260531  3:58:59 server id 1  end_log_pos 15685 CRC32 0x76389d8b 	Anonymous_GTID	last_committed=27	sequence_number=28	rbr_only=yes	original_committed_timestamp=1780171139672619	immediate_commit_timestamp=1780171139672619	transaction_length=378
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171139672619 (2026-05-31 03:58:59.672619 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171139672619 (2026-05-31 03:58:59.672619 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171139672619*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 15685
#260531  3:58:59 server id 1  end_log_pos 15773 CRC32 0xbc0cad0a 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171139/*!*/;
BEGIN
/*!*/;
# at 15773
#260531  3:58:59 server id 1  end_log_pos 15850 CRC32 0xfceb1fb1 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 15850
#260531  3:58:59 server id 1  end_log_pos 15953 CRC32 0x4c43c786 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
g0EbahMBAAAATQAAAOo9AAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/ALEf6/w=
g0Ebah4BAAAAZwAAAFE+AAAAAL8AAAAAAAEAAgAF/wBcAwAABQAAAAxBdXRvIFJlb3JkZXInAEF1
dG8tY3JlYXRlZCBQTy0xNiBmb3IgSm9zZSAoMSBpdGVtKHMpKZm5/j67hsdDTA==
'/*!*/;
# at 15953
#260531  3:58:59 server id 1  end_log_pos 15984 CRC32 0x5dbdca1c 	Xid = 6200
COMMIT/*!*/;
# at 15984
#260531  3:59:32 server id 1  end_log_pos 16063 CRC32 0xdc7f3395 	Anonymous_GTID	last_committed=28	sequence_number=29	rbr_only=yes	original_committed_timestamp=1780171172858068	immediate_commit_timestamp=1780171172858068	transaction_length=873
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171172858068 (2026-05-31 03:59:32.858068 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171172858068 (2026-05-31 03:59:32.858068 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171172858068*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 16063
#260531  3:59:32 server id 1  end_log_pos 16154 CRC32 0x13b2f192 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171172/*!*/;
BEGIN
/*!*/;
# at 16154
#260531  3:59:32 server id 1  end_log_pos 16258 CRC32 0x68ef7172 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 16258
#260531  3:59:32 server id 1  end_log_pos 16550 CRC32 0x4136793e 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
pEEbahMBAAAAaAAAAII/AAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AHJx72g=
pEEbah8BAAAAJAEAAKZAAAAAANcAAAAAAAEAAgAP/////2AnEAAAAAUAAAADAAAAmbn+PsABAYAA
AAAAAVkAIzIgTmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4sClRheXRheSwgUml6YWwsIFBo
aWxpcHBpbmVzClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDJABxAAAAAFAAAAAwAAAJm5/j7A
AgsAMDk3ODc2NTQ2NTYBgAAAAAABAwBDT0RZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBK
dWFuLApUYXl0YXksIFJpemFsLCBQaGlsaXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02
ODAyPnk2QQ==
'/*!*/;
# at 16550
#260531  3:59:32 server id 1  end_log_pos 16623 CRC32 0x44aae8a6 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 16623
#260531  3:59:32 server id 1  end_log_pos 16688 CRC32 0xec172198 	Delete_rows: table id 216 flags: STMT_END_F

BINLOG '
pEEbahMBAAAASQAAAO9AAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEApuiqRA==
pEEbaiABAAAAQQAAADBBAAAAANgAAAAAAAEAAgAI/4AhAAAAEAAAABYAAAAKAAAAgAAA7gAAAAAA
AAAAAJghF+w=
'/*!*/;
# at 16688
#260531  3:59:32 server id 1  end_log_pos 16761 CRC32 0x38f6d1fd 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 16761
#260531  3:59:32 server id 1  end_log_pos 16826 CRC32 0xb94aeb04 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
pEEbahMBAAAASQAAAHlBAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA/dH2OA==
pEEbah4BAAAAQQAAALpBAAAAANgAAAAAAAEAAgAI/4AiAAAAEAAAABYAAAAKAAAAgAAA7gAAAAAA
AAAAAATrSrk=
'/*!*/;
# at 16826
#260531  3:59:32 server id 1  end_log_pos 16857 CRC32 0xfd5b9140 	Xid = 6209
COMMIT/*!*/;
# at 16857
#260531  3:59:43 server id 1  end_log_pos 16936 CRC32 0x2d18ae38 	Anonymous_GTID	last_committed=29	sequence_number=30	rbr_only=yes	original_committed_timestamp=1780171183718900	immediate_commit_timestamp=1780171183718900	transaction_length=907
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171183718900 (2026-05-31 03:59:43.718900 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171183718900 (2026-05-31 03:59:43.718900 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171183718900*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 16936
#260531  3:59:43 server id 1  end_log_pos 17027 CRC32 0xd760a8ce 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171183/*!*/;
BEGIN
/*!*/;
# at 17027
#260531  3:59:43 server id 1  end_log_pos 17131 CRC32 0x40d2d158 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 17131
#260531  3:59:43 server id 1  end_log_pos 17427 CRC32 0xd327913e 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
r0EbahMBAAAAaAAAAOtCAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AFjR0kA=
r0Ebah8BAAAAKAEAABNEAAAAANcAAAAAAAEAAgAP/////2AnDwAAAAUAAAACAAAAmbn+PsABAYAA
AAAAAVkAIzIgTmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4sClRheXRheSwgUml6YWwsIFBo
aWxpcHBpbmVzClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDJABw8AAAAFAAAAAwAAAJm5/j7A
AgsAMDk3ODc2NTQ2NTYBgAAAAAABBwAxNSBEYXlzWQAjMiBOYXRpb25hbCBSb2FkLCBCcmd5LiBT
YW4gSnVhbiwKVGF5dGF5LCBSaXphbCwgUGhpbGlwcGluZXMKUGhvbmU6IDg2NTgtNzk4NCAvIDg2
NTgtNjgwMj6RJ9M=
'/*!*/;
# at 17427
#260531  3:59:43 server id 1  end_log_pos 17500 CRC32 0x479afa24 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 17500
#260531  3:59:43 server id 1  end_log_pos 17595 CRC32 0x0f691606 	Delete_rows: table id 216 flags: STMT_END_F

BINLOG '
r0EbahMBAAAASQAAAFxEAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAJPqaRw==
r0EbaiABAAAAXwAAALtEAAAAANgAAAAAAAEAAgAI/4AfAAAADwAAAAUAAAAKAAAAgAAD1AAAAAAA
AAAAAIAgAAAADwAAABMAAAAKAAAAgAAA7gAAAAAAAAAAAAYWaQ8=
'/*!*/;
# at 17595
#260531  3:59:43 server id 1  end_log_pos 17668 CRC32 0x83910079 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 17668
#260531  3:59:43 server id 1  end_log_pos 17733 CRC32 0xc800c432 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
r0EbahMBAAAASQAAAARFAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAeQCRgw==
r0Ebah4BAAAAQQAAAEVFAAAAANgAAAAAAAEAAgAI/4AjAAAADwAAABMAAAAKAAAAgAAA7gAAAAAA
AAAAADLEAMg=
'/*!*/;
# at 17733
#260531  3:59:43 server id 1  end_log_pos 17764 CRC32 0x8404cedd 	Xid = 6221
COMMIT/*!*/;
# at 17764
#260531  3:59:52 server id 1  end_log_pos 17843 CRC32 0xf3f0b03e 	Anonymous_GTID	last_committed=30	sequence_number=31	rbr_only=yes	original_committed_timestamp=1780171192117504	immediate_commit_timestamp=1780171192117504	transaction_length=873
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171192117504 (2026-05-31 03:59:52.117504 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171192117504 (2026-05-31 03:59:52.117504 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171192117504*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 17843
#260531  3:59:52 server id 1  end_log_pos 17934 CRC32 0x7610d81a 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171192/*!*/;
BEGIN
/*!*/;
# at 17934
#260531  3:59:52 server id 1  end_log_pos 18038 CRC32 0x6a04fb8e 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 18038
#260531  3:59:52 server id 1  end_log_pos 18330 CRC32 0xba8973a6 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
uEEbahMBAAAAaAAAAHZGAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AI77BGo=
uEEbah8BAAAAJAEAAJpHAAAAANcAAAAAAAEAAgAP/////2AnDgAAAAUAAAADAAAAmbn+PrEBAYAA
AAAAAVkAIzIgTmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4sClRheXRheSwgUml6YWwsIFBo
aWxpcHBpbmVzClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDJABw4AAAAFAAAAAwAAAJm5/j6x
AgsAMDk3ODc2NTQ2NTYBgAAAAAABAwBDT0RZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBK
dWFuLApUYXl0YXksIFJpemFsLCBQaGlsaXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02
ODAypnOJug==
'/*!*/;
# at 18330
#260531  3:59:52 server id 1  end_log_pos 18403 CRC32 0xf108d8af 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 18403
#260531  3:59:52 server id 1  end_log_pos 18468 CRC32 0x35f61778 	Delete_rows: table id 216 flags: STMT_END_F

BINLOG '
uEEbahMBAAAASQAAAONHAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAr9gI8Q==
uEEbaiABAAAAQQAAACRIAAAAANgAAAAAAAEAAgAI/4AeAAAADgAAABYAAAAKAAAAgAAA7gAAAAAA
AAAAAHgX9jU=
'/*!*/;
# at 18468
#260531  3:59:52 server id 1  end_log_pos 18541 CRC32 0x64b970dc 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 18541
#260531  3:59:52 server id 1  end_log_pos 18606 CRC32 0xfd58502c 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
uEEbahMBAAAASQAAAG1IAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA3HC5ZA==
uEEbah4BAAAAQQAAAK5IAAAAANgAAAAAAAEAAgAI/4AkAAAADgAAABYAAAAKAAAAgAAA7gAAAAAA
AAAAACxQWP0=
'/*!*/;
# at 18606
#260531  3:59:52 server id 1  end_log_pos 18637 CRC32 0x573914db 	Xid = 6233
COMMIT/*!*/;
# at 18637
#260531  3:59:57 server id 1  end_log_pos 18716 CRC32 0x4694c77d 	Anonymous_GTID	last_committed=31	sequence_number=32	rbr_only=yes	original_committed_timestamp=1780171197568215	immediate_commit_timestamp=1780171197568215	transaction_length=907
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171197568215 (2026-05-31 03:59:57.568215 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171197568215 (2026-05-31 03:59:57.568215 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171197568215*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 18716
#260531  3:59:57 server id 1  end_log_pos 18807 CRC32 0x328e70cd 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171197/*!*/;
BEGIN
/*!*/;
# at 18807
#260531  3:59:57 server id 1  end_log_pos 18911 CRC32 0x856f269f 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 18911
#260531  3:59:57 server id 1  end_log_pos 19207 CRC32 0x38e7f92d 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
vUEbahMBAAAAaAAAAN9JAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AJ8mb4U=
vUEbah8BAAAAKAEAAAdLAAAAANcAAAAAAAEAAgAP/////2AnDQAAAAUAAAACAAAAmbn+PrEBAYAA
AAAAAVkAIzIgTmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4sClRheXRheSwgUml6YWwsIFBo
aWxpcHBpbmVzClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDJABw0AAAAFAAAAAwAAAJm5/j6x
AQsAMDk3ODc2NTQ2NTYBgAAAAAABBwAxNSBEYXlzWQAjMiBOYXRpb25hbCBSb2FkLCBCcmd5LiBT
YW4gSnVhbiwKVGF5dGF5LCBSaXphbCwgUGhpbGlwcGluZXMKUGhvbmU6IDg2NTgtNzk4NCAvIDg2
NTgtNjgwMi355zg=
'/*!*/;
# at 19207
#260531  3:59:57 server id 1  end_log_pos 19280 CRC32 0xb446ab82 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 19280
#260531  3:59:57 server id 1  end_log_pos 19375 CRC32 0x49799570 	Delete_rows: table id 216 flags: STMT_END_F

BINLOG '
vUEbahMBAAAASQAAAFBLAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAgqtGtA==
vUEbaiABAAAAXwAAAK9LAAAAANgAAAAAAAEAAgAI/4AcAAAADQAAAAUAAAAKAAAAgAAD1AAAAAAA
AAAAAIAdAAAADQAAABMAAAAKAAAAgAAA7gAAAAAAAAAAAHCVeUk=
'/*!*/;
# at 19375
#260531  3:59:57 server id 1  end_log_pos 19448 CRC32 0x4daf9ad0 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 19448
#260531  3:59:57 server id 1  end_log_pos 19513 CRC32 0x0d60aded 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
vUEbahMBAAAASQAAAPhLAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA0JqvTQ==
vUEbah4BAAAAQQAAADlMAAAAANgAAAAAAAEAAgAI/4AlAAAADQAAABMAAAAKAAAAgAAA7gAAAAAA
AAAAAO2tYA0=
'/*!*/;
# at 19513
#260531  3:59:57 server id 1  end_log_pos 19544 CRC32 0x2b4df598 	Xid = 6245
COMMIT/*!*/;
# at 19544
#260531  4:00:08 server id 1  end_log_pos 19623 CRC32 0x5a82983b 	Anonymous_GTID	last_committed=32	sequence_number=33	rbr_only=yes	original_committed_timestamp=1780171208896945	immediate_commit_timestamp=1780171208896945	transaction_length=899
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171208896945 (2026-05-31 04:00:08.896945 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171208896945 (2026-05-31 04:00:08.896945 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171208896945*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 19623
#260531  4:00:08 server id 1  end_log_pos 19714 CRC32 0x6b17f1a6 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171208/*!*/;
BEGIN
/*!*/;
# at 19714
#260531  4:00:08 server id 1  end_log_pos 19818 CRC32 0xf6239431 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 19818
#260531  4:00:08 server id 1  end_log_pos 20136 CRC32 0x2c70e819 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
yEEbahMBAAAAaAAAAGpNAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/ADGUI/Y=
yEEbah8BAAAAPgEAAKhOAAAAANcAAAAAAAEAAgAP/////0AHDQAAAAUAAAADAAAAmbn+PrEBCwAw
OTc4NzY1NDY1NgGAAAAAAAEHADE1IERheXNZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBK
dWFuLApUYXl0YXksIFJpemFsLCBQaGlsaXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02
ODAyQAcNAAAABQAAAAMAAACZuf4+sQILADA5Nzg3NjU0NjU2AYAAAAAAAQcAMTUgRGF5c1kAIzIg
TmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4sClRheXRheSwgUml6YWwsIFBoaWxpcHBpbmVz
ClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDIZ6HAs
'/*!*/;
# at 20136
#260531  4:00:08 server id 1  end_log_pos 20209 CRC32 0x92dc0717 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 20209
#260531  4:00:08 server id 1  end_log_pos 20274 CRC32 0x5212fc30 	Delete_rows: table id 216 flags: STMT_END_F

BINLOG '
yEEbahMBAAAASQAAAPFOAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAFwfckg==
yEEbaiABAAAAQQAAADJPAAAAANgAAAAAAAEAAgAI/4AlAAAADQAAABMAAAAKAAAAgAAA7gAAAAAA
AAAAADD8ElI=
'/*!*/;
# at 20274
#260531  4:00:08 server id 1  end_log_pos 20347 CRC32 0x765cd499 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 20347
#260531  4:00:08 server id 1  end_log_pos 20412 CRC32 0xf18885dc 	Write_rows: table id 216 flags: STMT_END_F

BINLOG '
yEEbahMBAAAASQAAAHtPAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAmdRcdg==
yEEbah4BAAAAQQAAALxPAAAAANgAAAAAAAEAAgAI/4AmAAAADQAAABMAAAAKAAAAgAAA7gAAAAAA
AAAAANyFiPE=
'/*!*/;
# at 20412
#260531  4:00:08 server id 1  end_log_pos 20443 CRC32 0xde974a50 	Xid = 6257
COMMIT/*!*/;
# at 20443
#260531  4:00:33 server id 1  end_log_pos 20522 CRC32 0x0a836b6f 	Anonymous_GTID	last_committed=33	sequence_number=34	rbr_only=yes	original_committed_timestamp=1780171233576991	immediate_commit_timestamp=1780171233576991	transaction_length=1364
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171233576991 (2026-05-31 04:00:33.576991 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171233576991 (2026-05-31 04:00:33.576991 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171233576991*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 20522
#260531  4:00:33 server id 1  end_log_pos 20613 CRC32 0x5fc15544 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171233/*!*/;
BEGIN
/*!*/;
# at 20613
#260531  4:00:33 server id 1  end_log_pos 20717 CRC32 0xc5e451ee 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 20717
#260531  4:00:33 server id 1  end_log_pos 21027 CRC32 0xfd02cd26 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
4UEbahMBAAAAaAAAAO1QAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AO5R5MU=
4UEbah8BAAAANgEAACNSAAAAANcAAAAAAAEAAgAP/////0AHEAAAAAUAAAADAAAAmbn+PsACCwAw
OTc4NzY1NDY1NgGAAAAAAAEDAENPRFkAIzIgTmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4s
ClRheXRheSwgUml6YWwsIFBoaWxpcHBpbmVzClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDJA
BxAAAAAFAAAAAwAAAJm5/j7ABAsAMDk3ODc2NTQ2NTYBgAAAAAABAwBDT0RZACMyIE5hdGlvbmFs
IFJvYWQsIEJyZ3kuIFNhbiBKdWFuLApUYXl0YXksIFJpemFsLCBQaGlsaXBwaW5lcwpQaG9uZTog
ODY1OC03OTg0IC8gODY1OC02ODAyJs0C/Q==
'/*!*/;
# at 21027
#260531  4:00:33 server id 1  end_log_pos 21100 CRC32 0xb9be3c92 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 21100
#260531  4:00:33 server id 1  end_log_pos 21200 CRC32 0x86357400 	Update_rows: table id 216 flags: STMT_END_F

BINLOG '
4UEbahMBAAAASQAAAGxSAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAkjy+uQ==
4UEbah8BAAAAZAAAANBSAAAAANgAAAAAAAEAAgAI//+AIgAAABAAAAAWAAAACgAAAIAAAO4AAAAA
AAAAAAAAIgAAABAAAAAWAAAACgAAAIAAAO4ACgAAAAAAAAAAAAAAAHQ1hg==
'/*!*/;
# at 21200
#260531  4:00:33 server id 1  end_log_pos 21300 CRC32 0xfb04a433 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 21300
#260531  4:00:33 server id 1  end_log_pos 21592 CRC32 0x5d5ebada 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
4UEbahMBAAAAZAAAADRTAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8AM6QE+w==
4UEbah8BAAAAJAEAAFhUAAAAAMAAAAAAAAEAAgAP/////wBaFgAAAC8AQm95c2VuIFF1aWNrIERy
eWluZyBFbmFtZWwgLSBJdm9yeSBCNjIxIC0gMS8yIEwMMTE2ODk5MDM3OTc4BlBhaW50cwgAAACA
AADoAIAAAO4ABkJveXNlbhgAUGFpbnQgZm9yIHdvb2QgYW5kIHN0ZWVsAQoAAAAAWhYAAAAvAEJv
eXNlbiBRdWljayBEcnlpbmcgRW5hbWVsIC0gSXZvcnkgQjYyMSAtIDEvMiBMDDExNjg5OTAzNzk3
OAZQYWludHMSAAAAgAAA6ACAAADuAAZCb3lzZW4YAFBhaW50IGZvciB3b29kIGFuZCBzdGVlbAEK
AAAA2rpeXQ==
'/*!*/;
# at 21592
#260531  4:00:33 server id 1  end_log_pos 21669 CRC32 0xd607b3e1 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 21669
#260531  4:00:33 server id 1  end_log_pos 21776 CRC32 0x8eec55b6 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
4UEbahMBAAAATQAAAKVUAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AOGzB9Y=
4UEbah4BAAAAawAAABBVAAAAAL8AAAAAAAEAAgAF/wBdAwAABQAAAA1SZWNlaXZlIE9yZGVyKgBS
ZWNlaXZlZC9VcGRhdGVkIFBPLTE2IChTdGF0dXM6IENvbXBsZXRlZCmZuf5AIbZV7I4=
'/*!*/;
# at 21776
#260531  4:00:33 server id 1  end_log_pos 21807 CRC32 0x7527ee97 	Xid = 6295
COMMIT/*!*/;
# at 21807
#260531  4:00:40 server id 1  end_log_pos 21886 CRC32 0x53e88135 	Anonymous_GTID	last_committed=34	sequence_number=35	rbr_only=yes	original_committed_timestamp=1780171240661399	immediate_commit_timestamp=1780171240661399	transaction_length=1364
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171240661399 (2026-05-31 04:00:40.661399 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171240661399 (2026-05-31 04:00:40.661399 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171240661399*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 21886
#260531  4:00:40 server id 1  end_log_pos 21977 CRC32 0x00c6904a 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171240/*!*/;
BEGIN
/*!*/;
# at 21977
#260531  4:00:40 server id 1  end_log_pos 22081 CRC32 0xde34db7b 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 22081
#260531  4:00:40 server id 1  end_log_pos 22391 CRC32 0x2af0a237 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
6EEbahMBAAAAaAAAAEFWAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AHvbNN4=
6EEbah8BAAAANgEAAHdXAAAAANcAAAAAAAEAAgAP/////0AHDgAAAAUAAAADAAAAmbn+PrECCwAw
OTc4NzY1NDY1NgGAAAAAAAEDAENPRFkAIzIgTmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4s
ClRheXRheSwgUml6YWwsIFBoaWxpcHBpbmVzClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDJA
Bw4AAAAFAAAAAwAAAJm5/j6xBAsAMDk3ODc2NTQ2NTYBgAAAAAABAwBDT0RZACMyIE5hdGlvbmFs
IFJvYWQsIEJyZ3kuIFNhbiBKdWFuLApUYXl0YXksIFJpemFsLCBQaGlsaXBwaW5lcwpQaG9uZTog
ODY1OC03OTg0IC8gODY1OC02ODAyN6LwKg==
'/*!*/;
# at 22391
#260531  4:00:40 server id 1  end_log_pos 22464 CRC32 0x5795bd15 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 22464
#260531  4:00:40 server id 1  end_log_pos 22564 CRC32 0x9a606b0f 	Update_rows: table id 216 flags: STMT_END_F

BINLOG '
6EEbahMBAAAASQAAAMBXAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAFb2VVw==
6EEbah8BAAAAZAAAACRYAAAAANgAAAAAAAEAAgAI//+AJAAAAA4AAAAWAAAACgAAAIAAAO4AAAAA
AAAAAAAAJAAAAA4AAAAWAAAACgAAAIAAAO4ACgAAAAAAAAAAAAAAD2tgmg==
'/*!*/;
# at 22564
#260531  4:00:40 server id 1  end_log_pos 22664 CRC32 0x1ce43fed 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 22664
#260531  4:00:40 server id 1  end_log_pos 22956 CRC32 0x67556b42 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
6EEbahMBAAAAZAAAAIhYAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8A7T/kHA==
6EEbah8BAAAAJAEAAKxZAAAAAMAAAAAAAAEAAgAP/////wBaFgAAAC8AQm95c2VuIFF1aWNrIERy
eWluZyBFbmFtZWwgLSBJdm9yeSBCNjIxIC0gMS8yIEwMMTE2ODk5MDM3OTc4BlBhaW50cxIAAACA
AADoAIAAAO4ABkJveXNlbhgAUGFpbnQgZm9yIHdvb2QgYW5kIHN0ZWVsAQoAAAAAWhYAAAAvAEJv
eXNlbiBRdWljayBEcnlpbmcgRW5hbWVsIC0gSXZvcnkgQjYyMSAtIDEvMiBMDDExNjg5OTAzNzk3
OAZQYWludHMcAAAAgAAA6ACAAADuAAZCb3lzZW4YAFBhaW50IGZvciB3b29kIGFuZCBzdGVlbAEK
AAAAQmtVZw==
'/*!*/;
# at 22956
#260531  4:00:40 server id 1  end_log_pos 23033 CRC32 0x13cbecb1 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 23033
#260531  4:00:40 server id 1  end_log_pos 23140 CRC32 0xad0cdcf9 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
6EEbahMBAAAATQAAAPlZAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/ALHsyxM=
6EEbah4BAAAAawAAAGRaAAAAAL8AAAAAAAEAAgAF/wBeAwAABQAAAA1SZWNlaXZlIE9yZGVyKgBS
ZWNlaXZlZC9VcGRhdGVkIFBPLTE0IChTdGF0dXM6IENvbXBsZXRlZCmZuf5AKPncDK0=
'/*!*/;
# at 23140
#260531  4:00:40 server id 1  end_log_pos 23171 CRC32 0xd919aa84 	Xid = 6305
COMMIT/*!*/;
# at 23171
#260531  4:00:48 server id 1  end_log_pos 23250 CRC32 0xab541ba4 	Anonymous_GTID	last_committed=35	sequence_number=36	rbr_only=yes	original_committed_timestamp=1780171248960889	immediate_commit_timestamp=1780171248960889	transaction_length=1352
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171248960889 (2026-05-31 04:00:48.960889 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171248960889 (2026-05-31 04:00:48.960889 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171248960889*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 23250
#260531  4:00:48 server id 1  end_log_pos 23341 CRC32 0x9402e633 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171248/*!*/;
BEGIN
/*!*/;
# at 23341
#260531  4:00:48 server id 1  end_log_pos 23445 CRC32 0xe0356940 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 23445
#260531  4:00:48 server id 1  end_log_pos 23763 CRC32 0x9c20b4a3 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
8EEbahMBAAAAaAAAAJVbAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/AEBpNeA=
8EEbah8BAAAAPgEAANNcAAAAANcAAAAAAAEAAgAP/////0AHDwAAAAUAAAADAAAAmbn+PsACCwAw
OTc4NzY1NDY1NgGAAAAAAAEHADE1IERheXNZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBK
dWFuLApUYXl0YXksIFJpemFsLCBQaGlsaXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02
ODAyQAcPAAAABQAAAAMAAACZuf4+wAQLADA5Nzg3NjU0NjU2AYAAAAAAAQcAMTUgRGF5c1kAIzIg
TmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4sClRheXRheSwgUml6YWwsIFBoaWxpcHBpbmVz
ClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDKjtCCc
'/*!*/;
# at 23763
#260531  4:00:48 server id 1  end_log_pos 23836 CRC32 0x7a009f82 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 23836
#260531  4:00:48 server id 1  end_log_pos 23936 CRC32 0x5a2eb665 	Update_rows: table id 216 flags: STMT_END_F

BINLOG '
8EEbahMBAAAASQAAABxdAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEAgp8Aeg==
8EEbah8BAAAAZAAAAIBdAAAAANgAAAAAAAEAAgAI//+AIwAAAA8AAAATAAAACgAAAIAAAO4AAAAA
AAAAAAAAIwAAAA8AAAATAAAACgAAAIAAAO4ACgAAAAAAAAAAAAAAZbYuWg==
'/*!*/;
# at 23936
#260531  4:00:48 server id 1  end_log_pos 24036 CRC32 0x341c96c8 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 24036
#260531  4:00:48 server id 1  end_log_pos 24308 CRC32 0x7890b379 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
8EEbahMBAAAAZAAAAORdAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8AyJYcNA==
8EEbah8BAAAAEAEAAPReAAAAAMAAAAAAAAEAAgAP/////wBaEwAAACUAQm95c2VuIFF1aWNrIERy
eWluZyBFbmFtZWwgV2hpdGUgQjYwMAw3NDM5NzU2Mzc4MzEGUGFpbnRzBwAAAIAAAOkAgAAA7gAG
Qm95c2VuGABQYWludCBmb3Igd29vZCBhbmQgc3RlZWwBCgAAAABaEwAAACUAQm95c2VuIFF1aWNr
IERyeWluZyBFbmFtZWwgV2hpdGUgQjYwMAw3NDM5NzU2Mzc4MzEGUGFpbnRzEQAAAIAAAOkAgAAA
7gAGQm95c2VuGABQYWludCBmb3Igd29vZCBhbmQgc3RlZWwBCgAAAHmzkHg=
'/*!*/;
# at 24308
#260531  4:00:48 server id 1  end_log_pos 24385 CRC32 0x04db61a3 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 24385
#260531  4:00:48 server id 1  end_log_pos 24492 CRC32 0x39779c8b 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
8EEbahMBAAAATQAAAEFfAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AKNh2wQ=
8EEbah4BAAAAawAAAKxfAAAAAL8AAAAAAAEAAgAF/wBfAwAABQAAAA1SZWNlaXZlIE9yZGVyKgBS
ZWNlaXZlZC9VcGRhdGVkIFBPLTE1IChTdGF0dXM6IENvbXBsZXRlZCmZuf5AMIucdzk=
'/*!*/;
# at 24492
#260531  4:00:48 server id 1  end_log_pos 24523 CRC32 0xbbe09147 	Xid = 6315
COMMIT/*!*/;
# at 24523
#260531  4:00:55 server id 1  end_log_pos 24602 CRC32 0xff156e9f 	Anonymous_GTID	last_committed=36	sequence_number=37	rbr_only=yes	original_committed_timestamp=1780171255539901	immediate_commit_timestamp=1780171255539901	transaction_length=1352
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171255539901 (2026-05-31 04:00:55.539901 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171255539901 (2026-05-31 04:00:55.539901 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171255539901*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 24602
#260531  4:00:55 server id 1  end_log_pos 24693 CRC32 0xdf53f966 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171255/*!*/;
BEGIN
/*!*/;
# at 24693
#260531  4:00:55 server id 1  end_log_pos 24797 CRC32 0x8a0b81d2 	Table_map: `udicon_db`.`purchase_order` mapped to number 215
# has_generated_invisible_primary_key=0
# at 24797
#260531  4:00:55 server id 1  end_log_pos 25115 CRC32 0x50a722cc 	Update_rows: table id 215 flags: STMT_END_F

BINLOG '
90EbahMBAAAAaAAAAN1gAAAAANcAAAAAAAMACXVkaWNvbl9kYgAOcHVyY2hhc2Vfb3JkZXIADwMD
AxL+Dw/+Dw8S9gEP/BMA9wGQAfwD9wHIAJABAAoCkAEC4G8BAQACA/z/ANKBC4o=
90Ebah8BAAAAPgEAABtiAAAAANcAAAAAAAEAAgAP/////0AHDQAAAAUAAAADAAAAmbn+PrECCwAw
OTc4NzY1NDY1NgGAAAAAAAEHADE1IERheXNZACMyIE5hdGlvbmFsIFJvYWQsIEJyZ3kuIFNhbiBK
dWFuLApUYXl0YXksIFJpemFsLCBQaGlsaXBwaW5lcwpQaG9uZTogODY1OC03OTg0IC8gODY1OC02
ODAyQAcNAAAABQAAAAMAAACZuf4+sQQLADA5Nzg3NjU0NjU2AYAAAAAAAQcAMTUgRGF5c1kAIzIg
TmF0aW9uYWwgUm9hZCwgQnJneS4gU2FuIEp1YW4sClRheXRheSwgUml6YWwsIFBoaWxpcHBpbmVz
ClBob25lOiA4NjU4LTc5ODQgLyA4NjU4LTY4MDLMIqdQ
'/*!*/;
# at 25115
#260531  4:00:55 server id 1  end_log_pos 25188 CRC32 0x2d5f14ee 	Table_map: `udicon_db`.`purchase_item` mapped to number 216
# has_generated_invisible_primary_key=0
# at 25188
#260531  4:00:55 server id 1  end_log_pos 25288 CRC32 0xe375e279 	Update_rows: table id 216 flags: STMT_END_F

BINLOG '
90EbahMBAAAASQAAAGRiAAAAANgAAAAAAAEACXVkaWNvbl9kYgANcHVyY2hhc2VfaXRlbQAIAwMD
A/YDAwMCCgKAAQEA7hRfLQ==
90Ebah8BAAAAZAAAAMhiAAAAANgAAAAAAAEAAgAI//+AJgAAAA0AAAATAAAACgAAAIAAAO4AAAAA
AAAAAAAAJgAAAA0AAAATAAAACgAAAIAAAO4ACgAAAAAAAAAAAAAAeeJ14w==
'/*!*/;
# at 25288
#260531  4:00:55 server id 1  end_log_pos 25388 CRC32 0xfd8efd6b 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 25388
#260531  4:00:55 server id 1  end_log_pos 25660 CRC32 0x5251933d 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
90EbahMBAAAAZAAAACxjAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8Aa/2O/Q==
90Ebah8BAAAAEAEAADxkAAAAAMAAAAAAAAEAAgAP/////wBaEwAAACUAQm95c2VuIFF1aWNrIERy
eWluZyBFbmFtZWwgV2hpdGUgQjYwMAw3NDM5NzU2Mzc4MzEGUGFpbnRzEQAAAIAAAOkAgAAA7gAG
Qm95c2VuGABQYWludCBmb3Igd29vZCBhbmQgc3RlZWwBCgAAAABaEwAAACUAQm95c2VuIFF1aWNr
IERyeWluZyBFbmFtZWwgV2hpdGUgQjYwMAw3NDM5NzU2Mzc4MzEGUGFpbnRzGwAAAIAAAOkAgAAA
7gAGQm95c2VuGABQYWludCBmb3Igd29vZCBhbmQgc3RlZWwBCgAAAD2TUVI=
'/*!*/;
# at 25660
#260531  4:00:55 server id 1  end_log_pos 25737 CRC32 0xda5cb8a5 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 25737
#260531  4:00:55 server id 1  end_log_pos 25844 CRC32 0x5e4b15db 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
90EbahMBAAAATQAAAIlkAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AKW4XNo=
90Ebah4BAAAAawAAAPRkAAAAAL8AAAAAAAEAAgAF/wBgAwAABQAAAA1SZWNlaXZlIE9yZGVyKgBS
ZWNlaXZlZC9VcGRhdGVkIFBPLTEzIChTdGF0dXM6IENvbXBsZXRlZCmZuf5AN9sVS14=
'/*!*/;
# at 25844
#260531  4:00:55 server id 1  end_log_pos 25875 CRC32 0xaa034598 	Xid = 6325
COMMIT/*!*/;
# at 25875
#260531  4:01:13 server id 1  end_log_pos 25954 CRC32 0xceefca09 	Anonymous_GTID	last_committed=37	sequence_number=38	rbr_only=yes	original_committed_timestamp=1780171273275280	immediate_commit_timestamp=1780171273275280	transaction_length=375
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171273275280 (2026-05-31 04:01:13.275280 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171273275280 (2026-05-31 04:01:13.275280 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171273275280*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 25954
#260531  4:01:13 server id 1  end_log_pos 26042 CRC32 0x944dc0af 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171273/*!*/;
BEGIN
/*!*/;
# at 26042
#260531  4:01:13 server id 1  end_log_pos 26119 CRC32 0xbdbbddf9 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 26119
#260531  4:01:13 server id 1  end_log_pos 26219 CRC32 0xd04bcf75 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
CUIbahMBAAAATQAAAAdmAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/APndu70=
CUIbah4BAAAAZAAAAGtmAAAAAL8AAAAAAAEAAgAF/wBhAwAABQAAAAVMb2dpbisAQXNpZSBzd2l0
Y2hlZCBmcm9tIEFkbWluIHZpZXcgdG8gU2FsZXMgdmlld5m5/kBNdc9L0A==
'/*!*/;
# at 26219
#260531  4:01:13 server id 1  end_log_pos 26250 CRC32 0xbdc5ef17 	Xid = 6348
COMMIT/*!*/;
# at 26250
#260531  4:05:33 server id 1  end_log_pos 26329 CRC32 0x37fde544 	Anonymous_GTID	last_committed=38	sequence_number=39	rbr_only=yes	original_committed_timestamp=1780171533508961	immediate_commit_timestamp=1780171533508961	transaction_length=988
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171533508961 (2026-05-31 04:05:33.508961 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171533508961 (2026-05-31 04:05:33.508961 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171533508961*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 26329
#260531  4:05:33 server id 1  end_log_pos 26419 CRC32 0x4b816a6a 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171533/*!*/;
BEGIN
/*!*/;
# at 26419
#260531  4:05:33 server id 1  end_log_pos 26529 CRC32 0xc554dfce 	Table_map: `udicon_db`.`sales_transaction` mapped to number 195
# has_generated_invisible_primary_key=0
# at 26529
#260531  4:05:33 server id 1  end_log_pos 26622 CRC32 0x18f58fe2 	Write_rows: table id 195 flags: STMT_END_F

BINLOG '
DUMbahMBAAAAbgAAAKFnAAAAAMMAAAAAAAMACXVkaWNvbl9kYgARc2FsZXNfdHJhbnNhY3Rpb24A
DwMDDxL29g/29v4PDw/8ChaQAQAKAgoCyAAKAgoC9wGQAfwD/AMCpH8BAQACA/z/AM7fVMU=
DUMbah4BAAAAXQAAAP5nAAAAAMMAAAAAAAEAAgAP//8AfHUAAAAFAAAADgBVVC0wNTMxMjYtMDAw
MZm5/kFhgAAA7gCAAAAAAARDYXNogAAA7gCAAAAAAAHij/UY
'/*!*/;
# at 26622
#260531  4:05:33 server id 1  end_log_pos 26703 CRC32 0x30c4737d 	Table_map: `udicon_db`.`sales_item` mapped to number 196
# has_generated_invisible_primary_key=0
# at 26703
#260531  4:05:33 server id 1  end_log_pos 26815 CRC32 0xfcfa66f1 	Write_rows: table id 196 flags: STMT_END_F

BINLOG '
DUMbahMBAAAAUQAAAE9oAAAAAMQAAAAAAAEACXVkaWNvbl9kYgAKc2FsZXNfaXRlbQAIAwMDA/YP
9v4ICgLoAwoC9wHgAQEAAgP8/wB9c8Qw
DUMbah4BAAAAcAAAAL9oAAAAAMQAAAAAAAEAAgAI/wAYAQAAdQAAABcAAAABAAAAgAAA7gAvAEJv
eXNlbiBRdWljayBEcnlpbmcgRW5hbWVsIC0gQmxhY2sgQjY5MCAtIDEvMiBMgAAA7gAB8Wb6/A==
'/*!*/;
# at 26815
#260531  4:05:33 server id 1  end_log_pos 26915 CRC32 0xd8e16b0d 	Table_map: `udicon_db`.`product` mapped to number 192
# has_generated_invisible_primary_key=0
# at 26915
#260531  4:05:33 server id 1  end_log_pos 27207 CRC32 0x5c14c580 	Update_rows: table id 192 flags: STMT_END_F

BINLOG '
DUMbahMBAAAAZAAAACNpAAAAAMAAAAAAAAMACXVkaWNvbl9kYgAHcHJvZHVjdAAPAw8PDwP29g8P
DwEPDwMPFugDyADIAAoCCgLIAOgD/AOQAZAB/AOgXwEBAAID/P8ADWvh2A==
DUMbah8BAAAAJAEAAEdqAAAAAMAAAAAAAAEAAgAP/////wBaFwAAAC8AQm95c2VuIFF1aWNrIERy
eWluZyBFbmFtZWwgLSBCbGFjayBCNjkwIC0gMS8yIEwMMTE2ODk5MDY2MzEzBlBhaW50cxQAAACA
AADoAIAAAO4ABkJveXNlbhgAUGFpbnQgZm9yIHdvb2QgYW5kIHN0ZWVsAQoAAAAAWhcAAAAvAEJv
eXNlbiBRdWljayBEcnlpbmcgRW5hbWVsIC0gQmxhY2sgQjY5MCAtIDEvMiBMDDExNjg5OTA2NjMx
MwZQYWludHMTAAAAgAAA6ACAAADuAAZCb3lzZW4YAFBhaW50IGZvciB3b29kIGFuZCBzdGVlbAEK
AAAAgMUUXA==
'/*!*/;
# at 27207
#260531  4:05:33 server id 1  end_log_pos 27238 CRC32 0x764c5c10 	Xid = 6367
COMMIT/*!*/;
# at 27238
#260531  4:05:33 server id 1  end_log_pos 27317 CRC32 0x213571d7 	Anonymous_GTID	last_committed=39	sequence_number=40	rbr_only=yes	original_committed_timestamp=1780171533512729	immediate_commit_timestamp=1780171533512729	transaction_length=391
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171533512729 (2026-05-31 04:05:33.512729 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171533512729 (2026-05-31 04:05:33.512729 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171533512729*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 27317
#260531  4:05:33 server id 1  end_log_pos 27405 CRC32 0xa996349d 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171533/*!*/;
BEGIN
/*!*/;
# at 27405
#260531  4:05:33 server id 1  end_log_pos 27500 CRC32 0x9fa1ccac 	Table_map: `udicon_db`.`payment_log` mapped to number 203
# has_generated_invisible_primary_key=0
# at 27500
#260531  4:05:33 server id 1  end_log_pos 27598 CRC32 0xc41ea10a 	Write_rows: table id 203 flags: STMT_END_F

BINLOG '
DUMbahMBAAAAXwAAAGxrAAAAAMsAAAAAAAEACXVkaWNvbl9kYgALcGF5bWVudF9sb2cACwMPCvb2
9hIPDw8PEcgADAIMAgwCAMgAkAFQAFAA/AcBAQACA/z/AKzMoZ8=
DUMbah4BAAAAYgAAAM5rAAAAAMsAAAAAAAEAAgAL//8EAR8AAAAOVVQtMDUzMTI2LTAwMDGAAAAA
AACAAAAA7gCAAAAAAACZuf5BYQRDYXNoBFBhaWQHSW5pdGlhbAqhHsQ=
'/*!*/;
# at 27598
#260531  4:05:33 server id 1  end_log_pos 27629 CRC32 0xbf361eb1 	Xid = 6372
COMMIT/*!*/;
# at 27629
#260531  4:05:33 server id 1  end_log_pos 27708 CRC32 0xf43d1269 	Anonymous_GTID	last_committed=40	sequence_number=41	rbr_only=yes	original_committed_timestamp=1780171533517370	immediate_commit_timestamp=1780171533517370	transaction_length=384
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1780171533517370 (2026-05-31 04:05:33.517370 Malay Peninsula Standard Time)
# immediate_commit_timestamp=1780171533517370 (2026-05-31 04:05:33.517370 Malay Peninsula Standard Time)
/*!80001 SET @@session.original_commit_timestamp=1780171533517370*//*!*/;
/*!80014 SET @@session.original_server_version=80046*//*!*/;
/*!80014 SET @@session.immediate_server_version=80046*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 27708
#260531  4:05:33 server id 1  end_log_pos 27796 CRC32 0x4e6be23f 	Query	thread_id=122	exec_time=0	error_code=0
SET TIMESTAMP=1780171533/*!*/;
BEGIN
/*!*/;
# at 27796
#260531  4:05:33 server id 1  end_log_pos 27873 CRC32 0x04d5969c 	Table_map: `udicon_db`.`activity_log` mapped to number 191
# has_generated_invisible_primary_key=0
# at 27873
#260531  4:05:33 server id 1  end_log_pos 27982 CRC32 0xdf9b9166 	Write_rows: table id 191 flags: STMT_END_F

BINLOG '
DUMbahMBAAAATQAAAOFsAAAAAL8AAAAAAAEACXVkaWNvbl9kYgAMYWN0aXZpdHlfbG9nAAUDAw8P
EgXIANAHAAgBAQACA/z/AJyW1QQ=
DUMbah4BAAAAbQAAAE5tAAAAAL8AAAAAAAEAAgAF/wBiAwAABQAAAARTYWxlNQBUcmFuc2FjdGlv
biBVVC0wNTMxMjYtMDAwMSAtIEFtb3VudDog4oKxMjM4LjAwIC0gQ2FzaJm5/kFhZpGb3w==
'/*!*/;
# at 27982
#260531  4:05:33 server id 1  end_log_pos 28013 CRC32 0x500a2e10 	Xid = 6373
COMMIT/*!*/;
# at 28013
#260531  7:30:00 server id 1  end_log_pos 28070 CRC32 0x4de449e2 	Rotate to LAPTOP-75O597VJ-bin.000303  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
