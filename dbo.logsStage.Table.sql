USE [PBI]
GO
/****** Object:  Table [dbo].[logsStage]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logsStage](
	[RowID] [bigint] IDENTITY(1,1) NOT NULL,
	[DateID] [int] NULL,
	[Source] [nvarchar](50) NULL,
	[Message] [nvarchar](255) NULL,
	[Status] [nvarchar](20) NULL,
	[TimeStamp] [datetime] NULL,
 CONSTRAINT [PK_logStage] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
