USE QLBH_1004_TEST
GO
/*
Câu 1:In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
*/
USE QLBH_1004_TEST
GO
select SANPHAM.MASP, SANPHAM.TENSP from SANPHAM
/*
Câu 2:In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
*/
select SANPHAM.MASP, SANPHAM.TENSP, SANPHAM.DVT  from SANPHAM
where SANPHAM.DVT in('cay','quyen')
/*
Câu 3:In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
*/
select SANPHAM.MASP, SANPHAM.TENSP from SANPHAM
where SANPHAM.MASP lIKE  'B%01'
/*
Câu 4:In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến
40.000.
*/
select SANPHAM.MASP, SANPHAM.TENSP from SANPHAM
where SANPHAM.NUOCSX='Trung Quoc' 
and SANPHAM.GIA between 30000 and 40000
/*
Câu 5:In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ
30.000 đến 40.000.
*/

select SANPHAM.MASP, SANPHAM.TENSP from SANPHAM
where SANPHAM.NUOCSX in ('Trung Quoc' ,'Thai Lan')
and SANPHAM.GIA between 30000 and 40000
/*
Câu 6:In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
*/
select*from HOADON
select HOADON.SOHD, HOADON.TRIGIA from HOADON
where HOADON.NGHD in ('2007-1-1','2007-1-2')
/*
Câu 7:In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của
hóa đơn (giảm dần).
*/
select HOADON.SOHD, HOADON.TRIGIA from HOADON
where MONTH(NGHD)=1 and YEAR(NGHD)=2007
ORDER BY DAY(NGHD) ASC, HOADON.TRIGIA DESC
/*
Câu 8:In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
*/
SELECT*FROM KHACHHANG
SELECT*FROM HOADON
SELECT KHACHHANG.MAKH,KHACHHANG.HOTEN FROM KHACHHANG
inner join HOADON on KHACHHANG.MAKH=HOADON.MAKH
WHERE HOADON.NGHD='2007-1-1'
/*
Câu 9:In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày
28/10/2006.
*/
SELECT*FROM HOADON
SELECT*FROM NHANVIEN
SELECT H.SOHD,H.TRIGIA FROM HOADON H 
INNER JOIN NHANVIEN N ON H.MANV= N.MANV
WHERE N.HOTEN='Nguyen Van B' AND H.NGHD='2006-10-28'
/*
Câu 10:In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong
tháng 10/2006.
*/
SELECT*FROM KHACHHANG K 
INNER JOIN HOADON H ON K.MAKH=H.MAKH
WHERE K.HOTEN='Nguyen Van A' AND MONTH(H.NGHD)=10 AND YEAR(H.NGHD)=2006
/*
Câu 11:Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
*/
SELECT*FROM CTHD
SELECT C.SOHD FROM CTHD C
INNER JOIN SANPHAM S ON C.MASP=S.MASP
WHERE S.MASP IN ('BB01','BB02')
/*
Câu 12:Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số
lượng từ 10 đến 20.
*/
SELECT C.SOHD FROM CTHD C
INNER JOIN SANPHAM S ON C.MASP=S.MASP
WHERE S.MASP IN ('BB01','BB02')
AND C.SL BETWEEN 10 AND 20
/*
Câu 13:Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với
số lượng từ 10 đến 20.
*/
SELECT A.SOHD FROM CTHD A
WHERE A.MASP='BB01' AND A.SL BETWEEN 10 AND 20
AND EXISTS( SELECT B.SOHD FROM CTHD B 
WHERE B.MASP='BB02' AND B.SL BETWEEN 10 AND 20 AND A.SOHD=B.SOHD)
/*
Câu 14:In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được
bán ra trong ngày 1/1/2007.
*/
SELECT*FROM HOADON
SELECT*FROM CTHD
SELECT DISTINCT S.MASP,S.TENSP FROM SANPHAM S
INNER JOIN CTHD C1 ON S.MASP=C1.MASP 
WHERE S.NUOCSX='Trung Quoc' 
AND C1.SOHD IN( SELECT DISTINCT C2.SOHD FROM CTHD C2 INNER JOIN HOADON H ON C2.SOHD=H.SOHD WHERE H.NGHD='2007-1-1')
/*
Câu 15:In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
*/
SELECT SANPHAM.MASP, SANPHAM.TENSP FROM SANPHAM
WHERE SANPHAM.MASP NOT IN ( SELECT DISTINCT CTHD.MASP FROM CTHD)
/*
Câu 16:In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
*/
SELECT SANPHAM.MASP, SANPHAM.TENSP FROM SANPHAM
WHERE SANPHAM.MASP NOT IN 
( SELECT DISTINCT C.MASP 
FROM CTHD C INNER JOIN HOADON H ON H.SOHD=C.SOHD
WHERE YEAR(H.NGHD)= '2006')
/*
Câu 17:In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006 do trung quoc san xuat.
*/
SELECT SANPHAM.MASP, SANPHAM.TENSP FROM SANPHAM
WHERE SANPHAM.NUOCSX='Trung Quoc' and SANPHAM.MASP NOT IN 
( SELECT DISTINCT C.MASP 
FROM CTHD C INNER JOIN HOADON H ON H.SOHD=C.SOHD
WHERE YEAR(H.NGHD)= '2006')
/*
Câu 18:Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
*/
SELECT*FROM HOADON
SELECT*FROM CTHD
SELECT*FROM SANPHAM
SELECT H.SOHD  FROM HOADON H 
WHERE NOT EXISTS( SELECT*FROM SANPHAM S WHERE S.NUOCSX='Singapore' AND NOT EXISTS ( SELECT*FROM CTHD C WHERE C.SOHD=H.SOHD AND S.MASP=C.MASP))
SELECT DISTINCT H.SOHD FROM HOADON H, CTHD C1
WHERE C1.SOHD=H.SOHD AND NOT EXISTS((SELECT S.MASP FROM SANPHAM S WHERE S.NUOCSX='Singapore' ) EXCEPT ( SELECT C.MASP FROM CTHD C WHERE C.SOHD=C1.SOHD ))
/*
Câu 19:Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
*/
SELECT H.SOHD
FROM HOADON H
WHERE YEAR(NGHD) = 2006
    AND NOT EXISTS (
        SELECT *
        FROM SANPHAM S
        WHERE NUOCSX = 'SINGAPORE'
            AND NOT EXISTS (
                SELECT *
                FROM CTHD C
                WHERE C.SOHD = H.SOHD AND C.MASP = S.MASP
            )
    );
