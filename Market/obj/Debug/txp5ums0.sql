DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'Market.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '202110110250127_Init'
BEGIN
    CREATE TABLE [dbo].[Products] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [Price] [int] NOT NULL,
        [NumberOfProducts] [int] NOT NULL,
        [Country] [nvarchar](max),
        CONSTRAINT [PK_dbo.Products] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202110110250127_Init', N'Market.Migrations.Configuration',  0x1F8B0800000000000400CD57DB6EE336107D2FD07F10F8D40259339797369077913A4911741D07ABECBED3D2C821962255920AEC6FDB877E527FA143DD45D9B19D0D16450023A266CE9CB953FF7EFB27FCB0CE44F00CDA7025A7E46C724A0290B14AB85C4D4961D377BF910FEF7FFE29BC49B275F0A591BB7072A829CD943C599B5F526AE227C89899643CD6CAA8D44E62955196287A7E7AFA3B3D3BA3801004B18220FC5448CB33281FF071A6640CB92D9898AB0484A9CFF14D54A206F72C0393B318A664CEF457B0934A90045782332411814849C0A4549659A478F9D94064B592AB28C703261E3739A05CCA84819AFA65277EA817A7E7CE0BDA2936507161ACCA8E043CBBA8C3427DF5570597B461C3C0DD6080EDC6795D066F4A1EB44A8AD892C0B7753913DAC979A19DD40A2741757CD2661F8BC4FD9D04B342D842C3544261351327C143B1143CFE0B368FEA2BC8A92C84E893425AF86E7080476827076D379F20ADA9DE2524A0433DEA2BB66A3D9DCA8B3B692FCE49708FC6D952409BF39EC791551AFE04099A59481E98B5A0A5C380326A23EB9E2DF7DB58C322C3562118A4F547902BFBE4C2B826C12D5F43D29CD40C3E4B8E9D854A5617B0CFC883E631ECF3690FCF225B825EA47526CDF7A1CD1436ADDEBCB1E321ED2A755CBF38182CE398A79A43558AEE14D6DB4A19BBBEAE66531B1BBA54A14660874D8191E95854C364D2F6CB36B62DAF6E52D16A5435238DEE9869E19CE53906AE37E3EA9320AA06DCEC5D747CFB6715068DCD9629D0B26D2D61FDB315786F5D8A13B8E5DAD86B66D992B9D4CD926C2436CCC28E0837B6BC40FBDDDFC5BD5170FFF7B3EDCD231FA10BE02DFA94610797EE414BA41B7D23CD72C130C1F496613253A2C8E4AE81F49276351EFAFAD5C9E10875EFF721EAA323588C9A7FC068F4F670E47610F401DBC3314E48BD04F935404745E00D7FBFA85EEA485FA4B5DE76A6D78161DD0DFBAF1EA3F6A8444880017AE6896B8D68632C6413273089FE1633C1D1DF4E60CE244FC1D86A3F12BC029C7B5798FFCF75821A9388C3EE143F7CC77317D4BD5BFCD875D95BEBF299E9F889E95F32B6FEB58F74F4EA2EA9BED1E27E0D96B7B68F70ECB8D53CDE1D07ADDE97366FD55E53922C15D2AF686E1F5847ECE571B787B4FF39125E83E1AB0EC27D9C48885D1B75A08DCC9D4C55136F74ADCFA811F1D23107CB128CD095B63C65B1C5D73118535EA5BE3051A0C80D263FB9938BC2E685BD3206B2A5180CD690BE6CBFBC7C0C39878BDC3D99B770016972740116F28F828BA4E57D3B2EC75D10AE58EACE4556789544B8D5A645BA57F240A03A7CD79083747DFF08592E10CC2C64C49EE135DCF00EF911562CDE34437B37C8FE440CC31E5E73B6D22C333546A7EF3EB1A9FBC67EFF1F2474C9AE950F0000 , N'6.4.4')
END

