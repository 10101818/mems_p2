DECLARE @CurrDate DateTime=GETDATE()
INSERT INTO tblUser([LoginID] ,[LoginPwd] ,[Name] ,[RoleID] ,[Department] ,[IsActive] ,[VerifyStatus] ,[CreatedDate]) VALUES(N'user1',N'8D64420F72F932A7',N'Frank',4,1,1,1,@CurrDate)
INSERT INTO tblUser([LoginID] ,[LoginPwd] ,[Name] ,[RoleID] ,[Department] ,[IsActive] ,[VerifyStatus] ,[CreatedDate]) VALUES(N'superuser',N'8D64420F72F932A7',N'Rebecca',3,1,1,1,@CurrDate)
INSERT INTO tblUser([LoginID] ,[LoginPwd] ,[Name] ,[RoleID] ,[Department] ,[IsActive] ,[VerifyStatus] ,[CreatedDate]) VALUES(N'engineer',N'8D64420F72F932A7',N'Joanna',2,2,1,1,@CurrDate)
INSERT INTO tblUser([LoginID] ,[LoginPwd] ,[Name] ,[RoleID] ,[Department] ,[IsActive] ,[VerifyStatus] ,[CreatedDate]) VALUES(N'superadmin',N'8D64420F72F932A7',N'Buster',1,3,1,1,@CurrDate)
INSERT INTO tblUser([LoginID] ,[LoginPwd] ,[Name] ,[RoleID] ,[Department] ,[IsActive] ,[VerifyStatus] ,[CreatedDate]) VALUES(N'user2',N'8D64420F72F932A7',N'April',4,1,1,1,@CurrDate)
GO