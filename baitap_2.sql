use Northwind

create login MSV_A1 with password = '1'
create user MSB_A1_DB from login MSV_A1



create login MSV_A2 with password = '1'
create user MSV_A2_DB from login MSV_A2



use master
grant alter any login to MSV_A1 with grant option




go
use Northwind
grant select, insert, update, delete on Customers to MSV_A2_DB 
grant select, insert, update, delete on Products to MSV_A2_DB 

use Northwind

grant control on Employees to MSV_A2_DB with grant option
grant control on Orders to MSV_A2_DB with grant option
grant create table to MSV_A2_DB with grant option

-- phan 2
--- cau 1 ---

go

alter procedure cau1 @CID varchar(5)
as
	declare @MaSp varchar(5), @TenSp varchar(200), @SoLuong int, @TongTien float
	declare cau1Cursor cursor for
		select distinct ProductID, ProductName, UnitsOnOrder, (UnitsOnOrder* UnitPrice) as TotalPrice
		from Products
		where CategoryId = @CID
	open cau1Cursor
	fetch next from cau1Cursor into @MaSp, @TenSp, @SoLuong, @TongTien
	while @@FETCH_STATUS = 0
	begin
		print @MaSp + ', ' + @TenSp +', ' + ', ' +  cast(@SoLuong as varchar(5)) + ', ' + cast(@TongTien as varchar)
		fetch next from cau1Cursor into @MaSp, @TenSp, @SoLuong, @TongTien
	end
	close cau1Cursor
	deallocate cau1Cursor
go

exec cau1 2




--- de 2  phan 2  cau 1
go
use Northwind

create procedure de2 @EID int
as
	declare @MaDon int, @Ngay varchar(10), @SL smallint, @TT float
	declare C1 cursor for
		select distinct O.OrderID, convert(varchar(10), O.OrderDate, 10) as NgayDat, count(OO.Quantity), (OO.Quantity * OO.UnitPrice) as TongTien
		from Orders as O inner join [Order Details] as OO
		on O.OrderID = OO.OrderID
		where O.EmployeeID = @EID
		group by O.OrderID, O.OrderDate, OO.Quantity * OO.UnitPrice
		order by O.OrderID
	open C1
	fetch next from C1 into @MaDon, @Ngay, @SL, @TT
	while @@FETCH_STATUS=0
		begin
			print cast(@MaDon as varchar) + ' ' + @Ngay + ' ' + cast(@SL as varchar) + ' ' + cast(@TT as varchar)
			fetch next from C1 into @MaDon, @Ngay, @SL, @TT
		end
	close C1
	deallocate C1

exec de2 2