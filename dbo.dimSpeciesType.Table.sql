USE [PBI]
GO
/****** Object:  Table [dbo].[dimSpeciesType]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimSpeciesType](
	[SpeciesTypeId] [int] IDENTITY(1,1) NOT NULL,
	[SpeciesTypeName] [nvarchar](50) NULL,
	[SpeciesTypeCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_dimSpeciesType] PRIMARY KEY CLUSTERED 
(
	[SpeciesTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
