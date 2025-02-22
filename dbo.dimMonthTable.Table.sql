USE [PBI]
GO
/****** Object:  Table [dbo].[dimMonthTable]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimMonthTable](
	[MonthNum] [int] NOT NULL,
	[MonthName] [nvarchar](50) NULL,
	[QuartalName] [nvarchar](50) NULL,
	[BusinessName] [nvarchar](50) NULL,
	[ClosingName] [nvarchar](50) NULL,
 CONSTRAINT [PK_dimMonthTable] PRIMARY KEY CLUSTERED 
(
	[MonthNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
