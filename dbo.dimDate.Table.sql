USE [PBI]
GO
/****** Object:  Table [dbo].[dimDate]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimDate](
	[DateID] [int] NOT NULL,
	[MonthNum] [int] NULL,
	[FullDate] [date] NULL,
 CONSTRAINT [PK_factDate] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimDate]  WITH CHECK ADD  CONSTRAINT [FK_dimDate_dimMonthTable] FOREIGN KEY([MonthNum])
REFERENCES [dbo].[dimMonthTable] ([MonthNum])
GO
ALTER TABLE [dbo].[dimDate] CHECK CONSTRAINT [FK_dimDate_dimMonthTable]
GO
