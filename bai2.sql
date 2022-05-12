----use master
----create login sv1 with password = 'thanglong'
----exec sp_addsrvrolemember 'sv1', 'securityadmin'

----create login [PC9502\sv2] from windows

----use PhanQuyen
----create user sv1db for login sv1
----exec sp_addrolemember 'db_backupoperator' , 'sv1db'
----exec sp_addrolemember 'db_accessadmin' , 'sv1db'

----grant select, insert, update, delete on HT_User to sv1db
----grant select, insert, update, delete on HT_RoleUser to sv1db

----grant create any database to sv1db with grant option
----grant backup any database to sv1db with grant option


---- bai 2:
---- cấp quyền tạo bảng cho SinhVien1
----use phanquyen
--grant create table to sv1db with grant option 

----execute as user = 'sv1db'
----select * from fn_my_permissions (null,'Database')
----revert
----select USER_NAME()
---- tạo 
----use master 	
----create login UserA with password = '1'
----use phanquyen
----create user UserA_DB for login UserA 


----create login UserB with password = '1'
----use phanquyen
----create user UserB_DB for login UserB 

---- Trong Sinhvien1
--select * from fn_my_permissions (null,'Database')
--select USER_NAME()
--use PhanQuyen
--grant create table to UserA_DB with grant option


-- -- Trong UserA
------select * from fn_my_permissions (null,'Database')
----select UoptionSER_NAME()
--grant create table to UserB_DB with grant option

 
---- Trong UserB
--select * from fn_my_permissions (null,'Database')


---- Thu hồi quyền
----use phanquyen 
--revoke create table to SinhVien1_DB cascade

