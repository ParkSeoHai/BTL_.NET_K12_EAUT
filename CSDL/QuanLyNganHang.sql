﻿CREATE DATABASE QuanLyNganHang
USE QuanLyNganHang 

-- KHACHHANG
CREATE TABLE KHACHHANG (
	MaKH NVARCHAR(20) NOT NULL PRIMARY KEY,
	TenKH NVARCHAR(25),
	CMND NVARCHAR(20) NOT NULL UNIQUE,
	NgaySinh CHAR(25),
	GioiTinh NVARCHAR(5),
	DiaChi NVARCHAR(50),
	SDT VARCHAR(15)
)

-- THONGTINTAIKHOAN
CREATE TABLE THONGTINTAIKHOAN (
	SoTK NVARCHAR(20) NOT NULL PRIMARY KEY,
	SoDu FLOAT CHECK(SoDu >= 0),
	NgayCap VARCHAR(20),
	TenCN NVARCHAR(50),
	LoaiTK NVARCHAR(20),
	MaKH NVARCHAR(20) FOREIGN KEY REFERENCES KHACHHANG(MaKH)
)

-- TAIKHOANDANGNHAP
CREATE TABLE TAIKHOANDANGNHAP(
	MaTK NVARCHAR(20) NOT NULL PRIMARY KEY,
	TenTK NVARCHAR(50),
	MK NVARCHAR(50),
	Email VARCHAR(50),
	MaKH NVARCHAR(20) FOREIGN KEY REFERENCES KHACHHANG(MaKH)
)

-- GIAODICH
CREATE TABLE GIAODICH (
	MaGD NVARCHAR(20) NOT NULL PRIMARY KEY,
	SoTienGD FLOAT,
	NoiDungGD NVARCHAR(50),
	ThoiGianGD VARCHAR(20),
	SoTKNhan NVARCHAR(20) FOREIGN KEY REFERENCES THONGTINTAIKHOAN(SoTK),
	SoTKGui NVARCHAR(20)
)

--TIETKIEM
CREATE TABLE TIETKIEM (
	MaTietKiem NVARCHAR(20) NOT NULL PRIMARY KEY,
	SoTienGui FLOAT,
	NoiDungTK NVARCHAR(50),
	NgayGuiTK VARCHAR(20),
	MaTK NVARCHAR(20) FOREIGN KEY REFERENCES TAIKHOANDANGNHAP(MaTK)
)

--QUANLY
CREATE TABLE QUANLY
(
	MaQL NVARCHAR(20) NOT NULL PRIMARY KEY,
	TenQL NVARCHAR(25),
	CMND NVARCHAR(20) NOT NULL UNIQUE,
	NgaySinh VARCHAR(20),
	GioiTinh NVARCHAR(5),
	DiaChi NVARCHAR(50),
	SDT VARCHAR(15),
)

INSERT INTO QUANLY VALUES ('QL001', 'Nguyễn Văn A', '0203937223', '20/10/2003', N'Nam', N'Hà Nội', '09226382')

--QUANLYKHACHHANG
CREATE TABLE QUANLYKHACHHANG (
	MaKH NVARCHAR(20) FOREIGN KEY REFERENCES KHACHHANG(MaKH),
	MaQL NVARCHAR(20) FOREIGN KEY REFERENCES QUANLY(MaQL),
	PRIMARY KEY(MaKH, MaQL)
)

SELECT * FROM KHACHHANG
SELECT * FROM THONGTINTAIKHOAN
SELECT * FROM QUANLY
SELECT * FROM TAIKHOANDANGNHAP
SELECT * FROM TIETKIEM 
SELECT * FROM GIAODICH
SELECT * FROM QUANLYKHACHHANG

SELECT TenTK, MK FROM TAIKHOANDANGNHAP

INSERT INTO THONGTINTAIKHOAN VALUES('0928273', '100000', '02/08/2003', 'KH0003')

-- LẤY TÊN KH THUỘC QUẢN LÝ CỦA QL001
SELECT KHACHHANG.MaKH, TenKH FROM KHACHHANG, QUANLY, QUANLYKHACHHANG WHERE KHACHHANG.MaKH = QUANLYKHACHHANG.MaKH 
AND QUANLY.MaQL = QUANLYKHACHHANG.MaQL AND QUANLY.MaQL = 'QL001'

-- Thêm bảng khách hàng, thông tin tài khoản, tài khoản đăng nhập, quản lý khách hàng
-- Random: MaKH, SoTK: CMND, MaTK, MatKhau
--------------------------------------------------Các Thủ Tục Stored Procedured----------------
CREATE PROC HIENTHITHONGTINKHACHHANG
@MaKH varchar(20)
AS
	BEGIN 
		SELECT * FROM KHACHHANG where KHACHHANG.MaKH = @MaKH
	END
EXECUTE HIENTHITHONGTINKHACHHANG 'KH001'
CREATE PROC CAPNHATTHONGTIN
@MaKH varchar(20), @TenKH nvarchar(100), @CMND varchar(20), @NgaySinh varchar(20), @GioiTinh nvarchar(20), @DiaChi nvarchar(100), @SDT varchar(20)
as
	BEGIN
		UPDATE KHACHHANG SET TenKH = @TenKH, CMND = @CMND, NgaySinh = @NgaySinh, GioiTinh = @GioiTinh, DiaChi = @DiaChi, SDT = @SDT WHERE MaKH = @MaKH
	END