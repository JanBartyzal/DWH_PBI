USE [PBI]
GO
/****** Object:  Table [dbo].[dimStatusEnforcment]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimStatusEnforcment](
	[StatusEnforcmentId] [int] IDENTITY(1,1) NOT NULL,
	[StatusEnforcmentName] [nvarchar](50) NULL,
	[StatusEnforcmentCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_dimStatusEnforcment] PRIMARY KEY CLUSTERED 
(
	[StatusEnforcmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
