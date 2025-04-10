USE [PBI]
GO
/****** Object:  Table [dbo].[dimCommitmentType]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimCommitmentType](
	[CommitmentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[CommitmentTypeName] [nvarchar](50) NULL,
	[CommitmentTypeCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_dimCommitmentType] PRIMARY KEY CLUSTERED 
(
	[CommitmentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_dimCommitmentType]    Script Date: 22.12.2024 18:08:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_dimCommitmentType] ON [dbo].[dimCommitmentType]
(
	[CommitmentTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
