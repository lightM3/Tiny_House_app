USE [TinyHouseDb]
GO
/****** Object:  Table [dbo].[tblComment]    Script Date: 12.05.2025 12:50:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblComment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[HouseId] [int] NOT NULL,
	[Content] [text] NOT NULL,
	[Star] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tblComment] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tblHouse]    Script Date: 12.05.2025 12:50:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHouse](
	[HouseId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[HouseLocation] [varchar](255) NULL,
	[HouseDescription] [text] NULL,
	[HouseAvgStar] [int] NULL,
	[IsAvailable] [bit] NULL,
	[WhoRent] [int] NULL,
	[IsHouseActive] [bit] NULL,
	[PassiveStartDate] [date] NULL,
	[PassiveEndDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[HouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tblHouse] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tblPayment]    Script Date: 12.05.2025 12:50:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPayment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[ReservationId] [int] NOT NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentStatus] [varchar](50) NULL,
	[PaymentMethod] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tblPayment] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tblReservation]    Script Date: 12.05.2025 12:50:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblReservation](
	[ReservationId] [int] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NOT NULL,
	[HouseId] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[ReservationStatus] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReservationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tblReservation] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 12.05.2025 12:50:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
	[Address] [varchar](255) NULL,
	[UserRoleLevel] [int] NOT NULL,
	[IsAccountActive] [bit] NULL,
	[UserPassiveStartDate] [date] NULL,
	[UserPassiveEndDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tblUser] TO  SCHEMA OWNER 
GO
SET IDENTITY_INSERT [dbo].[tblComment] ON 

INSERT [dbo].[tblComment] ([CommentId], [UserId], [HouseId], [Content], [Star]) VALUES (1, 7, 1, N'Mükemmel bir deneyimdi! Harika bir manzara ve çok huzurlu bir ortam.', 90)
INSERT [dbo].[tblComment] ([CommentId], [UserId], [HouseId], [Content], [Star]) VALUES (2, 7, 2, N'Ev çok güzeldi fakat fiyat biraz yüksek, ama yine de çok memnun kaldım.', 80)
INSERT [dbo].[tblComment] ([CommentId], [UserId], [HouseId], [Content], [Star]) VALUES (3, 8, 3, N'Evin konumu çok iyi, ancak iç mekan daha konforlu olabilirdi.', 75)
INSERT [dbo].[tblComment] ([CommentId], [UserId], [HouseId], [Content], [Star]) VALUES (4, 8, 4, N'Evde bazı eksiklikler vardı, ancak konum ve doğa harikaydı.', 70)
INSERT [dbo].[tblComment] ([CommentId], [UserId], [HouseId], [Content], [Star]) VALUES (5, 9, 5, N'Çok keyifli bir tatildi! Hem doğa hem de ev çok güzeldi.', 85)
INSERT [dbo].[tblComment] ([CommentId], [UserId], [HouseId], [Content], [Star]) VALUES (6, 9, 6, N'Ev çok basitti, beklentimi karşılamadı, ancak çevre çok hoştu.', 60)
SET IDENTITY_INSERT [dbo].[tblComment] OFF
GO
SET IDENTITY_INSERT [dbo].[tblHouse] ON 

INSERT [dbo].[tblHouse] ([HouseId], [UserId], [Price], [HouseLocation], [HouseDescription], [HouseAvgStar], [IsAvailable], [WhoRent], [IsHouseActive], [PassiveStartDate], [PassiveEndDate]) VALUES (1, 4, CAST(750.00 AS Decimal(10, 2)), N'Muğla, Turkey', N'Orman içinde manzaralı tiny house', 85, 0, 7, 1, NULL, NULL)
INSERT [dbo].[tblHouse] ([HouseId], [UserId], [Price], [HouseLocation], [HouseDescription], [HouseAvgStar], [IsAvailable], [WhoRent], [IsHouseActive], [PassiveStartDate], [PassiveEndDate]) VALUES (2, 4, CAST(800.00 AS Decimal(10, 2)), N'Muğla, Turkey', N'Göl kenarında sessiz tiny house', 90, 1, NULL, 1, NULL, NULL)
INSERT [dbo].[tblHouse] ([HouseId], [UserId], [Price], [HouseLocation], [HouseDescription], [HouseAvgStar], [IsAvailable], [WhoRent], [IsHouseActive], [PassiveStartDate], [PassiveEndDate]) VALUES (3, 5, CAST(900.00 AS Decimal(10, 2)), N'Bodrum, Turkey', N'Modern tasarımlı tiny house', 88, 1, NULL, 1, NULL, NULL)
INSERT [dbo].[tblHouse] ([HouseId], [UserId], [Price], [HouseLocation], [HouseDescription], [HouseAvgStar], [IsAvailable], [WhoRent], [IsHouseActive], [PassiveStartDate], [PassiveEndDate]) VALUES (4, 5, CAST(950.00 AS Decimal(10, 2)), N'Bodrum, Turkey', N'Plaja 100 metre mesafede ev', 92, 1, NULL, 1, NULL, NULL)
INSERT [dbo].[tblHouse] ([HouseId], [UserId], [Price], [HouseLocation], [HouseDescription], [HouseAvgStar], [IsAvailable], [WhoRent], [IsHouseActive], [PassiveStartDate], [PassiveEndDate]) VALUES (5, 6, CAST(700.00 AS Decimal(10, 2)), N'Fethiye, Turkey', N'Minimalist doğa evi', 80, 1, NULL, 1, NULL, NULL)
INSERT [dbo].[tblHouse] ([HouseId], [UserId], [Price], [HouseLocation], [HouseDescription], [HouseAvgStar], [IsAvailable], [WhoRent], [IsHouseActive], [PassiveStartDate], [PassiveEndDate]) VALUES (6, 6, CAST(720.00 AS Decimal(10, 2)), N'Fethiye, Turkey', N'Kamp alanına yakın konumda', 78, 1, NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblHouse] OFF
GO
SET IDENTITY_INSERT [dbo].[tblPayment] ON 

INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (1, 1, CAST(1500.00 AS Decimal(10, 2)), CAST(N'2025-05-07T17:59:42.957' AS DateTime), N'Successful', N'Credit Card')
INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (2, 2, CAST(1600.00 AS Decimal(10, 2)), CAST(N'2025-05-07T17:59:42.957' AS DateTime), N'Successful', N'Bank Transfer')
INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (3, 3, CAST(1800.00 AS Decimal(10, 2)), CAST(N'2025-05-07T17:59:42.957' AS DateTime), N'Pending', N'Credit Card')
INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (4, 4, CAST(1900.00 AS Decimal(10, 2)), CAST(N'2025-05-07T17:59:42.957' AS DateTime), N'Failed', N'Bank Transfer')
INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (5, 5, CAST(1400.00 AS Decimal(10, 2)), CAST(N'2025-05-07T17:59:42.957' AS DateTime), N'Successful', N'Credit Card')
INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (6, 6, CAST(2000.00 AS Decimal(10, 2)), CAST(N'2025-05-07T17:59:42.957' AS DateTime), N'Successful', N'Bank Transfer')
INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (7, 10, CAST(600.00 AS Decimal(10, 2)), CAST(N'2025-05-12T12:22:11.047' AS DateTime), N'Failed', N'DEbid Card')
INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (8, 10, CAST(650.00 AS Decimal(10, 2)), CAST(N'2025-05-12T12:22:21.283' AS DateTime), N'Failed', N'DEbid Card')
INSERT [dbo].[tblPayment] ([PaymentId], [ReservationId], [Amount], [PaymentDate], [PaymentStatus], [PaymentMethod]) VALUES (9, 10, CAST(750.00 AS Decimal(10, 2)), CAST(N'2025-05-12T12:22:36.560' AS DateTime), N'Successful', N'DEbid Card')
SET IDENTITY_INSERT [dbo].[tblPayment] OFF
GO
SET IDENTITY_INSERT [dbo].[tblReservation] ON 

INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (1, 7, 1, CAST(N'2025-06-01' AS Date), CAST(N'2025-06-05' AS Date), N'Confirmed', CAST(N'2025-05-07T17:59:18.720' AS DateTime))
INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (2, 7, 2, CAST(N'2025-07-10' AS Date), CAST(N'2025-07-12' AS Date), N'Completed', CAST(N'2025-05-07T17:59:18.720' AS DateTime))
INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (3, 8, 3, CAST(N'2025-08-01' AS Date), CAST(N'2025-08-04' AS Date), N'Cancelled', CAST(N'2025-05-07T17:59:18.720' AS DateTime))
INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (4, 8, 4, CAST(N'2025-06-15' AS Date), CAST(N'2025-06-20' AS Date), N'Cancelled', CAST(N'2025-05-07T17:59:18.720' AS DateTime))
INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (5, 9, 5, CAST(N'2025-07-20' AS Date), CAST(N'2025-07-25' AS Date), N'Confirmed', CAST(N'2025-05-07T17:59:18.720' AS DateTime))
INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (6, 9, 6, CAST(N'2025-09-01' AS Date), CAST(N'2025-09-05' AS Date), N'Rejected', CAST(N'2025-05-07T17:59:18.720' AS DateTime))
INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (8, 7, 3, CAST(N'2025-05-09' AS Date), CAST(N'2025-05-16' AS Date), N'Confirmed', CAST(N'2025-05-09T14:46:06.463' AS DateTime))
INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (9, 7, 4, CAST(N'2025-05-09' AS Date), CAST(N'2025-05-16' AS Date), N'Rejected', CAST(N'2025-05-09T14:46:06.467' AS DateTime))
INSERT [dbo].[tblReservation] ([ReservationId], [TenantId], [HouseId], [StartDate], [EndDate], [ReservationStatus], [CreatedAt]) VALUES (10, 7, 1, CAST(N'2025-05-12' AS Date), CAST(N'2025-05-19' AS Date), N'Pending', CAST(N'2025-05-12T11:49:14.813' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblReservation] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (1, N'admin1', N'admin123', N'admin1@example.com', N'05000000001', N'Istanbul', 0, 1, NULL, NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (2, N'admin2', N'admin123', N'admin2@example.com', N'05000000002', N'Ankara', 0, 1, NULL, NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (3, N'admin3', N'admin123', N'admin3@example.com', N'05000000003', N'Izmir', 0, 1, NULL, NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (4, N'owner1', N'owner123', N'owner1@example.com', N'05000000011', N'Muğla', 2, 0, NULL, NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (5, N'owner2', N'owner123', N'owner2@example.com', N'05000000012', N'Bodrum', 2, 1, NULL, NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (6, N'owner3', N'owner123', N'owner3@example.com', N'05000000013', N'Fethiye', 2, 1, NULL, NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (7, N'tenant1', N'tenant123', N'tenant1@example.com', N'05000000021', N'Bursa', 1, 1, NULL, NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (8, N'tenant2', N'tenant123', N'tenant2@example.com', N'05000000022', N'Eskişehir', 1, 1, NULL, NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [Password], [Email], [PhoneNumber], [Address], [UserRoleLevel], [IsAccountActive], [UserPassiveStartDate], [UserPassiveEndDate]) VALUES (9, N'tenant3', N'tenant123', N'tenant3@example.com', N'05000000023', N'Antalya', 1, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblUser] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tblUser__A9D10534A693DAF1]    Script Date: 12.05.2025 12:50:40 ******/
ALTER TABLE [dbo].[tblUser] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblHouse] ADD  DEFAULT ((0)) FOR [HouseAvgStar]
GO
ALTER TABLE [dbo].[tblHouse] ADD  DEFAULT ((1)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[tblHouse] ADD  DEFAULT ((1)) FOR [IsHouseActive]
GO
ALTER TABLE [dbo].[tblPayment] ADD  DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[tblReservation] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT ((1)) FOR [IsAccountActive]
GO
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_House] FOREIGN KEY([HouseId])
REFERENCES [dbo].[tblHouse] ([HouseId])
GO
ALTER TABLE [dbo].[tblComment] CHECK CONSTRAINT [FK_Comment_House]
GO
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblComment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[tblHouse]  WITH CHECK ADD  CONSTRAINT [FK_House_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblHouse] CHECK CONSTRAINT [FK_House_User]
GO
ALTER TABLE [dbo].[tblHouse]  WITH CHECK ADD  CONSTRAINT [FK_House_WhoRent] FOREIGN KEY([WhoRent])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblHouse] CHECK CONSTRAINT [FK_House_WhoRent]
GO
ALTER TABLE [dbo].[tblPayment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Reservation] FOREIGN KEY([ReservationId])
REFERENCES [dbo].[tblReservation] ([ReservationId])
GO
ALTER TABLE [dbo].[tblPayment] CHECK CONSTRAINT [FK_Payment_Reservation]
GO
ALTER TABLE [dbo].[tblReservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_House] FOREIGN KEY([HouseId])
REFERENCES [dbo].[tblHouse] ([HouseId])
GO
ALTER TABLE [dbo].[tblReservation] CHECK CONSTRAINT [FK_Reservation_House]
GO
ALTER TABLE [dbo].[tblReservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Tenant] FOREIGN KEY([TenantId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblReservation] CHECK CONSTRAINT [FK_Reservation_Tenant]
GO
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD CHECK  (([Star]>=(1) AND [Star]<=(100)))
GO
ALTER TABLE [dbo].[tblPayment]  WITH CHECK ADD CHECK  (([PaymentStatus]='Failed' OR [PaymentStatus]='Successful' OR [PaymentStatus]='Pending'))
GO
ALTER TABLE [dbo].[tblReservation]  WITH CHECK ADD CHECK  (([ReservationStatus]='Completed' OR [ReservationStatus]='Cancelled' OR [ReservationStatus]='Rejected' OR [ReservationStatus]='Confirmed' OR [ReservationStatus]='Pending'))
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD CHECK  (([UserRoleLevel]=(2) OR [UserRoleLevel]=(1) OR [UserRoleLevel]=(0)))
GO
