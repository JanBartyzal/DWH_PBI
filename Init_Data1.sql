




insert into [dbo].[stgCFBanky]([Datum],[BankaUcet],[Mena],[StavMena],[TotalPrijem],[TotalVydej])
values ('2024-09-01', '10-12345678/0100', 'CZK', 1500000, 212000,215000),
('2024-09-01', '11-12345678/0100', 'CZK', 1500000, 212000,215000)

INSERT INTO [dbo].[stgCFInkasoVydej]([Datum],[TypCF],[KodUsek],[KodNS],[Castka])
VALUES('2024-09-01','Inkaso', 20,0,2500000),
('2024-09-01','Inkaso', 40,0,100000),
('2024-09-01','Inkaso', 60,0,5000),
('2024-09-01','VYD', 20,0,500000),
('2024-09-01','VYD', 40,0,10000)

