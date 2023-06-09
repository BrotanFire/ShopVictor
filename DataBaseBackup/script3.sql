USE [VictorShop]
GO
/****** Object:  User [prog]    Script Date: 30.05.2023 14:04:51 ******/
CREATE USER [prog] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[id] [int] NOT NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderStatus] [int] NOT NULL,
	[OrderDeliveryDate] [date] NOT NULL,
	[OrderPickupPoint] [int] NOT NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK__Order__C3905BAF8C433B14] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PickupPoint]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PickupPoint](
	[AdressId] [int] NOT NULL,
	[PostCode] [int] NULL,
	[Sity] [nvarchar](100) NULL,
	[Street] [nvarchar](100) NULL,
	[House] [nvarchar](50) NULL,
 CONSTRAINT [PK_PicupPoint] PRIMARY KEY CLUSTERED 
(
	[AdressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_data]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_data](
	[user_data_id] [int] NOT NULL,
	[secondname_user] [nvarchar](255) NOT NULL,
	[name_user] [nvarchar](255) NOT NULL,
	[patronymic_user] [nvarchar](255) NULL,
	[role] [int] NULL,
 CONSTRAINT [PK_user_data] PRIMARY KEY CLUSTERED 
(
	[user_data_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrdersView]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersView]
AS
SELECT        dbo.[Order].OrderID, dbo.user_data.name_user, dbo.user_data.secondname_user, dbo.[Order].OrderDeliveryDate, dbo.PickupPoint.Sity + ' ' + dbo.PickupPoint.Street + ' ' + dbo.PickupPoint.House AS Expr1, 
                         dbo.OrderStatus.status, dbo.[Order].OrderStatus
FROM            dbo.[Order] INNER JOIN
                         dbo.OrderStatus ON dbo.[Order].OrderStatus = dbo.OrderStatus.id INNER JOIN
                         dbo.user_data ON dbo.[Order].user_id = dbo.user_data.user_data_id INNER JOIN
                         dbo.PickupPoint ON dbo.[Order].OrderPickupPoint = dbo.PickupPoint.AdressId
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[OrderID] [int] NOT NULL,
	[ProductArticleNumber] [nvarchar](100) NOT NULL,
	[NumberProduct] [int] NOT NULL,
 CONSTRAINT [PK__OrderPro__817A2662270AC826] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductArticleNumber] [nvarchar](100) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductDescription] [nvarchar](100) NOT NULL,
	[ProductCategory] [nvarchar](100) NOT NULL,
	[ProductPhoto] [image] NULL,
	[ProductManufacturer] [nvarchar](max) NOT NULL,
	[ProductCost] [decimal](19, 4) NOT NULL,
	[ProductDiscountAmount] [tinyint] NULL,
	[ProductQuantityInStock] [int] NOT NULL,
	[ProductStatus] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__Product__2EA7DCD52B80B351] PRIMARY KEY CLUSTERED 
(
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[PorductListView]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PorductListView]
AS
SELECT        dbo.[Order].OrderID, dbo.Product.ProductName, dbo.Product.ProductDescription, dbo.OrderProduct.NumberProduct, dbo.Product.ProductCost
FROM            dbo.[Order] INNER JOIN
                         dbo.OrderProduct ON dbo.[Order].OrderID = dbo.OrderProduct.OrderID INNER JOIN
                         dbo.Product ON dbo.OrderProduct.ProductArticleNumber = dbo.Product.ProductArticleNumber