/*
Câu 20:Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
*/
SELECT COUNT(SOHD) FROM HOADON 
WHERE MAKH IS  NULL
/*
Câu 21:Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
*/

SELECT  COUNT(DISTINCT C.MASP) 
FROM CTHD C, HOADON H WHERE C.SOHD=H.SOHD AND YEAR(H.NGHD)=2006
/*
Câu 22:Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
*/
SELECT MAX(TRIGIA), MIN(TRIGIA) FROM HOADON 
/*
Câu 23:Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
*/
SELECT AVG(H.TRIGIA) FROM HOADON H WHERE YEAR(H.NGHD)=2006 
/*
Câu 24:Tính doanh thu bán hàng trong năm 2006.
*/
SELECT*FROM SANPHAM
SELECT*FROM HOADON
SELECT*FROM CTHD
SELECT SUM(H.TRIGIA) FROM HOADON H WHERE YEAR(H.NGHD)=2006 
/*
Câu 25:Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
*/
SELECT SOHD
FROM HOADON
WHERE TRIGIA = (SELECT MAX(TRIGIA)
FROM HOADON)
/*
Câu 26:Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
*/
SELECT K.HOTEN FROM KHACHHANG K, HOADON H WHERE K.MAKH=H.MAKH AND YEAR(H.NGHD)=2006 AND H.TRIGIA = (SELECT MAX(TRIGIA)
FROM HOADON)
/*
Câu 27:In ra danh sách 3 khách hàng đầu tiên (MAKH, HOTEN) sắp xếp theo doanh số giảm dần.
*/

SELECT*FROM HOADON
SELECT*FROM CTHD
SELECT TOP 3 KHACHHANG.MAKH, KHACHHANG.HOTEN FROM KHACHHANG 
ORDER BY DOANHSO DESC
/*
Câu 28:In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE GIA IN (SELECT DISTINCT TOP 3 GIA
			  FROM SANPHAM
			  ORDER BY GIA DESC)
SELECT*FROM SANPHAM
/*
Câu 29:In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức
giá cao nhất (của tất cả các sản phẩm).
*/
SELECT*FROM SANPHAM
SELECT S.MASP, S.TENSP FROM SANPHAM S WHERE S.NUOCSX='Thai Lan' and s.GIA in (SELECT DISTINCT TOP 3 GIA
			  FROM SANPHAM
			  ORDER BY GIA DESC)
/*
Câu 30:In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức
giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
*/
SELECT*FROM SANPHAM S WHERE S.NUOCSX='Trung Quoc'
SELECT s.MASP, s.TENSP FROM SANPHAM S WHERE S.NUOCSX='Trung Quoc' and S.GIA in (select TOP 3 S1.GIA from (SELECT*FROM SANPHAM WHERE SANPHAM.NUOCSX='Trung QUOC') AS S1 ORDER BY S1.GIA DESC)

