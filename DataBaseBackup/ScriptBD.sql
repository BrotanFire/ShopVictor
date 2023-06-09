USE [master]
GO
/****** Object:  Database [VictorShop]    Script Date: 28.05.2023 16:50:58 ******/
CREATE DATABASE [VictorShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VictorShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\VictorShop.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VictorShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\VictorShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [VictorShop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VictorShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VictorShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VictorShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VictorShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VictorShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VictorShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [VictorShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VictorShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VictorShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VictorShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VictorShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VictorShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VictorShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VictorShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VictorShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VictorShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VictorShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VictorShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VictorShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VictorShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VictorShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VictorShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VictorShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VictorShop] SET RECOVERY FULL 
GO
ALTER DATABASE [VictorShop] SET  MULTI_USER 
GO
ALTER DATABASE [VictorShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VictorShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VictorShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VictorShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VictorShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VictorShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'VictorShop', N'ON'
GO
ALTER DATABASE [VictorShop] SET QUERY_STORE = ON
GO
ALTER DATABASE [VictorShop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [VictorShop]
GO
/****** Object:  User [prog]    Script Date: 28.05.2023 16:50:59 ******/
CREATE USER [prog] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  Table [dbo].[user_data]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  Table [dbo].[PickupPoint]    Script Date: 28.05.2023 16:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PickupPoint](
	[id] [int] NOT NULL,
	[address] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Лист1$] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrdersView]    Script Date: 28.05.2023 16:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersView]
AS
SELECT        dbo.[Order].OrderID, dbo.user_data.name_user, dbo.user_data.secondname_user, dbo.[Order].OrderDeliveryDate, dbo.PickupPoint.address, dbo.OrderStatus.status, dbo.[Order].OrderStatus
FROM            dbo.[Order] INNER JOIN
                         dbo.OrderStatus ON dbo.[Order].OrderStatus = dbo.OrderStatus.id INNER JOIN
                         dbo.user_data ON dbo.[Order].user_id = dbo.user_data.user_data_id INNER JOIN
                         dbo.PickupPoint ON dbo.[Order].OrderPickupPoint = dbo.PickupPoint.id
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  View [dbo].[PorductListView]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  Table [dbo].[user_auth]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  View [dbo].[auth_view]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  Table [dbo].[user_role]    Script Date: 28.05.2023 16:50:59 ******/
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
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([OrderStatus])
REFERENCES [dbo].[OrderStatus] ([id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PickupPoint] FOREIGN KEY([OrderPickupPoint])
REFERENCES [dbo].[PickupPoint] ([id])
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
/****** Object:  StoredProcedure [dbo].[AddNewOrder]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewOrderProduct]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Login]    Script Date: 28.05.2023 16:50:59 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateStatus]    Script Date: 28.05.2023 16:50:59 ******/
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
         Begin Table = "Order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 1
         End
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
USE [master]
GO
ALTER DATABASE [VictorShop] SET  READ_WRITE 
GO