IF @CurrentMigration < '202110111125004_ReInit'
BEGIN
    ALTER TABLE [dbo].[Products] ADD [NextArrivalDate] [nvarchar](max)
    DECLARE @var0 nvarchar(128)
    SELECT @var0 = name
    FROM sys.default_constraints
    WHERE parent_object_id = object_id(N'dbo.Products')
    AND col_name(parent_object_id, parent_column_id) = 'Price';
    IF @var0 IS NOT NULL
        EXECUTE('ALTER TABLE [dbo].[Products] DROP CONSTRAINT [' + @var0 + ']')
    ALTER TABLE [dbo].[Products] ALTER COLUMN [Price] [decimal](18, 2) NOT NULL
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202110111125004_ReInit', N'Market.Migrations.Configuration',  0x1F8B0800000000000400CD58DB8EDB36107D2FD07F10F8D4021B732F2FE9424EB0B5778B45E3B5116DF24E4B632F118A5449CAB0BF2D0FFDA4FE4287D69DF23537040B2C2C6AE6CC9921E770ECFF3EFF1BBE5DA7225881365CC921B91A5C920064AC122E974392DBC5ABD7E4ED9B5F7F09EF93741D7CACEC6E9C1D7A4A33242FD666B7949AF805526606298FB5326A6107B14A294B14BDBEBCFC835E5D51400882584110BECFA5E5296C1FF071A4640C99CD9998A8048429D7F14DB4450D9E580A2663310CC984E94F6007852109EE0467482202B120019352596691E2ED070391D54A2EA30C179878DE6480760B260C94D46F1BF353B3B8BC7659D0C6B1828A7363557A26E0D54D5916EABB7F5171495D362CDC3D16D86E5CD6DBE20DC94CAB248F2D09FC58B723A19D9D57DA41E9701114CB17F5EEE321717F17C1281736D73094905BCDC44530CBE782C77FC3E6597D023994B9106D52480BDF75167009E364A0EDE63D2C4AAA8F090968D78FFA8EB55BCBA7C8E251DA9B6B123C6170361750EF792BE3C82A0D7F8104CD2C2433662D68E930605BB55E742F96FB5F45C34386AD42B048EB772097F6C595714D8207BE86A45A29197C901C3B0B9DACCEE1589099E6711D650C314F9920C14CE3A7B2575F93208A99CB7057BA4752C8D339E8E9A2DC6473AC7887D1460AFB596FBE7B4D9E606DEFB4E62B26C6B873DF385E489BA6E9B7126A94651C8F4CC9A5E80AB78AA47674150A50D958A60CD64DAD408DC076FB1377A26151E8DAA06EDD5D6C6B5E8D68D242352B75A57BE4359CB02CC3C2B5E4B65C09A2426B47AFA2F395282D30686C760852CDB68E84ADC896E0BD75472A8107AE8DC58D6673E6B66E94A43DB3EE2EECA97015CB2BB42F444DDD2B07F7B9BDDB9E34FA084D011F30A714C5649B1ED4441A15EE796EEF3A2698DEA16B2325F254EED3C643DE8552B5FD8B95D3114A196A43944B67B0E8894D8751EFEDE9C8B5F0B401EBC53318FAC2D221E8BFECE386D4DB78FF6CD1DEE1F2EE37FFB01EEA74DFA48E5E77BCD7D961D965C7A7AB5EDB1526EEE2512B9EB8968B36C6423A700683E81F31121CF36D0C264CF205185B8C0004A79C6B6F4AFB7926266A4C224E1B9B7EF818C35D518F0E2AE75EFBADC945AE988E5F98FE2D65EBDFDB48674F27C98F9A4EB635F9BAD9E4ABB2DE337F9C8179DE8CD1BF044F9A210E8D10453FE39ECD15D22F68EE56DE33068CBEBC84B4FD152F1C83E1CB06C27DE19310BBBE6D402B9B47B95055DD31B536A3CAC4DB960958966085EEB4E50B165B7C1D8331DB99F02313399ADCE3814A1EE534B7596EEF8C81742E3A3744480FC7DF4E515DCEE134734FE65BA4803439A60053F967CE4552F37EE81FF17D10EEB0945281AC702646B8E5A6467A52F244A0B27C63C8403AA1798634130866A632622BF8126E380CBF83258B37D52DB11FE4F84674CB1E8E395B6A969A12A3F1773F5B50F7BBC59BFF01E10E8114E9100000 , N'6.4.4')
END