GO
/****** Object:  Table [dbo].[user_auth]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_auth](
	[user_account_id] [int] NOT NULL,
	[Login] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_user_auth] PRIMARY KEY CLUSTERED 
(
	[user_account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[auth_view]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[auth_view]
AS
SELECT        dbo.user_auth.user_account_id, dbo.user_data.role, dbo.user_auth.Password, dbo.user_auth.Login
FROM            dbo.user_auth INNER JOIN
                         dbo.user_data ON dbo.user_auth.user_account_id = dbo.user_data.user_data_id
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_role](
	[role_id] [int] NOT NULL,
	[role] [nchar](10) NULL,
 CONSTRAINT [PK_user_role] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (32, 2, CAST(N'2023-05-27' AS Date), 3, 1)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (34, 2, CAST(N'2023-05-27' AS Date), 3, 1)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (35, 2, CAST(N'2023-05-27' AS Date), 2, 1)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (36, 2, CAST(N'2023-05-27' AS Date), 2, 1)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (37, 2, CAST(N'2023-05-27' AS Date), 2, 1)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (38, 1, CAST(N'2023-05-21' AS Date), 3, 1)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (39, 3, CAST(N'2023-05-31' AS Date), 5, 2)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (41, 1, CAST(N'2023-05-27' AS Date), 1, 1)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [user_id]) VALUES (42, 1, CAST(N'2023-05-27' AS Date), 33, 1)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (32, N'7', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (34, N'7', 0)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (35, N'2', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (36, N'2', 20)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (37, N'1', 10)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (37, N'2', 20)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (38, N'1', 16)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (38, N'2', 15)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (39, N'4', 20)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (39, N'5', 15)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (41, N'6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (41, N'7', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (42, N'4', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (42, N'5', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (42, N'6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [NumberProduct]) VALUES (42, N'7', 1)
GO
INSERT [dbo].[OrderStatus] ([id], [status]) VALUES (1, N'В обработке')
INSERT [dbo].[OrderStatus] ([id], [status]) VALUES (2, N'Готово')
INSERT [dbo].[OrderStatus] ([id], [status]) VALUES (3, N'Закрыто')
GO
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (1, 344288, N' г. Талнах', N' ул. Чехова', N'1')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (2, 614164, N' г.Талнах', N'  ул. Степная', N'30')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (3, 394242, N' г. Талнах', N' ул. Коммунистическая', N'43')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (4, 660540, N' г. Талнах', N' ул. Солнечная', N'25')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (5, 125837, N' г. Талнах', N' ул. Шоссейная', N'40')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (6, 125703, N' г. Талнах', N' ул. Партизанская', N'49')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (7, 625283, N' г. Талнах', N' ул. Победы', N'46')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (8, 614611, N' г. Талнах', N' ул. Молодежная', N'50')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (9, 454311, N' г.Талнах', N' ул. Новая', N'19')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (10, 660007, N' г.Талнах', N' ул. Октябрьская', N'19')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (11, 603036, N' г. Талнах', N' ул. Садовая', N'4')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (12, 450983, N' г.Талнах', N' ул. Комсомольская', N'26')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (13, 394782, N' г. Талнах', N' ул. Чехова', N'3')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (14, 603002, N' г. Талнах', N' ул. Дзержинского', N'28')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (15, 450558, N' г. Талнах', N' ул. Набережная', N'30')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (16, 394060, N' г.Талнах', N' ул. Фрунзе', N'43')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (17, 410661, N' г. Талнах', N' ул. Школьная', N'50')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (18, 625590, N' г. Талнах', N' ул. Коммунистическая', N'20')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (19, 625683, N' г. Талнах', N' ул. 8 Марта', NULL)
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (20, 400562, N' г. Талнах', N' ул. Зеленая', N'32')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (21, 614510, N' г. Талнах', N' ул. Маяковского', N'47')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (22, 410542, N' г. Талнах', N' ул. Светлая', N'46')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (23, 620839, N' г. Талнах', N' ул. Цветочная', N'8')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (24, 443890, N' г. Талнах', N' ул. Коммунистическая', N'1')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (25, 603379, N' г. Талнах', N' ул. Спортивная', N'46')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (26, 603721, N' г. Талнах', N' ул. Гоголя', N'41')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (27, 410172, N' г. Талнах', N' ул. Северная', N'13')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (28, 420151, N' г. Талнах', N' ул. Вишневая', N'32')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (29, 125061, N' г. Талнах', N' ул. Подгорная', N'8')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (30, 630370, N' г. Талнах', N' ул. Шоссейная', N'24')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (31, 614753, N' г. Талнах', N' ул. Полевая', N'35')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (32, 426030, N' г. Талнах', N' ул. Маяковского', N'44')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (33, 450375, N' г. Талнах ул. Клубная', N'44', NULL)
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (34, 625560, N' г. Талнах', N' ул. Некрасова', N'12')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (35, 630201, N' г. Талнах', N' ул. Комсомольская', N'17')
INSERT [dbo].[PickupPoint] ([AdressId], [PostCode], [Sity], [Street], [House]) VALUES (36, 190949, N' г. Талнах', N' ул. Мичурина', N'26')
GO
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'1', N'Ложка', N'Сталь', N'Столовый Прибор', NULL, N'Лесной', CAST(100.0000 AS Decimal(19, 4)), 10, 1, N'1')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'2', N'Ложка суповая', N'Легированная Сталь', N'Столовый прибор', NULL, N'Екатеринбруг', CAST(200.0000 AS Decimal(19, 4)), 16, 2, N'1')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'3', N'Набор Вилок', N'Сталь', N'Столовый прибор', NULL, N'Екатеринбруг', CAST(2020.0000 AS Decimal(19, 4)), 16, 2, N'1')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'4', N'Ложка Десертная', N'Сталь', N'Столовый прибор', NULL, N'Екатеринбруг', CAST(223.0000 AS Decimal(19, 4)), 0, 2, N'1')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'5', N'Набор для Десерта', N'Алюминий', N'Столовый прибор', NULL, N'Екатеринбруг', CAST(1280.0000 AS Decimal(19, 4)), 0, 2, N'1')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'6', N'Вилка', N'Сталь', N'Столовый прибор', NULL, N'Екатеринбруг', CAST(203.0000 AS Decimal(19, 4)), 2, 2, N'1')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductPhoto], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductStatus]) VALUES (N'7', N'Нож', N'Алюминий', N'Столовый прибор', NULL, N'Екатеринбруг', CAST(302.0000 AS Decimal(19, 4)), 10, 2, N'1')
GO
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (1, N'1', N'1')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (2, N'2', N'2')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (3, N'3', N'3')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (4, N'loginDEijg2018', N'4QlKJW')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (5, N'loginDEdpy2018', N'MJ0W|f')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (6, N'loginDEwdm2018', N'&PynqU')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (7, N'loginDEdup2018', N'JM+2{s')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (8, N'loginDEhbm2018', N'9aObu4')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (9, N'loginDExvq2018', N'hX0wJz')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (10, N'loginDErks2018', N'LQNSjo')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (11, N'loginDErvb2018', N'ceAf&R')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (12, N'loginDEgfw2018', N'3c2Ic1')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (13, N'loginDEmxb2018', N'ZPXcRS')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (14, N'loginDEgeq2018', N'&&Eim0')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (15, N'loginDEkhj2018', N'Pbc0t{')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (16, N'loginDEliu2018', N'32FyTl')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (17, N'loginDEsmf2018', N'{{O2QG')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (18, N'loginDEutd2018', N'GbcJvC')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (19, N'loginDEpgh2018', N'YV2lvh')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (20, N'loginDEvop2018', N'pBP8rO')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (21, N'loginDEwjo2018', N'EQaD|d')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (22, N'loginDEbur2018', N'aZKGeI')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (23, N'loginDEszw2018', N'EGU{YE')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (24, N'loginDExsu2018', N'*2RMsp')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (25, N'loginDEztn2018', N'nJBZpU')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (26, N'loginDEtmn2018', N'UObB}N')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (27, N'loginDEhep2018', N'SwRicr')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (28, N'loginDEevr2018', N'zO5l}l')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (29, N'loginDEnpa2018', N'M*QLjf')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (30, N'loginDEgyt2018', N'Pav+GP')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (31, N'loginDEbrr2018', N'Z7L|+i')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (32, N'loginDEyoo2018', N'UG1BjP')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (33, N'loginDEaob2018', N'3fy+3I')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (34, N'loginDEwtz2018', N'&GxSST')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (35, N'loginDEctf2018', N'sjt*3N')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (36, N'loginDEipm2018', N'MAZl6|')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (37, N'loginDEjoi2018', N'o}C4jv')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (38, N'loginDEwap2018', N'4hny7k')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (39, N'loginDEaxm2018', N'BEc3xq')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (40, N'loginDEsmq2018', N'ATVmM7')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (41, N'loginDEeur2018', N'n4V{wP')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (42, N'loginDEvke2018', N'WQLXSl')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (43, N'loginDEvod2018', N'0EW93v')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (44, N'loginDEjaw2018', N'h6z&Ky')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (45, N'loginDEpdp2018', N'8NvRfC')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (46, N'loginDEjpp2018', N'oMOQq3')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (47, N'loginDEkiy2018', N'BQzsts')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (48, N'loginDEhmn2018', N'a|Iz|7')
INSERT [dbo].[user_auth] ([user_account_id], [Login], [Password]) VALUES (49, N'loginDEfmn2018', N'cw3|03')
GO
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (1, N'Ефремов ', N'Сергей', N'Пантелеймонович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (2, N'Родионова ', N'Тамара', N'Валентиновна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (3, N'Миронова ', N'Галина', N'Улебовна', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (4, N'Сидоров ', N'Роман', N'Иринеевич', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (5, N'Ситников ', N'Парфений', N'Всеволодович', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (6, N'Никонов ', N'Роман', N'Геласьевич', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (7, N'Щербаков ', N'Владимир', N'Матвеевич', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (8, N'Кулаков ', N'Мартын', N'Михаилович', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (9, N'Сазонова ', N'Оксана', N'Лаврентьевна', 3)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (10, N'Архипов ', N'Варлам', N'Мэлорович', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (11, N'Устинова ', N'Ираида', N'Мэлоровна', 3)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (12, N'Кононов ', N'Эдуард', N'Валентинович', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (13, N'Орехова ', N'Клавдия', N'Альбертовна', 3)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (14, N'Яковлев ', N'Яков', N'Эдуардович', 3)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (15, N'Воронов ', N'Мэлс', N'Семёнович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (16, N'Вишнякова ', N'Ия', N'Данииловна', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (17, N'Третьяков ', N'Фёдор', N'Вадимович', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (18, N'Макаров ', N'Максим', N'Ильяович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (19, N'Шубина ', N'Маргарита', N'Анатольевна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (20, N'Блинова ', N'Ангелина', N'Владленовна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (21, N'Воробьёв ', N'Владлен', N'Фролович', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (22, N'Сорокина ', N'Прасковья', N'Фёдоровна', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (23, N'Давыдов ', N'Яков', N'Антонович', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (24, N'Рыбакова ', N'Евдокия', N'Анатольевна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (25, N'Маслов ', N'Геннадий', N'Фролович', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (26, N'Цветкова ', N'Элеонора', N'Аристарховна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (27, N'Евдокимов ', N'Ростислав', N'Александрович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (28, N'Никонова ', N'Венера', N'Станиславовна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (29, N'Громов ', N'Егор', N'Антонович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (30, N'Суворова ', N'Валерия', N'Борисовна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (31, N'Мишина ', N'Елизавета', N'Романовна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (32, N'Зимина ', N'Ольга', N'Аркадьевна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (33, N'Игнатьев ', N'Игнатий', N'Антонинович', 3)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (34, N'Пахомова ', N'Зинаида', N'Витальевна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (35, N'Устинов ', N'Владимир', N'Федосеевич', 3)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (36, N'Кулаков ', N'Мэлор', N'Вячеславович', 3)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (37, N'Сазонов ', N'Авксентий', N'Брониславович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (38, N'Бурова ', N'Наина', N'Брониславовна', 3)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (39, N'Фадеев ', N'Демьян', N'Федосеевич', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (40, N'Бобылёва ', N'Дарья', N'Якуновна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (41, N'Виноградов ', N'Созон', N'Арсеньевич', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (42, N'Гордеев ', N'Владлен', N'Ефимович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (43, N'Иванова ', N'Валерьевна', N'Зинаида', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (44, N'Гусев ', N'Руслан', N'Дамирович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (45, N'Маслов ', N'Дмитрий', N'Иванович', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (46, N'Антонова ', N'Ульяна', N'Семёновна', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (47, N'Орехова ', N'Людмила', N'Владимировна', 1)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (48, N'Авдеева ', N'Жанна', N'Куприяновна', 2)
INSERT [dbo].[user_data] ([user_data_id], [secondname_user], [name_user], [patronymic_user], [role]) VALUES (49, N'Кузнецов ', N'Фрол', N'Варламович', 2)
GO
INSERT [dbo].[user_role] ([role_id], [role]) VALUES (1, N'Client    ')
INSERT [dbo].[user_role] ([role_id], [role]) VALUES (2, N'Manager   ')
INSERT [dbo].[user_role] ([role_id], [role]) VALUES (3, N'Admin     ')
INSERT [dbo].[user_role] ([role_id], [role]) VALUES (4, N'SuperUser ')
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([OrderStatus])
REFERENCES [dbo].[OrderStatus] ([id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PickupPoint] FOREIGN KEY([OrderPickupPoint])
REFERENCES [dbo].[PickupPoint] ([AdressId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_PickupPoint]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_user_data] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_data] ([user_data_id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_user_data]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Order__71D1E811] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Order__71D1E811]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Produ__72C60C4A] FOREIGN KEY([ProductArticleNumber])
REFERENCES [dbo].[Product] ([ProductArticleNumber])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Produ__72C60C4A]
GO
ALTER TABLE [dbo].[user_data]  WITH CHECK ADD  CONSTRAINT [FK_user_data_user_auth] FOREIGN KEY([user_data_id])
REFERENCES [dbo].[user_auth] ([user_account_id])
GO
ALTER TABLE [dbo].[user_data] CHECK CONSTRAINT [FK_user_data_user_auth]
GO
ALTER TABLE [dbo].[user_data]  WITH CHECK ADD  CONSTRAINT [FK_user_data_user_role] FOREIGN KEY([role])
REFERENCES [dbo].[user_role] ([role_id])
GO
ALTER TABLE [dbo].[user_data] CHECK CONSTRAINT [FK_user_data_user_role]
GO
/****** Object:  StoredProcedure [dbo].[AddNewOrder]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewOrder]
    @OrderDate Date,
    @PickupPoint integer,
    @Account int,
    @OrderId INT OUTPUT
	AS
BEGIN
    INSERT INTO "dbo"."Order" (OrderStatus,OrderDeliveryDate,OrderPickupPoint,user_id) VALUES (1,@OrderDate,@PickupPoint,@Account);
    SET  @OrderId = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[AddNewOrderProduct]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[AddNewOrderProduct]
    @ProductId Int,
    @OrderId Int,
    @ProductNumber int
	AS
BEGIN
    INSERT INTO "dbo"."OrderProduct" (OrderID,ProductArticleNumber,NumberProduct) VALUES (@OrderId,@ProductId,@ProductNumber);
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Login]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Login] 
  @Username NVARCHAR(50), 
  @Password NVARCHAR(50),
  @AccountType INT OUTPUT,
  @AccountId int OUTPUT
AS 
BEGIN 
  SET NOCOUNT ON; 
  
  SELECT @AccountType = [role] FROM auth_view WHERE auth_view.[Login] = @Username AND auth_view.[Password] =  @Password
  SELECT @AccountId = [user_account_id] FROM auth_view WHERE auth_view.[Login] = @Username AND auth_view.[Password] =  @Password
  IF @AccountType IS NOT NULL 
  BEGIN 
    SELECT 1 AS [LoginResult]; 
  END 
  ELSE 
  BEGIN 
    SELECT 0 AS [LoginResult]; 
  END 
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateStatus]    Script Date: 30.05.2023 14:04:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStatus]
    @Id int,
    @IsDone int
AS
BEGIN
    UPDATE "dbo"."Order" SET OrderStatus = @IsDone WHERE OrderID = @Id;
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "user_auth"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "user_data"
            Begin Extent = 
               Top = 33
               Left = 404
               Bottom = 163
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'auth_view'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'auth_view'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OrderStatus"
            Begin Extent = 
               Top = 143
               Left = 571
               Bottom = 239
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "user_data"
            Begin Extent = 
               Top = 181
               Left = 287
               Bottom = 311
               Right = 471
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "PickupPoint"
            Begin Extent = 
               Top = 193
               Left = 74
               Bottom = 289
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OrdersView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OrdersView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 144
               Left = 440
               Bottom = 274
               Right = 662
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "OrderProduct"
            Begin Extent = 
               Top = 6
               Left = 689
               Bottom = 119
               Right = 898
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PorductListView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PorductListView'
GO
