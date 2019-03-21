USE [master]
GO
/****** Object:  Database [E_Commerce]    Script Date: 1/6/2019 7:54:39 PM ******/
CREATE DATABASE [E_Commerce]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'E_Commerce', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\E_Commerce.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'E_Commerce_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\E_Commerce_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [E_Commerce] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [E_Commerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [E_Commerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [E_Commerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [E_Commerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [E_Commerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [E_Commerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [E_Commerce] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [E_Commerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [E_Commerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [E_Commerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [E_Commerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [E_Commerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [E_Commerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [E_Commerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [E_Commerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [E_Commerce] SET  DISABLE_BROKER 
GO
ALTER DATABASE [E_Commerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [E_Commerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [E_Commerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [E_Commerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [E_Commerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [E_Commerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [E_Commerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [E_Commerce] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [E_Commerce] SET  MULTI_USER 
GO
ALTER DATABASE [E_Commerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [E_Commerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [E_Commerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [E_Commerce] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [E_Commerce] SET DELAYED_DURABILITY = DISABLED 
GO
USE [E_Commerce]
GO
/****** Object:  UserDefinedFunction [dbo].[CommaSeparated]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CommaSeparated] 
(
	@psCSString varchar(50)
)
RETURNS @otTemp TABLE(sID VARCHAR(20))
AS
BEGIN
DECLARE @sTemp VARCHAR(50)
WHILE LEN(@psCSString) > 0
BEGIN
SET @sTemp = LEFT(@psCSString, ISNULL(NULLIF(CHARINDEX(',', @psCSString) - 1, -1),
                LEN(@psCSString)))
SET @psCSString = SUBSTRING(@psCSString,ISNULL(NULLIF(CHARINDEX(',', @psCSString), 0),
                           LEN(@psCSString)) + 1, LEN(@psCSString))
INSERT INTO @otTemp VALUES (@sTemp)
END
RETURN
END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_Split]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  FUNCTION [dbo].[fn_Split](@text varchar(8000), @delimiter varchar(20) = ' ')
RETURNS @Strings TABLE
(   
  position int IDENTITY PRIMARY KEY,
  value varchar(8000)  
)
AS
BEGIN

DECLARE @index int
SET @index = -1

WHILE (LEN(@text) > 0)
  BEGIN 
    SET @index = CHARINDEX(@delimiter , @text) 
    IF (@index = 0) AND (LEN(@text) > 0) 
      BEGIN  
        INSERT INTO @Strings VALUES (@text)
          BREAK 
      END 
    IF (@index > 1) 
      BEGIN  
        INSERT INTO @Strings VALUES (LEFT(@text, @index - 1))  
        SET @text = RIGHT(@text, (LEN(@text) - @index)) 
      END 
    ELSE
      SET @text = RIGHT(@text, (LEN(@text) - @index))
    END
  RETURN
END

GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](128) NOT NULL,
	[IsDisable] [bit] NOT NULL,
	[CustomerId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Carts](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[ItemsQunatity] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[ItemsId] [int] NOT NULL,
	[CustomerName] [varchar](50) NOT NULL,
	[isDisable] [bit] NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoriesId] [int] IDENTITY(1,1) NOT NULL,
	[CategoriesName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoriesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoryIngredient]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryIngredient](
	[CatId] [int] NOT NULL,
	[IngredientId] [int] NOT NULL,
 CONSTRAINT [PK_CategoryIngredient] PRIMARY KEY CLUSTERED 
(
	[CatId] ASC,
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ingredients]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ingredients](
	[IngredientId] [int] IDENTITY(1,1) NOT NULL,
	[IngredientName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Ingredients] PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Items]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Price] [money] NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[CategoriesId] [int] NOT NULL,
	[IsDisable] [bit] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemsIngredients]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemsIngredients](
	[ItemId] [int] NOT NULL,
	[IngredientId] [int] NOT NULL,
 CONSTRAINT [PK_ItemsIngredients] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC,
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[ItemId] [int] NOT NULL,
	[PricePerUnit] [money] NOT NULL,
	[OrderedBy] [varchar](30) NOT NULL,
	[ItemsQuantity] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201811100449570_InitialCreate', N'Microsoft.AspNet.Identity.EntityFramework.IdentityDbContext', 0x1F8B0800000000000400DD5CDD6EDC3616BE2FD0771074D52DDC917F3641D6182770C7766B6CFC838C53EC5DC09138632112A58A9463A3E893F5A28FB4AFB0A44469448AD4501A8D465E14483322F99DC3C343F2F0F063FEFBD7DFD30FCF61603DC104FB113AB38F2687B605911B793E5A9DD92959FEF4CEFEF0FEFBEFA6975EF86CFD56D43B61F5684B84CFEC4742E253C7C1EE230C019E84BE9B44385A92891B850EF022E7F8F0F05FCED1910329844DB12C6BFA2945C40F61F683FE9C45C88531494170137930C0FC3B2D9967A8D62D08218E810BCFEC9B12FF1CC7B7904CAE3D48C1C8CBE432FBDF5542EB7E8B92AFB6751EF8802A3887C1D2B60042110184AA7FFA19C3394922B49AC7F403081E5E6248EB2D418021EFD6E9BABA690F0F8F590F9D75C302CA4D3189C296804727DC648EDCBC93E1EDD2A4D4A8B9A158AF33C39ED985093F450135802CF0741624AC720BDB4FAA88079671BB83D2C58E2787ECBF036B9606244DE019822949407060DDA78BC077FF0D5F1EA2AF109D9D1C2D9627EFDEBC05DEC9DB7FC29337D59ED2BED27AC207FAE93E89629850DDE0B2ECBF6D39623B476E5836ABB4C9AD427D89CE16DBBA01CF1F215A91473A8F8EDFD9D695FF0CBDE20B77AECFC8A7938B3622494A7FDEA6410016012CCB9D4699ECCF06A9C76FDEF622F5163CF9AB6CE825F974E224D8B63EC1202BC58F7E9C4F2F61BCBFF06A574914B2DFA27FE5A55FE6519AB8AC3391B6CA0348569088DA4D9DB5F31AB93483EADFAD0BD4F1BB36D3B4EEDECAAAAC435D66422162E8D950E8BB5BB99D3CAE7F6F1BBFA7BD9645F432047ED0C32A6A2085C6354B3F0961D9CB9F23EAB300B5D6F91E604C87D6FB15E0C706D5E95F7B507D0EDD34A10E3527208C772EEDFE3142F0360D176CD60C27ABB7A179F8165D019744C92562ADB6C6FB18B95FA3945C22EF0210F899B80520FBF9E087E600BDA873EEBA10E32BEACCD09B45346C2F00AF1139396E0DC796B27D4731B300F8617318C3D4FC52D4ABC73195626D2053ADA38A649A34FC18AD7C64A061514FA3615EDCAC21AFD356438664A020AFA6D12F2B6D562FAFD25B24988D47FF9B7306FBFFBE43EB267CC58C73BA0CC25F2082095DABBC7B40084CD07A044C16877D4404D9F031A13BDF803249BF8120ED5B54A7D990CDFDFE6743063BFED990A9493F3FF91E0B3D0C0E4845650A6F545F7DF6DA3CE724CD869E0E423787163ECC1AA09B2EE71847AE9FCD02456A8C273644FD69A0666DCE72E4BD913325B463D4D1FD98BA36FD42FB66CB4E75872E600009B4CEDD3C753803D8055EDD8CB4435E0BC58A1D55A1D83A63222AF7634D26F57498B046809D74309DA93E22F569E123D78F41B0D14A524BC32D8CF5BD9421975CC018222670A3254C84AB13244C81528E34289B2C34752A1E67E688D5D074D3802BE354F5880FEC8AAAE858A3198FD976EA8C0A430DE88D0A639848D7A6F60677477E0E311A74F950321E77948E421ACD78D0B47B77140D35B43B8AC6785DEE989F3A8DC65C3A828EC719C583EFFEB6E9BA9586F644C1122373C43C8AA46D086D0113C9192F16AC043E13C5198B2AC98F599847ACB25B3084392462C2651DB62AC349A71944F69D26C0B57F6D00E5B77D8D40AD342BF26E8D883C2A68015B24CB1A61F9EA2EC15646BF8E5DBDF2AC54D45F8CCA6E697482287B56BA42CDBD8D02FE0A8EC21BE4D54AEC780BA3080954BD55B4C1AC71385BE90F1F0303BBA8A24F8D618A3EF46B99C2173758461557194756DD2D2305421ACB147DE8D732DC11371846B1C39BEEF1DDCD226EC93D4DA4221351EE2165D9D4C9C94FFCC3D4D1B0A4A637208E7DB4AAB0A6F8176B9E53A6663FCDDB9386C21CC371B1823B546A5B4A22510256502AA5A2A9A6577E82C905206001581E66E685B56AF51D53B3AE17F2AA9B627DF88A05BEA8CDFE9EB7E8C66052841D1C9AD65F852C70C952DF0A9F5037B718B30D04205164DB67519086481F47E95BE7176BD5F6F9973AC2D491F4AF854A3523D6E25871448CC6AB3E51763B76650CD37DFCF410BA5128C2CFEA38E842523D4A916BAAA2E8F24F7B1B4F5D3CD3F7186E397E43CD3FCE2CA902F04F2D312AE4841A58A5CC1C55E48F5431C512734489245285948A5A6859A582084A560B3AE1692CAAAE612EA14EFEA8A2D74BCD911534902AB4A2B803B64267B9CC1C55C114A9022B8ACDB1D7B41179551DF10EA73DD7F4BD3CE667E1EDD6480DC66E16CA7EB6C8CAB57D15A8F2B92516BF98AF81F1EFA37432ED11B16F27CB3323DB39990643BF4E09F7E0E232D57879AFC7142EB785ADA0E9725F8FD7CE9577EA30B5A3A45CA5945E1E29A5A3E3941FE336BFC2A99DEBF22AB655989186012F98C070C22A4CE6BF07B3C0876CD12F2ADC00E42F212639A1C33E3E3C3A965EEC8CE7F58C83B117B47842238ED900DC2CF40412F7112475A6C4162F4CD6A0B5ECF535F2E0F399FD47D6EA344B96B0BF659F0FAC6BFC19F9BFA7B4E02149A1F5679DDED93FE3BEABDD077F1F616ED5EBFF7CC99B1E5877099D31A7D6A164CB2E232CBE9A68A54DDE740B6DBABDA578BDB349786AA044956643F797050B9FF4F2AAA0D0F287103CFFA3AD6ACA97035B212A5E07F485D78B0975ECFF2E585AE6BF477F928CF9DFAEB3EA97005D54D3BE02F0517B30F90D80F91A54B4DCE33EA338270DB1246576DE48AFDE8A6BB9EF8DA9C6C2DE6AA2D799D62DE0B6605377F08C574644EE6D7754F08C7BC3DEA76BEF9C5C3C163EF19A22B25F1AF1D094246399AF92303C261A1C67F9EC99193CB47FE9F2B963E65CB6A0008FC9C138DF6BCF5CDFA11D4C97CB1DB38399937AC7E45FFBDE1EF7E15DC6DBE3DE89BA757692E6FE4595E4DDC4C5CD33E2F4F4BE88A807E4D1627EE1A2E688E984AD3D452B705D452F544F4E6B12BC91D7DB2CB09D30BE9F374AE4759AC56A489B4DB2F952DF289BD76996ADA145EE8342AC2429AA38DD1B962FCD6D9E921D3E42CAB0B603C666101C537375FE0A18C2DB1B4298259AEBDDD11382B737439FD3A20501B87E3B4B77C4CABFA4487765ECAFD610ECDF5544D015F6C2B2CE355A46C5962C69545491722A3790008F6E94E709F197C025B4986585B307DA59A68DDD4D2CA0778DEE5212A7847619868B404851B1ADBD497EC67216759EDEC5D93F31D24717A89A3ECBA6DFA19F533FF04ABDAF14591C0D048B19780E968D2561B9D8D54B89741B2143206EBE32D47980611C50307C87E6E00976D18DBADF47B802EECB3A67A703D93C10A2D9A7173E582520C41C63DD9EFEA43EEC85CFEFFF07D8F4487350540000, N'6.1.2-31219')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'98685e87-e813-4b67-9f05-15a8930ea514', N'CanManageWebSite')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'57d92c18-8809-4dae-b84c-fcc3e69c7094', N'98685e87-e813-4b67-9f05-15a8930ea514')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsDisable], [CustomerId]) VALUES (N'04889048-50e8-4c9a-bbfd-b574e8480a5d', N'shezi9699@gmail.com', 0, N'AMY/HJwiddbPIyXfO0tVNwJ6M6HctgisyxVnh+qm4kiGx24/N67bF0nytYJaSs/0+A==', N'059c43e5-085d-4ca2-8679-ef80319759fa', N'+923070501323', 0, 0, NULL, 0, 0, N'Shazmeena', 1, N'cus_EGfhcxG5ve7X0K')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsDisable], [CustomerId]) VALUES (N'1f98d599-f7d4-40f2-991f-13f84061d3d3', N'zubi9699@gmail.com', 0, N'ACkWByXim5KLWG2JOkJSwCweOoYx33ftPyVBkWFgSZTLcaLOq9UluEGaX7IV3K3yQQ==', N'4be95beb-aa6d-4094-9202-ff9f970bb271', N'03056470521', 0, 0, NULL, 0, 0, N'0', 0, N'cus_EH7H5mLczLoOYE')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsDisable], [CustomerId]) VALUES (N'57d92c18-8809-4dae-b84c-fcc3e69c7094', N'talha9699@gmail.com', 0, N'ABbIjFIEBdA1Mb2YRRFLkNPyMwWP8518mGiB7CaHwhSXYuq21WTlLTlGEt63YQhVjA==', N'cbf1e813-4a5d-43a0-b6d5-3e902301249f', N'+923070501323', 0, 0, NULL, 0, 0, N'eLvisH', 0, N'cus_E5UDNDAYWp2M15')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsDisable], [CustomerId]) VALUES (N'58824cc6-e676-4091-a4c8-0f27cbcbd18a', N'Rehman9699@gmail.com', 0, N'ANu5QVrWHz6cS7F60zxZodHf8P6vLWik0buz5hh5YNKmrX/0O9FX+ad58UdTAYh0EQ==', N'6cb5e9fd-eebc-4b67-9603-07f761a56e27', N'03056470521', 0, 0, NULL, 0, 0, N'RehmanIT', 0, N'cus_EGz7W3m1wCN4MH')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsDisable], [CustomerId]) VALUES (N'c75441b3-aa23-4fb0-a28c-0b3de5a3aa9f', N'arslan@gmail.com', 0, N'APOwgNJbB0BSf6l3x5DKXtC7Q8H4JHANBMdY7jKGHGK4B62RXMYmKIm2oUtcYuDyMA==', N'422a9aa6-fad5-4166-a8da-6132d0acf9c0', N'03056470521', 0, 0, NULL, 0, 0, N'Arslan', 1, N'cus_EH1TRbthGJfdM6')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsDisable], [CustomerId]) VALUES (N'fdc0635a-711b-4573-a66d-574133f018a8', N'talha9699@gmail.com', 0, N'ADowsJqbVutd5fGCHAyB0r2/0HB1A9xfPgOc9NtrJXvcfCLEBuIf9+kt5mWivRf/wg==', N'80115dd6-3626-40f4-8851-b0a43924e0fc', N'+923070501323', 0, 0, NULL, 0, 0, N'Shazmeena9699', 0, N'cus_EGfngMMr414Xxf')
SET IDENTITY_INSERT [dbo].[Carts] ON 

INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (1, 2, CAST(N'2019-01-02 00:00:00.0000000' AS DateTime2), 50, N'eLvisH', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (2, 2, CAST(N'2019-01-02 00:00:00.0000000' AS DateTime2), 49, N'eLvisH', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (3, 3, CAST(N'2019-01-02 00:00:00.0000000' AS DateTime2), 49, N'Talha9699', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (4, 3, CAST(N'2019-01-02 00:00:00.0000000' AS DateTime2), 50, N'Talha9699', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (5, 1, CAST(N'2019-01-02 00:00:00.0000000' AS DateTime2), 51, N'Shazmeena9699', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (6, 1, CAST(N'2019-01-02 00:00:00.0000000' AS DateTime2), 50, N'Shazmeena9699', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (7, 2, CAST(N'2019-01-02 00:00:00.0000000' AS DateTime2), 49, N'Shazmeena9699', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (8, 1, CAST(N'2019-01-03 00:00:00.0000000' AS DateTime2), 49, N'RehmanIT', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (9, 2, CAST(N'2019-01-03 00:00:00.0000000' AS DateTime2), 50, N'RehmanIT', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (10, 1, CAST(N'2019-01-03 00:00:00.0000000' AS DateTime2), 49, N'Arslan', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (11, 1, CAST(N'2019-01-03 00:00:00.0000000' AS DateTime2), 51, N'RehmanIT', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (12, 1, CAST(N'2019-01-03 00:00:00.0000000' AS DateTime2), 51, N'0', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (13, 1, CAST(N'2019-01-03 00:00:00.0000000' AS DateTime2), 50, N'0', 0)
INSERT [dbo].[Carts] ([CartId], [ItemsQunatity], [DateCreated], [ItemsId], [CustomerName], [isDisable]) VALUES (14, 1, CAST(N'2019-01-03 00:00:00.0000000' AS DateTime2), 49, N'0', 0)
SET IDENTITY_INSERT [dbo].[Carts] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoriesId], [CategoriesName]) VALUES (1, N'Burger')
INSERT [dbo].[Categories] ([CategoriesId], [CategoriesName]) VALUES (2, N'Pizza')
INSERT [dbo].[Categories] ([CategoriesId], [CategoriesName]) VALUES (3, N'Shawarma')
INSERT [dbo].[Categories] ([CategoriesId], [CategoriesName]) VALUES (4, N'Sandwich')
INSERT [dbo].[Categories] ([CategoriesId], [CategoriesName]) VALUES (5, N' Saucy Special')
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (1, 1)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (1, 2)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (1, 4)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (1, 5)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (1, 7)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (1, 8)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (1, 9)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (2, 1)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (2, 3)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (2, 6)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (2, 7)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (2, 9)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (3, 1)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (3, 3)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (3, 6)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (3, 7)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (3, 9)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (5, 1)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (5, 3)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (5, 4)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (5, 5)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (5, 7)
INSERT [dbo].[CategoryIngredient] ([CatId], [IngredientId]) VALUES (5, 8)
SET IDENTITY_INSERT [dbo].[Ingredients] ON 

INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (1, N'Onion')
INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (2, N'Tomatto')
INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (3, N'Chiken')
INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (4, N'Myonese')
INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (5, N'Bun')
INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (6, N'Bread')
INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (7, N'Cheese')
INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (8, N'Hot Wings')
INSERT [dbo].[Ingredients] ([IngredientId], [IngredientName]) VALUES (9, N'Yougurt')
SET IDENTITY_INSERT [dbo].[Ingredients] OFF
SET IDENTITY_INSERT [dbo].[Items] ON 

INSERT [dbo].[Items] ([ItemId], [Name], [Price], [ImageUrl], [CategoriesId], [IsDisable]) VALUES (49, N'Grilled Tripple Chee', 790.0000, N'http://localhost:49478/Images/ea7cbe63-42b8-4769-8d5b-0e7e0ab34845.jpg', 1, 0)
INSERT [dbo].[Items] ([ItemId], [Name], [Price], [ImageUrl], [CategoriesId], [IsDisable]) VALUES (50, N'Cheese Shawarma', 300.0000, N'http://localhost:49478/Images/ee52615e-b8af-4083-9f17-9f9f602ba93e.jpg', 3, 0)
INSERT [dbo].[Items] ([ItemId], [Name], [Price], [ImageUrl], [CategoriesId], [IsDisable]) VALUES (51, N'Saucy Special Burger', 560.0000, N'http://localhost:49478/Images/95c3e684-b6d3-4c26-9016-35109ed2299e.jpg', 1, 0)
INSERT [dbo].[Items] ([ItemId], [Name], [Price], [ImageUrl], [CategoriesId], [IsDisable]) VALUES (52, N'Cheese Pizza', 999.0000, N'http://localhost:49478/Images/59a04876-bdc6-4320-b806-1f82410ffeb9.jpg', 2, 0)
SET IDENTITY_INSERT [dbo].[Items] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (1, CAST(N'2019-01-02 16:18:05.2483014' AS DateTime2), 50, 300.0000, N'eLvisH', 2)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (2, CAST(N'2019-01-02 16:18:05.2603032' AS DateTime2), 49, 790.0000, N'eLvisH', 2)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (3, CAST(N'2019-01-02 16:36:43.5530567' AS DateTime2), 49, 790.0000, N'Talha9699', 3)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (4, CAST(N'2019-01-02 16:36:43.5686848' AS DateTime2), 50, 300.0000, N'Talha9699', 3)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (5, CAST(N'2019-01-02 17:00:42.7589592' AS DateTime2), 51, 560.0000, N'Shazmeena9699', 1)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (6, CAST(N'2019-01-02 17:00:42.7901932' AS DateTime2), 50, 300.0000, N'Shazmeena9699', 1)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (7, CAST(N'2019-01-02 17:00:42.7901932' AS DateTime2), 49, 790.0000, N'Shazmeena9699', 1)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (8, CAST(N'2019-01-02 17:03:57.9136411' AS DateTime2), 49, 790.0000, N'Shazmeena9699', 1)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (9, CAST(N'2019-01-03 13:01:53.5768190' AS DateTime2), 49, 790.0000, N'RehmanIT', 1)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (10, CAST(N'2019-01-03 13:01:53.6080514' AS DateTime2), 50, 300.0000, N'RehmanIT', 1)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (11, CAST(N'2019-01-03 15:28:24.8116799' AS DateTime2), 49, 790.0000, N'Arslan', 1)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (12, CAST(N'2019-01-03 21:26:41.2772288' AS DateTime2), 51, 560.0000, N'RehmanIT', 1)
INSERT [dbo].[Orders] ([OrderId], [DateCreated], [ItemId], [PricePerUnit], [OrderedBy], [ItemsQuantity]) VALUES (13, CAST(N'2019-01-03 21:26:41.2928527' AS DateTime2), 50, 300.0000, N'RehmanIT', 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 1/6/2019 7:54:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 1/6/2019 7:54:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 1/6/2019 7:54:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 1/6/2019 7:54:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 1/6/2019 7:54:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 1/6/2019 7:54:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Items] FOREIGN KEY([ItemsId])
REFERENCES [dbo].[Items] ([ItemId])
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Items]
GO
ALTER TABLE [dbo].[CategoryIngredient]  WITH CHECK ADD  CONSTRAINT [FK_CategoryIngredient_Categories] FOREIGN KEY([CatId])
REFERENCES [dbo].[Categories] ([CategoriesId])
GO
ALTER TABLE [dbo].[CategoryIngredient] CHECK CONSTRAINT [FK_CategoryIngredient_Categories]
GO
ALTER TABLE [dbo].[CategoryIngredient]  WITH CHECK ADD  CONSTRAINT [FK_CategoryIngredient_Ingredients] FOREIGN KEY([IngredientId])
REFERENCES [dbo].[Ingredients] ([IngredientId])
GO
ALTER TABLE [dbo].[CategoryIngredient] CHECK CONSTRAINT [FK_CategoryIngredient_Ingredients]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Categories] FOREIGN KEY([CategoriesId])
REFERENCES [dbo].[Categories] ([CategoriesId])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Categories]
GO
ALTER TABLE [dbo].[ItemsIngredients]  WITH CHECK ADD  CONSTRAINT [FK_ItemsIngredients_Ingredients] FOREIGN KEY([IngredientId])
REFERENCES [dbo].[Ingredients] ([IngredientId])
GO
ALTER TABLE [dbo].[ItemsIngredients] CHECK CONSTRAINT [FK_ItemsIngredients_Ingredients]
GO
ALTER TABLE [dbo].[ItemsIngredients]  WITH CHECK ADD  CONSTRAINT [FK_ItemsIngredients_Items] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([ItemId])
GO
ALTER TABLE [dbo].[ItemsIngredients] CHECK CONSTRAINT [FK_ItemsIngredients_Items]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Items] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([ItemId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Items]
GO
/****** Object:  StoredProcedure [dbo].[deleteCart]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[deleteCart]
@cartId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Carts set isDisable=1 where CartId=@cartId;
END

GO
/****** Object:  StoredProcedure [dbo].[deleteItem]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[deleteItem]
	@ItemId	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    update Items set IsDisable=1
	where ItemId=@ItemId;
END

GO
/****** Object:  StoredProcedure [dbo].[getAuthenticatedCart]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getAuthenticatedCart]
	@CustomerName	 varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select Carts.CartId,Carts.ItemsQunatity,Carts.DateCreated,Carts.ItemsId,Items.ItemId,Items.Price,Items.Name,Items.ImageUrl
	from Carts
	inner join Items
	on Carts.ItemsId=Items.ItemId
	where Carts.CustomerName=@CustomerName and Carts.isDisable=0;
END

GO
/****** Object:  StoredProcedure [dbo].[getCartsList]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getCartsList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Carts.CartId,Carts.DateCreated,Carts.ItemsQunatity,Items.ItemId,Items.Price,Items.Name,Items.ImageUrl
	from Carts
	inner join Items
	on Items.ItemId=Carts.ItemsId
	where Items.IsDisable=0 and Carts.isDisable=0;
END

GO
/****** Object:  StoredProcedure [dbo].[getCategories]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getCategories]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   select Categories.CategoriesId,Categories.CategoriesName from Categories;
END

GO
/****** Object:  StoredProcedure [dbo].[getIngredientsByCategoryId]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getIngredientsByCategoryId]
	@CategoryId	int
AS
BEGIN
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select Ingredients.IngredientName 
from CategoryIngredient
inner join Ingredients
on CategoryIngredient.IngredientId=Ingredients.IngredientId
where CategoryIngredient.CatId=@CategoryId;

END

GO
/****** Object:  StoredProcedure [dbo].[getIngredientsList]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getIngredientsList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   select Ingredients.IngredientId,Ingredients.IngredientName from Ingredients;
END

GO
/****** Object:  StoredProcedure [dbo].[getItemByCatName]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getItemByCatName]
	@CategoriesName  varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select Items.ItemId,Items.Name,Items.Price,Items.ImageUrl,Categories.CategoriesId,Categories.CategoriesName
	from Categories
	inner join Items
	on Items.CategoriesId=Categories.CategoriesId
	where Categories.CategoriesName=@CategoriesName And Items.IsDisable=0;
    
END

GO
/****** Object:  StoredProcedure [dbo].[getItemById]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getItemById]
		@ItemId  int
As
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select Items.ItemId,Items.Name,Items.Price,Items.ImageUrl,Categories.CategoriesId,Categories.CategoriesName
	from Items
	inner join Categories
	on Items.CategoriesId=Categories.CategoriesId
	where Items.ItemId=@ItemId And Items.IsDisable=0 ;
END

GO
/****** Object:  StoredProcedure [dbo].[getItems]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getItems]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select Items.ItemId,Items.Name,Items.Price,Items.ImageUrl,Categories.CategoriesId,Categories.CategoriesName
	from Items
	inner join Categories
	on Items.CategoriesId=Categories.CategoriesId
	where Items.IsDisable = 0;
END

GO
/****** Object:  StoredProcedure [dbo].[getItemsByIngredientName]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getItemsByIngredientName]
	@IngredientName varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select Items.ItemId,Items.Name,Items.Price,Items.ImageUrl,Categories.CategoriesId,Categories.CategoriesName
	from Items
	inner join Categories
	on Items.CategoriesId=Categories.CategoriesId
	where Categories.CategoriesId=
	(	
		select CategoryIngredient.CatId
		from CategoryIngredient
		where CategoryIngredient.IngredientId=
		(
			select Ingredients.IngredientId from Ingredients where Ingredients.IngredientName=@IngredientName
		)
	)
	And Items.IsDisable=0;

END

GO
/****** Object:  StoredProcedure [dbo].[getOrderList]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getOrderList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Items.Name,Orders.PricePerUnit,Orders.ItemsQuantity,Orders.DateCreated,Orders.OrderedBy 
	from Orders
	inner join 
	Items 
	on Orders.ItemId=Items.ItemId;
END

GO
/****** Object:  StoredProcedure [dbo].[getOrdersByDate]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getOrdersByDate]
@date varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Orders
	WHERE DateCreated >= @date;
END

GO
/****** Object:  StoredProcedure [dbo].[getUserById]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getUserById]
	@UserId nvarchar(128)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from AspNetUsers
	where AspNetUsers.Id= @UserId;
END

GO
/****** Object:  StoredProcedure [dbo].[getUsersList]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getUsersList]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from AspNetUsers;
END

GO
/****** Object:  StoredProcedure [dbo].[saveItem]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[saveItem]
	@Name			varchar(20)		,
	@Price			money			,
	@ImageUrl		nvarchar(MAX)	,
	@CategoriesId   int	
AS
BEGIN
	SET NOCOUNT ON;
	Insert into Items(Name,Price,ImageUrl,CategoriesId,IsDisable) values(@Name,@Price,@ImageUrl,@CategoriesId,0);
END

GO
/****** Object:  StoredProcedure [dbo].[saveNewCart]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[saveNewCart]	
	@ItemsQuantity  int,
	@DateCreated   datetime2(7),
	@ItemsId      int,
	@CustomerName  varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Carts(ItemsQunatity,DateCreated,ItemsId,CustomerName,isDisable) values(@ItemsQuantity,@DateCreated,@ItemsId,@CustomerName,0);
END

GO
/****** Object:  StoredProcedure [dbo].[SaveNewItemsIngredients]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveNewItemsIngredients]
	@ItemId		int,
	@IngredientId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into ItemsIngredients (ItemId,IngredientId) values(@ItemId,@IngredientId);
END

GO
/****** Object:  StoredProcedure [dbo].[saveNewOrder]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[saveNewOrder]
	@DateCreated datetime2(7),
	@ItemId      int,
	@PricePerUnit money,
	@OrderedBy     varchar(30),
	@ItemsQUantity  int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Orders(DateCreated,ItemId,PricePerUnit,OrderedBy,ItemsQuantity) values(@DateCreated,@ItemId,@PricePerUnit,@OrderedBy,@ItemsQUantity);
END

GO
/****** Object:  StoredProcedure [dbo].[updateCart]    Script Date: 1/6/2019 7:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateCart]
	@CartId			int,
	@ItemsQuantity	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update Carts 
	set ItemsQunatity=@ItemsQuantity
	where CartId=@CartId;
END

GO
USE [master]
GO
ALTER DATABASE [E_Commerce] SET  READ_WRITE 
GO