SELECT SANPHAM.MASP, SANPHAM.TENSP
FROM SANPHAM
WHERE SANPHAM.NUOCSX='Trung Quoc' 
AND
SANPHAM.GIA IN
(
SELECT DISTINCT TOP 3 sp.GIA
FROM SANPHAM sp
WHERE sp.NUOCSX = 'Trung Quoc'
ORDER BY sp.GIA DESC
)
/*
Câu 31:In ra danh sách khách hàng nằm trong 3 hạng cao nhất (xếp hạng theo doanh số).
*/
SELECT TOP 3 K.DOANHSO FROM KHACHHANG K
ORDER BY K.DOANHSO DESC
/*
Câu 32:Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
*/
SELECT COUNT(S.MASP) FROM SANPHAM S WHERE  S.NUOCSX='Trung Quoc'
/*
Câu 33:Tính tổng số sản phẩm của từng nước sản xuất.
*/
SELECT*FROM SANPHAM
SELECT COUNT(S.MASP) FROM SANPHAM S
GROUP BY S.NUOCSX
/*
Câu 34:Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
*/
SELECT MAX(S.GIA), MIN(S.GIA), AVG(S.GIA),S.NUOCSX FROM SANPHAM S
GROUP BY S.NUOCSX
/*
Câu 35:Tính doanh thu bán hàng mỗi ngày.
*/
SELECT*FROM SANPHAM
SELECT*FROM KHACHHANG
SELECT*FROM HOADON
SELECT * FROM CTHD
SELECT H.NGHD, SUM(H.TRIGIA) FROM HOADON H 
GROUP BY H.NGHD
ORDER BY H.NGHD
/*
Câu 36:Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
*/
SELECT*FROM CTHD
SELECT*FROM HOADON
SELECT C.MASP,C.SL FROM HOADON H, CTHD C WHERE H.SOHD=C.SOHD AND YEAR(H.NGHD)=2006 AND MONTH(H.NGHD)=10

SELECT ct.MASP, sum(ct.SL)
FROM CTHD ct, HOADON hd
WHERE ct.SOHD=hd.SOHD AND month(NGHD)=10 AND year(NGHD)=2006 
GROUP BY ct.MASP
/*
Câu 37:Tính doanh thu bán hàng của từng tháng trong năm 2006.
*/
SELECT MONTH(H.NGHD),SUM(H.TRIGIA) FROM HOADON  H WHERE YEAR(H.NGHD)=2006
GROUP BY MONTH(H.NGHD)
/*
Câu 38:Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
*/
SELECT C.SOHD FROM CTHD C 
GROUP BY C.SOHD 
HAVING  COUNT(C.MASP)>=4
/*
Câu 39:Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
*/
SELECT C.SOHD FROM CTHD C , SANPHAM S WHERE S.MASP=C.MASP AND S.NUOCSX='Viet Nam'
GROUP BY C.SOHD HAVING COUNT(C.MASP)=3
/*
Câu 40:Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
*/
SELECT TOP 1 HOADON.MAKH, KH.HOTEN
FROM HOADON, KHACHHANG kh
WHERE HOADON.MAKH is not null and HOADON.MAKH = KH.MAKH
GROUP BY HOADON.MAKH, KH.HOTEN
ORDER BY count(HOADON.MAKH) DESC
/*
Câu 41:Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
*/
SELECT MONTH(H.NGHD) ,SUM(H.TRIGIA) FROM HOADON H
WHERE YEAR(H.NGHD)=2006 
GROUP BY MONTH(H.NGHD)
HAVING SUM(H.TRIGIA)>=ALL(SELECT SUM(H.TRIGIA) FROM HOADON H
WHERE YEAR(H.NGHD)=2006 
GROUP BY MONTH(H.NGHD))
/*
Câu 42:Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
*/
SELECT * FROM SANPHAM
SELECT * FROM HOADON
SELECT * FROM CTHD
SELECT TOP 1 S.MASP,S.TENSP FROM HOADON H, CTHD C, SANPHAM S WHERE YEAR(H.NGHD)=2006 AND C.MASP=S.MASP AND H.SOHD=C.SOHD
GROUP BY S.MASP, S.TENSP
ORDER BY SUM(C.SL)


SELECT ct1.MASP, sp.TENSP
FROM CTHD ct1, HOADON hd1, SANPHAM sp 
WHERE ct1.SOHD = hd1.SOHD AND year(hd1.NGHD)=2006 and sp.MASP = ct1.MASP
GROUP BY ct1.MASP, sp.TENSP
HAVING sum(ct1.SL) <= ALL
(
    SELECT sum(ct.SL)
    FROM CTHD ct, HOADON hd 
    WHERE ct.SOHD = hd.SOHD AND year(hd.NGHD)=2006
    GROUP BY ct.MASP
)
/*
Câu 43:*Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
*/
SELECT S1.MASP,S1.TENSP,S1.NUOCSX FROM SANPHAM S1 
WHERE S1.GIA in (SELECT MAX(S2.GIA) FROM SANPHAM S2 WHERE  S1.NUOCSX=S2.NUOCSX)
/*
Câu 44:Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
*/

SELECT sp.NUOCSX
FROM SANPHAM sp
GROUP BY sp.NUOCSX
HAVING count(distinct sp.GIA)>=3
/*
Câu 45:*Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
*/

SELECT TOP 1 K.HOTEN,K.MAKH FROM KHACHHANG K,(SELECT H.MAKH,COUNT(H.SOHD) AS SOLAN FROM HOADON H WHERE H.MAKH IS NOT NULL
GROUP BY H.MAKH) AS N WHERE K.MAKH=N.MAKH
