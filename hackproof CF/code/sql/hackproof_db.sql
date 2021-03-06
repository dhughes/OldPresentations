/****** Object:  Table [dbo].[products2]    Script Date: 11/26/2008 14:19:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[products2]') AND type in (N'U'))
DROP TABLE [dbo].[products2]
GO
/****** Object:  Table [dbo].[products]    Script Date: 11/26/2008 14:19:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[products]') AND type in (N'U'))
DROP TABLE [dbo].[products]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/26/2008 14:19:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type in (N'U'))
DROP TABLE [dbo].[users]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/26/2008 14:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[users](
	[userID] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[password] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[firstName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[lastName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK__users__7C8480AE] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
END
GO
SET IDENTITY_INSERT [dbo].[users] ON
INSERT [dbo].[users] ([userID], [username], [password], [firstName], [lastName]) VALUES (1, N'boyzoid', N'password', N'Scott', N'Stroz')
INSERT [dbo].[users] ([userID], [username], [password], [firstName], [lastName]) VALUES (2, N'manninge', N'password', N'Eli', N'Manning')
INSERT [dbo].[users] ([userID], [username], [password], [firstName], [lastName]) VALUES (3, N'jacobsb', N'password', N'Brandon', N'Jacobs')
INSERT [dbo].[users] ([userID], [username], [password], [firstName], [lastName]) VALUES (4, N'tuckj', N'password', N'Justin', N'Tuck')
INSERT [dbo].[users] ([userID], [username], [password], [firstName], [lastName]) VALUES (5, N'phillipsk', N'password', N'Kenny', N'Phillips')
INSERT [dbo].[users] ([userID], [username], [password], [firstName], [lastName]) VALUES (6, N'buressp', N'password', N'Plaxico', N'Buress')
SET IDENTITY_INSERT [dbo].[users] OFF
/****** Object:  Table [dbo].[products]    Script Date: 11/26/2008 14:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[products]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[products](
	[productID] [bigint] IDENTITY(1,1) NOT NULL,
	[product] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK__products__7E6CC920] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
END
GO
SET IDENTITY_INSERT [dbo].[products] ON
INSERT [dbo].[products] ([productID], [product], [description]) VALUES (1, N'Thing-a-ma-bob', N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in ')
INSERT [dbo].[products] ([productID], [product], [description]) VALUES (2, N'Whos-a-whats-it', N'Epsum factorial non deposit quid pro quo hic escorol. Olypian quarrels et gorilla congolium sic ad nauseum. Souvlaki ignitus carborundum e pluribus unum. Defacto lingo est igpay atinlay. Marquee selectus non provisio incongruous feline nolo contendre. Gratuitous octopus niacin, sodium glutimate. Quote meon an estimate et non interruptus stadium. Sic ')
INSERT [dbo].[products] ([productID], [product], [description]) VALUES (3, N'Hornswaggle', N'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc., li tot Europa usa li sam vocabularium. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilit de un nov lingua franca: on ')
SET IDENTITY_INSERT [dbo].[products] OFF
/****** Object:  Table [dbo].[products2]    Script Date: 11/26/2008 14:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[products2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[products2](
	[productid] [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[product] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK__products2__00551192] PRIMARY KEY CLUSTERED 
(
	[productid] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
END
GO
INSERT [dbo].[products2] ([productid], [product], [description]) VALUES (N'D918C9E4-F90E-49DB-6D5B21280789ED4B', N'Thing-a-ma-bob', N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in ')
INSERT [dbo].[products2] ([productid], [product], [description]) VALUES (N'D918C9F8-9ADE-70C9-580E5BF539CA0700', N'Whos-a-whats-it', N'Epsum factorial non deposit quid pro quo hic escorol. Olypian quarrels et gorilla congolium sic ad nauseum. Souvlaki ignitus carborundum e pluribus unum. Defacto lingo est igpay atinlay. Marquee selectus non provisio incongruous feline nolo contendre. Gratuitous octopus niacin, sodium glutimate. Quote meon an estimate et non interruptus stadium. Sic ')
INSERT [dbo].[products2] ([productid], [product], [description]) VALUES (N'D918C9FC-0683-A2F5-5D6917753F2C9EF3', N'Hornswaggle', N'Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc., li tot Europa usa li sam vocabularium. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilit de un nov lingua franca: on ')
