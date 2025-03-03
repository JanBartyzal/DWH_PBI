USE [PBI]
GO
/****** Object:  Table [dbo].[dimCostCenter]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimCostCenter](
	[CostCenterId] [int] IDENTITY(1,1) NOT NULL,
	[SectionId] [int] NULL,
	[CostCenterNumber] [int] NULL,
	[CostCenterName] [nvarchar](100) NULL,
 CONSTRAINT [PK_dimCostCenter] PRIMARY KEY CLUSTERED 
(
	[CostCenterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimCostCenter]  WITH CHECK ADD  CONSTRAINT [FK_dimCostCenter_dimSection] FOREIGN KEY([SectionId])
REFERENCES [dbo].[dimSection] ([SectionId])
GO
ALTER TABLE [dbo].[dimCostCenter] CHECK CONSTRAINT [FK_dimCostCenter_dimSection]
GO
