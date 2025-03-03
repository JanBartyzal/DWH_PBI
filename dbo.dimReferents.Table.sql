USE [PBI]
GO
/****** Object:  Table [dbo].[dimReferents]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimReferents](
	[ReferentId] [int] IDENTITY(1,1) NOT NULL,
	[ReferentCode] [nvarchar](25) NULL,
	[ReferentName] [nvarchar](255) NULL,
	[CostCenterId] [int] NULL,
	[SupervisorId] [int] NULL,
 CONSTRAINT [PK_Referents] PRIMARY KEY CLUSTERED 
(
	[ReferentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimReferents]  WITH CHECK ADD  CONSTRAINT [FK_dimReferents_dimCostCenter] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[dimCostCenter] ([CostCenterId])
GO
ALTER TABLE [dbo].[dimReferents] CHECK CONSTRAINT [FK_dimReferents_dimCostCenter]
GO
