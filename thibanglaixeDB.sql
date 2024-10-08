USE [master]
GO
/****** Object:  Database [ThiBangLaiXe]    Script Date: 7/20/2024 5:05:28 PM ******/
CREATE DATABASE [ThiBangLaiXe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ThiBangLaiXe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ThiBangLaiXe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ThiBangLaiXe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ThiBangLaiXe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ThiBangLaiXe] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ThiBangLaiXe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ThiBangLaiXe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET ARITHABORT OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ThiBangLaiXe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ThiBangLaiXe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ThiBangLaiXe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ThiBangLaiXe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET RECOVERY FULL 
GO
ALTER DATABASE [ThiBangLaiXe] SET  MULTI_USER 
GO
ALTER DATABASE [ThiBangLaiXe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ThiBangLaiXe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ThiBangLaiXe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ThiBangLaiXe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ThiBangLaiXe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ThiBangLaiXe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ThiBangLaiXe', N'ON'
GO
ALTER DATABASE [ThiBangLaiXe] SET QUERY_STORE = OFF
GO
USE [ThiBangLaiXe]
GO
/****** Object:  Table [dbo].[answer_question]    Script Date: 7/20/2024 5:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[answer_question](
	[answerID] [int] IDENTITY(1,1) NOT NULL,
	[questionID] [int] NOT NULL,
	[correct] [bit] NOT NULL,
	[createAt] [datetime] NOT NULL,
	[updateAt] [datetime] NOT NULL,
	[answerContent] [nvarchar](max) NOT NULL,
	[active] [bit] NOT NULL,
 CONSTRAINT [PK_answer_question] PRIMARY KEY CLUSTERED 
(
	[answerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 7/20/2024 5:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[caID] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](50) NOT NULL,
	[categoryContent] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[caID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question]    Script Date: 7/20/2024 5:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question](
	[questionID] [int] IDENTITY(1,1) NOT NULL,
	[caID] [int] NOT NULL,
	[score] [float] NOT NULL,
	[questionContent] [nvarchar](max) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updateAt] [datetime] NOT NULL,
	[status] [bit] NOT NULL,
	[image] [nvarchar](200) NULL,
 CONSTRAINT [PK_question] PRIMARY KEY CLUSTERED 
(
	[questionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question_quiz]    Script Date: 7/20/2024 5:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question_quiz](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[questionID] [int] NOT NULL,
	[quizID] [int] NOT NULL,
 CONSTRAINT [PK_question_quiz_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quiz]    Script Date: 7/20/2024 5:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quiz](
	[quizID] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[caID] [int] NOT NULL,
	[score] [float] NOT NULL,
	[time] [int] NOT NULL,
	[quizContent] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_quiz] PRIMARY KEY CLUSTERED 
(
	[quizID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[take]    Script Date: 7/20/2024 5:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[take](
	[takeID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[quizID] [int] NOT NULL,
	[score] [float] NOT NULL,
	[startAt] [datetime] NOT NULL,
	[endAt] [datetime] NOT NULL,
	[takeContent] [nvarchar](max) NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_take] PRIMARY KEY CLUSTERED 
(
	[takeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[take_answer]    Script Date: 7/20/2024 5:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[take_answer](
	[take_answerID] [int] IDENTITY(1,1) NOT NULL,
	[questionID] [int] NOT NULL,
	[answerID] [int] NOT NULL,
	[takeID] [int] NOT NULL,
	[take_answerContent] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_take_answer] PRIMARY KEY CLUSTERED 
(
	[take_answerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 7/20/2024 5:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](50) NOT NULL,
	[lastName] [nvarchar](50) NOT NULL,
	[email] [nvarchar](100) NULL,
	[phone] [nchar](12) NOT NULL,
	[password] [nchar](50) NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[answer_question] ON 

INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (20, 56, 0, CAST(N'2024-07-18T06:42:10.670' AS DateTime), CAST(N'2024-07-18T06:42:10.670' AS DateTime), N'Phần mặt đường và lề đường.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (21, 56, 1, CAST(N'2024-07-18T06:42:10.723' AS DateTime), CAST(N'2024-07-18T06:42:10.723' AS DateTime), N'Phần đường xe chạy.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (22, 56, 0, CAST(N'2024-07-18T06:42:10.723' AS DateTime), CAST(N'2024-07-18T06:42:10.723' AS DateTime), N'Phần đường xe cơ giới.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (23, 57, 0, CAST(N'2024-07-18T06:43:07.150' AS DateTime), CAST(N'2024-07-18T06:43:07.150' AS DateTime), N'Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, sử dụng cho xe chạy.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (24, 57, 1, CAST(N'2024-07-18T06:43:07.153' AS DateTime), CAST(N'2024-07-18T06:43:07.153' AS DateTime), N'Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, có bề rộng đủ cho xe chạy an toàn.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (25, 57, 0, CAST(N'2024-07-18T06:43:07.153' AS DateTime), CAST(N'2024-07-18T06:43:07.153' AS DateTime), N'Là đường cho xe ô tô chạy, dừng, đỗ an toàn.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (26, 58, 0, CAST(N'2024-07-18T06:43:41.210' AS DateTime), CAST(N'2024-07-18T06:43:41.210' AS DateTime), N'Là bộ phận của đường để ngăn cách không cho các loại xe vào những nơi không được phép.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (27, 58, 0, CAST(N'2024-07-18T06:43:41.210' AS DateTime), CAST(N'2024-07-18T06:43:41.210' AS DateTime), N'Là bộ phận của đường để phân tách phần đường xe chạy và hành lang an toàn giao thông.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (28, 58, 1, CAST(N'2024-07-18T06:43:41.210' AS DateTime), CAST(N'2024-07-18T06:43:41.210' AS DateTime), N'Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (29, 59, 1, CAST(N'2024-07-18T06:44:13.107' AS DateTime), CAST(N'2024-07-18T06:44:13.107' AS DateTime), N'Dải phân cách gồm loại cố định và loại di động.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (30, 59, 0, CAST(N'2024-07-18T06:44:13.110' AS DateTime), CAST(N'2024-07-18T06:44:13.110' AS DateTime), N'Dải phân cách gồm tường chống ồn, hộ lan cứng và hộ lan mềm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (31, 59, 0, CAST(N'2024-07-18T06:44:13.110' AS DateTime), CAST(N'2024-07-18T06:44:13.110' AS DateTime), N'Dải phân cách gồm giá long môn và biển báo hiệu đường bộ.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (32, 60, 1, CAST(N'2024-07-18T06:44:49.940' AS DateTime), CAST(N'2024-07-18T06:44:49.940' AS DateTime), N'Là người điều khiển xe cơ giới.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (33, 60, 0, CAST(N'2024-07-18T06:44:49.943' AS DateTime), CAST(N'2024-07-18T06:44:49.943' AS DateTime), N'Là người điều khiển xe thô sơ.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (34, 60, 0, CAST(N'2024-07-18T06:44:49.943' AS DateTime), CAST(N'2024-07-18T06:44:49.943' AS DateTime), N'Là người điều khiển xe có súc vật kéo.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (35, 61, 0, CAST(N'2024-07-18T06:45:48.860' AS DateTime), CAST(N'2024-07-18T06:45:48.860' AS DateTime), N'Đường không ưu tiên', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (36, 61, 0, CAST(N'2024-07-18T06:45:48.860' AS DateTime), CAST(N'2024-07-18T06:45:48.860' AS DateTime), N'Đường tỉnh lộ.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (37, 61, 0, CAST(N'2024-07-18T06:45:48.860' AS DateTime), CAST(N'2024-07-18T06:45:48.860' AS DateTime), N'Đường quốc lộ.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (38, 61, 1, CAST(N'2024-07-18T06:45:48.860' AS DateTime), CAST(N'2024-07-18T06:45:48.860' AS DateTime), N'Đường ưu tiên.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (39, 62, 0, CAST(N'2024-07-18T06:46:11.273' AS DateTime), CAST(N'2024-07-18T06:46:11.273' AS DateTime), N'Gồm xe ô tô; máy kéo; xe mô tô hai bánh; xe mô tô ba bánh; xe gắn máy; xe cơ giới dùng cho người khuyết tật và xe máy chuyên dùng.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (40, 62, 1, CAST(N'2024-07-18T06:46:11.273' AS DateTime), CAST(N'2024-07-18T06:46:11.273' AS DateTime), N'Gồm ô tô; máy kéo; rơ moóc hoặc sơ mi rơ moóc được kéo bởi xe ô tô, máy kéo; xe mô tô hai bánh; xe mô tô ba bánh, xe gắn máy (kể cả xe máy điện) và các loại xe tương tự.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (41, 63, 0, CAST(N'2024-07-18T06:46:47.247' AS DateTime), CAST(N'2024-07-18T06:46:47.247' AS DateTime), N'Phương tiện giao thông cơ giới đường bộ.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (42, 63, 0, CAST(N'2024-07-18T06:46:47.247' AS DateTime), CAST(N'2024-07-18T06:46:47.247' AS DateTime), N'Phương tiện giao thông thô sơ đường bộ và xe máy chuyên dùng.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (43, 63, 1, CAST(N'2024-07-18T06:46:47.247' AS DateTime), CAST(N'2024-07-18T06:46:47.247' AS DateTime), N'Cả ý 1 và ý 2.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (44, 64, 0, CAST(N'2024-07-18T06:47:14.143' AS DateTime), CAST(N'2024-07-18T06:47:14.143' AS DateTime), N'Người điều khiển, người sử dụng phương tiện tham gia giao thông đường bộ.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (45, 64, 0, CAST(N'2024-07-18T06:47:14.143' AS DateTime), CAST(N'2024-07-18T06:47:14.143' AS DateTime), N'Người điều khiển, dẫn dắt súc vật; người đi bộ trên đường bộ.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (46, 64, 1, CAST(N'2024-07-18T06:47:14.143' AS DateTime), CAST(N'2024-07-18T06:47:14.143' AS DateTime), N'Cả ý 1 và ý 2.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (47, 65, 0, CAST(N'2024-07-18T06:47:44.887' AS DateTime), CAST(N'2024-07-18T06:47:44.887' AS DateTime), N'Là trạng thái đứng yên của phương tiện giao thông có thời hạn trong một khoảng thời gian cần thiết đủ để cho người lên, xuống phương tiện, xếp dỡ hàng hóa hoặc thực hiện công việc khác.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (48, 65, 1, CAST(N'2024-07-18T06:47:44.890' AS DateTime), CAST(N'2024-07-18T06:47:44.890' AS DateTime), N'Là trạng thái đứng yên của phương tiện giao thông không giới hạn thời gian.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (49, 66, 1, CAST(N'2024-07-18T06:48:19.720' AS DateTime), CAST(N'2024-07-18T06:48:19.720' AS DateTime), N'Bị nghiêm cấm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (50, 66, 0, CAST(N'2024-07-18T06:48:19.720' AS DateTime), CAST(N'2024-07-18T06:48:19.720' AS DateTime), N'Không bị nghiêm cấm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (51, 66, 0, CAST(N'2024-07-18T06:48:19.720' AS DateTime), CAST(N'2024-07-18T06:48:19.720' AS DateTime), N'Không bị nghiêm cấm, nếu có chất ma túy ở mức nhẹ, có thể điều khiển phương tiện tham gia giao thông.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (52, 67, 0, CAST(N'2024-07-18T06:48:50.733' AS DateTime), CAST(N'2024-07-18T06:48:50.733' AS DateTime), N'Từ 22 giờ đêm đến 5 giờ sáng.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (53, 67, 1, CAST(N'2024-07-18T06:48:50.733' AS DateTime), CAST(N'2024-07-18T06:48:50.733' AS DateTime), N'Từ 5 giờ sáng đến 22 giờ tối.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (54, 67, 0, CAST(N'2024-07-18T06:48:50.733' AS DateTime), CAST(N'2024-07-18T06:48:50.733' AS DateTime), N'Từ 23 giờ đêm đến 5 giờ sáng hôm sau.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (55, 68, 0, CAST(N'2024-07-18T06:50:23.110' AS DateTime), CAST(N'2024-07-18T06:50:23.110' AS DateTime), N'Biển báo nguy hiểm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (56, 68, 1, CAST(N'2024-07-18T06:50:23.110' AS DateTime), CAST(N'2024-07-18T06:50:23.110' AS DateTime), N'Biển báo cấm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (57, 68, 0, CAST(N'2024-07-18T06:50:23.110' AS DateTime), CAST(N'2024-07-18T06:50:23.110' AS DateTime), N'Biển báo hiệu lệnh.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (58, 68, 0, CAST(N'2024-07-18T06:50:23.110' AS DateTime), CAST(N'2024-07-18T06:50:23.110' AS DateTime), N'Biển báo chỉ dẫn.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (59, 69, 1, CAST(N'2024-07-18T06:51:20.277' AS DateTime), CAST(N'2024-07-18T06:51:20.277' AS DateTime), N'Biển báo nguy hiểm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (60, 69, 0, CAST(N'2024-07-18T06:51:20.277' AS DateTime), CAST(N'2024-07-18T06:51:20.277' AS DateTime), N'Biển báo cấm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (61, 69, 0, CAST(N'2024-07-18T06:51:20.280' AS DateTime), CAST(N'2024-07-18T06:51:20.280' AS DateTime), N'Biển báo hiệu lệnh.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (62, 69, 0, CAST(N'2024-07-18T06:51:20.280' AS DateTime), CAST(N'2024-07-18T06:51:20.280' AS DateTime), N'Biển báo chỉ dẫn.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (63, 70, 0, CAST(N'2024-07-18T06:52:12.933' AS DateTime), CAST(N'2024-07-18T06:52:12.933' AS DateTime), N'Biển báo nguy hiểm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (64, 70, 0, CAST(N'2024-07-18T06:52:12.933' AS DateTime), CAST(N'2024-07-18T06:52:12.933' AS DateTime), N'Biển báo cấm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (65, 70, 1, CAST(N'2024-07-18T06:52:12.933' AS DateTime), CAST(N'2024-07-18T06:52:12.933' AS DateTime), N'Biển báo hiệu lệnh phải thi hành.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (66, 70, 0, CAST(N'2024-07-18T06:52:12.933' AS DateTime), CAST(N'2024-07-18T06:52:12.933' AS DateTime), N'Biển báo chỉ dẫn.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (67, 71, 0, CAST(N'2024-07-18T06:52:55.137' AS DateTime), CAST(N'2024-07-18T06:52:55.137' AS DateTime), N'Biển báo nguy hiểm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (68, 71, 0, CAST(N'2024-07-18T06:52:55.137' AS DateTime), CAST(N'2024-07-18T06:52:55.137' AS DateTime), N'Biển báo cấm.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (69, 71, 0, CAST(N'2024-07-18T06:52:55.137' AS DateTime), CAST(N'2024-07-18T06:52:55.137' AS DateTime), N'Biển báo hiệu lệnh phải thi hành.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (70, 71, 1, CAST(N'2024-07-18T06:52:55.137' AS DateTime), CAST(N'2024-07-18T06:52:55.137' AS DateTime), N'Biển báo chỉ dẫn.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (71, 72, 0, CAST(N'2024-07-18T06:53:41.107' AS DateTime), CAST(N'2024-07-18T06:53:41.107' AS DateTime), N'Người tham gia giao thông ở các hướng phải dừng lại.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (72, 72, 0, CAST(N'2024-07-18T06:53:41.107' AS DateTime), CAST(N'2024-07-18T06:53:41.107' AS DateTime), N'Người tham gia giao thông ở các hướng được đi theo chiều gậy chỉ của cảnh sát giao thông.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (73, 72, 0, CAST(N'2024-07-18T06:53:41.107' AS DateTime), CAST(N'2024-07-18T06:53:41.107' AS DateTime), N'Người tham gia giao thông ở phía trước và phía sau người điều khiển được đi tất cả các hướng; người tham gia giao thông ở phía bên phải và phía bên trái người điều khiển phải dừng lại.', 1)
INSERT [dbo].[answer_question] ([answerID], [questionID], [correct], [createAt], [updateAt], [answerContent], [active]) VALUES (74, 72, 1, CAST(N'2024-07-18T06:53:41.107' AS DateTime), CAST(N'2024-07-18T06:53:41.107' AS DateTime), N'Người tham gia giao thông ở phía trước và phía sau người điều khiển phải dừng lại; người tham gia giao thông ở phía bên phải và phía bên trái người điều khiển được đi tất cả các hướng.', 1)
SET IDENTITY_INSERT [dbo].[answer_question] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([caID], [categoryName], [categoryContent]) VALUES (6, N'A1', N'Thi bằng lái xe moto 50cc-110cc')
INSERT [dbo].[category] ([caID], [categoryName], [categoryContent]) VALUES (7, N'A2', N'Thi bằng lái xe moto 70cc-150cc')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[question] ON 

INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (56, 6, 1, N'Phần của đường bộ được sử dụng cho các phương tiện giao thông qua lại là gì?', CAST(N'2024-07-18T06:42:10.053' AS DateTime), CAST(N'2024-07-18T06:42:10.053' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (57, 6, 1, N'“Làn đường” là gì?', CAST(N'2024-07-18T06:43:07.120' AS DateTime), CAST(N'2024-07-18T06:43:07.120' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (58, 6, 1, N'Trong các khái niệm dưới đây, “dải phân cách” được hiểu như thế nào là đúng?', CAST(N'2024-07-18T06:43:41.173' AS DateTime), CAST(N'2024-07-18T06:43:41.173' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (59, 6, 1, N'“Dải phân cách” trên đường bộ gồm những loại nào?', CAST(N'2024-07-18T06:44:13.083' AS DateTime), CAST(N'2024-07-18T06:44:13.083' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (60, 6, 1, N'Người lái xe được hiểu như thế nào trong các khái niệm dưới đây?', CAST(N'2024-07-18T06:44:49.910' AS DateTime), CAST(N'2024-07-18T06:44:49.910' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (61, 6, 1, N'Đường mà trên đó phương tiện tham gia giao thông được các phương tiện giao thông đến từ các hướng khác nhường đường khi qua nơi đường giao nhau, được cắm biển báo hiệu đường ưu tiên là loại đường gì?', CAST(N'2024-07-18T06:45:48.837' AS DateTime), CAST(N'2024-07-18T06:45:48.837' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (62, 6, 1, N'Khái niệm “phương tiện giao thông cơ giới đường bộ” được hiểu như thế nào là đúng?', CAST(N'2024-07-18T06:46:11.237' AS DateTime), CAST(N'2024-07-18T06:46:11.237' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (63, 6, 1, N'“Phương tiện tham gia giao thông đường bộ” gồm những loại nào?', CAST(N'2024-07-18T06:46:47.220' AS DateTime), CAST(N'2024-07-18T06:46:47.220' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (64, 6, 1, N'“Người tham gia giao thông đường bộ” gồm những đối tượng nào?', CAST(N'2024-07-18T06:47:14.103' AS DateTime), CAST(N'2024-07-18T06:47:14.103' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (65, 6, 1, N'Khái niệm “đỗ xe” được hiểu như thế nào là đúng?', CAST(N'2024-07-18T06:47:44.850' AS DateTime), CAST(N'2024-07-18T06:47:44.850' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (66, 6, 1, N'Người điều khiển phương tiện giao thông đường bộ mà trong cơ thể có chất ma túy có bị nghiêm cấm hay không?', CAST(N'2024-07-18T06:48:19.680' AS DateTime), CAST(N'2024-07-18T06:48:19.680' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (67, 6, 1, N'Khi lái xe trong khu đô thị và đông dân cư trừ các khu vực có biển cấm sử dụng còi, người lái xe được sử dụng còi như thế nào trong các trường hợp dưới đây?', CAST(N'2024-07-18T06:48:50.683' AS DateTime), CAST(N'2024-07-18T06:48:50.683' AS DateTime), 1, NULL)
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (68, 6, 1, N'Biển báo hiệu có dạng hình tròn, viền đỏ, nền trắng, trên nền có hình vẽ hoặc chữ số, chữ viết màu đen là loại biển gì dưới đây?', CAST(N'2024-07-18T06:50:23.093' AS DateTime), CAST(N'2024-07-18T06:50:23.093' AS DateTime), 1, N'bien-1.png')
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (69, 6, 1, N' Biển báo hiệu có dạng tam giác đều, viền đỏ, nền màu vàng, trên có hình vẽ màu đen là loại biển gì dưới đây?', CAST(N'2024-07-18T06:51:20.260' AS DateTime), CAST(N'2024-07-18T06:51:20.260' AS DateTime), 1, N'bien-2.png')
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (70, 6, 1, N'Biển báo hiệu hình tròn có nền xanh lam có hình vẽ màu trắng là loại biển gì dưới đây?', CAST(N'2024-07-18T06:52:12.913' AS DateTime), CAST(N'2024-07-18T06:52:12.913' AS DateTime), 1, N'bien-3.png')
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (71, 6, 1, N'Biển báo hiệu hình chữ nhật hoặc hình vuông hoặc hình mũi tên nền xanh lam là loại biển gì dưới đây?', CAST(N'2024-07-18T06:52:55.113' AS DateTime), CAST(N'2024-07-18T06:52:55.113' AS DateTime), 1, N'bien-4.png')
INSERT [dbo].[question] ([questionID], [caID], [score], [questionContent], [createdAt], [updateAt], [status], [image]) VALUES (72, 6, 1, N'Khi gặp hiệu lệnh như dưới đây của cảnh sát giao thông thì người tham gia giao thông phải đi như thế nào là đúng quy tắc giao thông?

', CAST(N'2024-07-18T06:53:41.070' AS DateTime), CAST(N'2024-07-18T06:53:41.070' AS DateTime), 1, N'bien-5.png')
SET IDENTITY_INSERT [dbo].[question] OFF
GO
SET IDENTITY_INSERT [dbo].[question_quiz] ON 

INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (10, 56, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (11, 57, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (12, 58, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (13, 59, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (14, 60, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (15, 61, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (16, 63, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (17, 64, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (18, 65, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (19, 69, 18)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (20, 72, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (21, 71, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (22, 70, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (23, 69, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (24, 68, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (25, 67, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (26, 66, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (27, 65, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (28, 64, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (29, 63, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (30, 62, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (31, 61, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (32, 60, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (33, 59, 19)
INSERT [dbo].[question_quiz] ([id], [questionID], [quizID]) VALUES (34, 58, 19)
SET IDENTITY_INSERT [dbo].[question_quiz] OFF
GO
SET IDENTITY_INSERT [dbo].[quiz] ON 

INSERT [dbo].[quiz] ([quizID], [title], [caID], [score], [time], [quizContent]) VALUES (18, N'Bai kiem tra so 1', 6, 10, 30, N'Đề thi thử')
INSERT [dbo].[quiz] ([quizID], [title], [caID], [score], [time], [quizContent]) VALUES (19, N'Bài kiểm tra số 2', 6, 15, 20, N'Đề thi thử')
SET IDENTITY_INSERT [dbo].[quiz] OFF
GO
SET IDENTITY_INSERT [dbo].[take] ON 

INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (23, 1, 18, 5, CAST(N'2024-07-17T23:55:09.270' AS DateTime), CAST(N'2024-07-17T23:55:30.793' AS DateTime), N'{"56":{"answerContent":"Phần mặt đường và lề đường.","answerId":20},"57":{"answerContent":"Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, có bề rộng đủ cho xe chạy an toàn.","answerId":24},"58":{"answerContent":"Là bộ phận của đường để ngăn cách không cho các loại xe vào những nơi không được phép.","answerId":26},"59":{"answerContent":"Dải phân cách gồm tường chống ồn, hộ lan cứng và hộ lan mềm.","answerId":30},"60":{"answerContent":"Là người điều khiển xe thô sơ.","answerId":33},"61":{"answerContent":"Đường không ưu tiên","answerId":35},"63":{"answerContent":"Cả ý 1 và ý 2.","answerId":43},"64":{"answerContent":"Cả ý 1 và ý 2.","answerId":46},"65":{"answerContent":"Là trạng thái đứng yên của phương tiện giao thông không giới hạn thời gian.","answerId":48},"69":{"answerContent":"Biển báo nguy hiểm.","answerId":59}}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (24, 1, 18, 4, CAST(N'2024-07-19T15:53:27.667' AS DateTime), CAST(N'2024-07-19T15:53:45.123' AS DateTime), N'{"56":{"answerContent":"Phần đường xe chạy.","answerId":21},"57":{"answerContent":"Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, có bề rộng đủ cho xe chạy an toàn.","answerId":24},"58":{"answerContent":"Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.","answerId":28},"59":{"answerContent":"Dải phân cách gồm tường chống ồn, hộ lan cứng và hộ lan mềm.","answerId":30},"60":{"answerContent":"Là người điều khiển xe thô sơ.","answerId":33},"61":{"answerContent":"Đường không ưu tiên","answerId":35},"63":{"answerContent":"Phương tiện giao thông cơ giới đường bộ.","answerId":41},"64":{"answerContent":"Cả ý 1 và ý 2.","answerId":46},"65":{"answerContent":"Là trạng thái đứng yên của phương tiện giao thông có thời hạn trong một khoảng thời gian cần thiết đủ để cho người lên, xuống phương tiện, xếp dỡ hàng hóa hoặc thực hiện công việc khác.","answerId":47},"69":{"answerContent":"Biển báo hiệu lệnh.","answerId":61}}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (25, 1, 18, 5, CAST(N'2024-07-19T16:34:13.473' AS DateTime), CAST(N'2024-07-19T16:34:32.500' AS DateTime), N'{"56":{"answerContent":"Phần đường xe cơ giới.","answerId":22},"57":{"answerContent":"Là đường cho xe ô tô chạy, dừng, đỗ an toàn.","answerId":25},"58":{"answerContent":"Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.","answerId":28},"59":{"answerContent":"Dải phân cách gồm giá long môn và biển báo hiệu đường bộ.","answerId":31},"60":{"answerContent":"Là người điều khiển xe có súc vật kéo.","answerId":34},"61":{"answerContent":"Đường ưu tiên.","answerId":38},"63":{"answerContent":"Cả ý 1 và ý 2.","answerId":43},"64":{"answerContent":"Cả ý 1 và ý 2.","answerId":46},"65":{"answerContent":"Là trạng thái đứng yên của phương tiện giao thông không giới hạn thời gian.","answerId":48},"69":{"answerContent":"Biển báo chỉ dẫn.","answerId":62}}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (26, 1, 19, 4, CAST(N'2024-07-19T17:22:05.543' AS DateTime), CAST(N'2024-07-19T17:22:35.907' AS DateTime), N'{"58":{"answerContent":"Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.","answerId":28},"59":{"answerContent":"Dải phân cách gồm giá long môn và biển báo hiệu đường bộ.","answerId":31},"60":{"answerContent":"Là người điều khiển xe thô sơ.","answerId":33},"61":{"answerContent":"Đường ưu tiên.","answerId":38},"62":{"answerContent":"Gồm ô tô; máy kéo; rơ moóc hoặc sơ mi rơ moóc được kéo bởi xe ô tô, máy kéo; xe mô tô hai bánh; xe mô tô ba bánh, xe gắn máy (kể cả xe máy điện) và các loại xe tương tự.","answerId":40},"63":{"answerContent":"Phương tiện giao thông thô sơ đường bộ và xe máy chuyên dùng.","answerId":42},"64":{"answerContent":"Người điều khiển, dẫn dắt súc vật; người đi bộ trên đường bộ.","answerId":45},"65":{"answerContent":"Là trạng thái đứng yên của phương tiện giao thông không giới hạn thời gian.","answerId":48},"66":{"answerContent":"Không bị nghiêm cấm, nếu có chất ma túy ở mức nhẹ, có thể điều khiển phương tiện tham gia giao thông.","answerId":51},"67":{"answerContent":"Từ 22 giờ đêm đến 5 giờ sáng.","answerId":52},"68":{"answerContent":"Biển báo nguy hiểm.","answerId":55},"69":{"answerContent":"Biển báo hiệu lệnh.","answerId":61},"70":{"answerContent":"Biển báo cấm.","answerId":64},"71":{"answerContent":"Biển báo nguy hiểm.","answerId":67},"72":{"answerContent":"Người tham gia giao thông ở phía trước và phía sau người điều khiển được đi tất cả các hướng; người tham gia giao thông ở phía bên phải và phía bên trái người điều khiển phải dừng lại.","answerId":73}}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (27, 1, 19, 0, CAST(N'2024-07-20T02:40:33.003' AS DateTime), CAST(N'2024-07-20T02:40:52.037' AS DateTime), N'{"70":{"answerContent":"Biển báo cấm.","answerId":64},"71":{"answerContent":"Biển báo cấm.","answerId":68},"72":{"answerContent":"Người tham gia giao thông ở các hướng được đi theo chiều gậy chỉ của cảnh sát giao thông.","answerId":72}}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (28, 1, 19, 0, CAST(N'2024-07-20T03:43:25.247' AS DateTime), CAST(N'2024-07-20T03:43:52.023' AS DateTime), N'{"72":{"answerContent":"Người tham gia giao thông ở phía trước và phía sau người điều khiển được đi tất cả các hướng; người tham gia giao thông ở phía bên phải và phía bên trái người điều khiển phải dừng lại.","answerId":73}}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (29, 1, 18, 0, CAST(N'2024-07-20T03:59:51.570' AS DateTime), CAST(N'2024-07-20T03:59:59.213' AS DateTime), N'{}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (30, 1, 18, 0, CAST(N'2024-07-20T04:00:37.287' AS DateTime), CAST(N'2024-07-20T04:00:46.150' AS DateTime), N'{}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (31, 1, 18, 0, CAST(N'2024-07-20T04:02:34.223' AS DateTime), CAST(N'2024-07-20T04:02:41.927' AS DateTime), N'{}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (32, 1, 18, 0, CAST(N'2024-07-20T04:03:11.543' AS DateTime), CAST(N'2024-07-20T04:03:17.453' AS DateTime), N'{}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (33, 1, 18, 0, CAST(N'2024-07-20T04:03:50.047' AS DateTime), CAST(N'2024-07-20T04:03:59.943' AS DateTime), N'{}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (34, 1, 18, 0, CAST(N'2024-07-20T04:04:13.197' AS DateTime), CAST(N'2024-07-20T04:04:26.863' AS DateTime), N'{}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (35, 1, 18, 0, CAST(N'2024-07-20T04:06:23.780' AS DateTime), CAST(N'2024-07-20T04:06:29.767' AS DateTime), N'{}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (36, 1, 18, 0, CAST(N'2024-07-20T04:10:34.737' AS DateTime), CAST(N'2024-07-20T04:10:41.527' AS DateTime), N'{}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (37, 1, 18, 3, CAST(N'2024-07-20T04:10:34.737' AS DateTime), CAST(N'2024-07-20T04:11:37.087' AS DateTime), N'{"56":{"answerContent":"Phần đường xe chạy.","answerId":21},"57":{"answerContent":"Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, sử dụng cho xe chạy.","answerId":23},"58":{"answerContent":"Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.","answerId":28},"59":{"answerContent":"Dải phân cách gồm tường chống ồn, hộ lan cứng và hộ lan mềm.","answerId":30},"60":{"answerContent":"Là người điều khiển xe cơ giới.","answerId":32}}', 0)
INSERT [dbo].[take] ([takeID], [userID], [quizID], [score], [startAt], [endAt], [takeContent], [status]) VALUES (38, 1, 18, 2, CAST(N'2024-07-20T04:13:54.423' AS DateTime), CAST(N'2024-07-20T04:14:02.140' AS DateTime), N'{"56":{"answerContent":"Phần đường xe chạy.","answerId":21},"57":{"answerContent":"Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, có bề rộng đủ cho xe chạy an toàn.","answerId":24},"58":{"answerContent":"Là bộ phận của đường để phân tách phần đường xe chạy và hành lang an toàn giao thông.","answerId":27}}', 0)
SET IDENTITY_INSERT [dbo].[take] OFF
GO
SET IDENTITY_INSERT [dbo].[take_answer] ON 

INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (13, 56, 20, 23, N'Phần mặt đường và lề đường.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (14, 57, 24, 23, N'Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, có bề rộng đủ cho xe chạy an toàn.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (15, 58, 26, 23, N'Là bộ phận của đường để ngăn cách không cho các loại xe vào những nơi không được phép.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (16, 59, 30, 23, N'Dải phân cách gồm tường chống ồn, hộ lan cứng và hộ lan mềm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (17, 60, 33, 23, N'Là người điều khiển xe thô sơ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (18, 61, 35, 23, N'Đường không ưu tiên')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (19, 63, 43, 23, N'Cả ý 1 và ý 2.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (20, 64, 46, 23, N'Cả ý 1 và ý 2.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (21, 65, 48, 23, N'Là trạng thái đứng yên của phương tiện giao thông không giới hạn thời gian.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (22, 69, 59, 23, N'Biển báo nguy hiểm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (23, 56, 21, 24, N'Phần đường xe chạy.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (24, 57, 24, 24, N'Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, có bề rộng đủ cho xe chạy an toàn.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (25, 58, 28, 24, N'Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (26, 59, 30, 24, N'Dải phân cách gồm tường chống ồn, hộ lan cứng và hộ lan mềm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (27, 60, 33, 24, N'Là người điều khiển xe thô sơ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (28, 61, 35, 24, N'Đường không ưu tiên')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (29, 63, 41, 24, N'Phương tiện giao thông cơ giới đường bộ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (30, 64, 46, 24, N'Cả ý 1 và ý 2.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (31, 65, 47, 24, N'Là trạng thái đứng yên của phương tiện giao thông có thời hạn trong một khoảng thời gian cần thiết đủ để cho người lên, xuống phương tiện, xếp dỡ hàng hóa hoặc thực hiện công việc khác.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (32, 69, 61, 24, N'Biển báo hiệu lệnh.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (33, 56, 22, 25, N'Phần đường xe cơ giới.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (34, 57, 25, 25, N'Là đường cho xe ô tô chạy, dừng, đỗ an toàn.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (35, 58, 28, 25, N'Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (36, 59, 31, 25, N'Dải phân cách gồm giá long môn và biển báo hiệu đường bộ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (37, 60, 34, 25, N'Là người điều khiển xe có súc vật kéo.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (38, 61, 38, 25, N'Đường ưu tiên.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (39, 63, 43, 25, N'Cả ý 1 và ý 2.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (40, 64, 46, 25, N'Cả ý 1 và ý 2.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (41, 65, 48, 25, N'Là trạng thái đứng yên của phương tiện giao thông không giới hạn thời gian.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (42, 69, 62, 25, N'Biển báo chỉ dẫn.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (43, 58, 28, 26, N'Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (44, 59, 31, 26, N'Dải phân cách gồm giá long môn và biển báo hiệu đường bộ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (45, 60, 33, 26, N'Là người điều khiển xe thô sơ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (46, 61, 38, 26, N'Đường ưu tiên.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (47, 62, 40, 26, N'Gồm ô tô; máy kéo; rơ moóc hoặc sơ mi rơ moóc được kéo bởi xe ô tô, máy kéo; xe mô tô hai bánh; xe mô tô ba bánh, xe gắn máy (kể cả xe máy điện) và các loại xe tương tự.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (48, 63, 42, 26, N'Phương tiện giao thông thô sơ đường bộ và xe máy chuyên dùng.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (49, 64, 45, 26, N'Người điều khiển, dẫn dắt súc vật; người đi bộ trên đường bộ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (50, 65, 48, 26, N'Là trạng thái đứng yên của phương tiện giao thông không giới hạn thời gian.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (51, 66, 51, 26, N'Không bị nghiêm cấm, nếu có chất ma túy ở mức nhẹ, có thể điều khiển phương tiện tham gia giao thông.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (52, 67, 52, 26, N'Từ 22 giờ đêm đến 5 giờ sáng.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (53, 68, 55, 26, N'Biển báo nguy hiểm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (54, 69, 61, 26, N'Biển báo hiệu lệnh.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (55, 70, 64, 26, N'Biển báo cấm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (56, 71, 67, 26, N'Biển báo nguy hiểm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (57, 72, 73, 26, N'Người tham gia giao thông ở phía trước và phía sau người điều khiển được đi tất cả các hướng; người tham gia giao thông ở phía bên phải và phía bên trái người điều khiển phải dừng lại.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (58, 70, 64, 27, N'Biển báo cấm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (59, 71, 68, 27, N'Biển báo cấm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (60, 72, 72, 27, N'Người tham gia giao thông ở các hướng được đi theo chiều gậy chỉ của cảnh sát giao thông.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (61, 72, 73, 28, N'Người tham gia giao thông ở phía trước và phía sau người điều khiển được đi tất cả các hướng; người tham gia giao thông ở phía bên phải và phía bên trái người điều khiển phải dừng lại.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (62, 56, 21, 37, N'Phần đường xe chạy.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (63, 57, 23, 37, N'Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, sử dụng cho xe chạy.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (64, 58, 28, 37, N'Là bộ phận của đường để phân chia mặt đường thành hai chiều xe chạy riêng biệt hoặc để phân chia phần đường của xe cơ giới và xe thô sơ.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (65, 59, 30, 37, N'Dải phân cách gồm tường chống ồn, hộ lan cứng và hộ lan mềm.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (66, 60, 32, 37, N'Là người điều khiển xe cơ giới.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (67, 56, 21, 38, N'Phần đường xe chạy.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (68, 57, 24, 38, N'Là một phần của phần đường xe chạy được chia theo chiều dọc của đường, có bề rộng đủ cho xe chạy an toàn.')
INSERT [dbo].[take_answer] ([take_answerID], [questionID], [answerID], [takeID], [take_answerContent]) VALUES (69, 58, 27, 38, N'Là bộ phận của đường để phân tách phần đường xe chạy và hành lang an toàn giao thông.')
SET IDENTITY_INSERT [dbo].[take_answer] OFF
GO
SET IDENTITY_INSERT [dbo].[user] ON 

INSERT [dbo].[user] ([UID], [firstName], [lastName], [email], [phone], [password], [status]) VALUES (1, N'Sinh', N'Nguyen', N'isinh256@gmail.com', N'0383876125  ', N'12345678                                          ', 1)
INSERT [dbo].[user] ([UID], [firstName], [lastName], [email], [phone], [password], [status]) VALUES (2, N'ADMIN', N'Nguyen', N'admin', N'12345678    ', N'12345678                                          ', 1)
SET IDENTITY_INSERT [dbo].[user] OFF
GO
ALTER TABLE [dbo].[answer_question]  WITH CHECK ADD  CONSTRAINT [FK_answer_question_question] FOREIGN KEY([questionID])
REFERENCES [dbo].[question] ([questionID])
GO
ALTER TABLE [dbo].[answer_question] CHECK CONSTRAINT [FK_answer_question_question]
GO
ALTER TABLE [dbo].[question]  WITH CHECK ADD  CONSTRAINT [FK_question_category] FOREIGN KEY([caID])
REFERENCES [dbo].[category] ([caID])
GO
ALTER TABLE [dbo].[question] CHECK CONSTRAINT [FK_question_category]
GO
ALTER TABLE [dbo].[question_quiz]  WITH CHECK ADD  CONSTRAINT [FK_question_quiz_question] FOREIGN KEY([questionID])
REFERENCES [dbo].[question] ([questionID])
GO
ALTER TABLE [dbo].[question_quiz] CHECK CONSTRAINT [FK_question_quiz_question]
GO
ALTER TABLE [dbo].[question_quiz]  WITH CHECK ADD  CONSTRAINT [FK_question_quiz_quiz] FOREIGN KEY([quizID])
REFERENCES [dbo].[quiz] ([quizID])
GO
ALTER TABLE [dbo].[question_quiz] CHECK CONSTRAINT [FK_question_quiz_quiz]
GO
ALTER TABLE [dbo].[quiz]  WITH CHECK ADD  CONSTRAINT [FK_quiz_category] FOREIGN KEY([caID])
REFERENCES [dbo].[category] ([caID])
GO
ALTER TABLE [dbo].[quiz] CHECK CONSTRAINT [FK_quiz_category]
GO
ALTER TABLE [dbo].[take]  WITH CHECK ADD  CONSTRAINT [FK_take_quiz] FOREIGN KEY([quizID])
REFERENCES [dbo].[quiz] ([quizID])
GO
ALTER TABLE [dbo].[take] CHECK CONSTRAINT [FK_take_quiz]
GO
ALTER TABLE [dbo].[take]  WITH CHECK ADD  CONSTRAINT [FK_take_user] FOREIGN KEY([userID])
REFERENCES [dbo].[user] ([UID])
GO
ALTER TABLE [dbo].[take] CHECK CONSTRAINT [FK_take_user]
GO
ALTER TABLE [dbo].[take_answer]  WITH CHECK ADD  CONSTRAINT [FK_take_answer_answer_question] FOREIGN KEY([answerID])
REFERENCES [dbo].[answer_question] ([answerID])
GO
ALTER TABLE [dbo].[take_answer] CHECK CONSTRAINT [FK_take_answer_answer_question]
GO
ALTER TABLE [dbo].[take_answer]  WITH CHECK ADD  CONSTRAINT [FK_take_answer_question] FOREIGN KEY([questionID])
REFERENCES [dbo].[question] ([questionID])
GO
ALTER TABLE [dbo].[take_answer] CHECK CONSTRAINT [FK_take_answer_question]
GO
ALTER TABLE [dbo].[take_answer]  WITH CHECK ADD  CONSTRAINT [FK_take_answer_take] FOREIGN KEY([takeID])
REFERENCES [dbo].[take] ([takeID])
GO
ALTER TABLE [dbo].[take_answer] CHECK CONSTRAINT [FK_take_answer_take]
GO
USE [master]
GO
ALTER DATABASE [ThiBangLaiXe] SET  READ_WRITE 
GO
