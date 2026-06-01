[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared DefaultDestination = Lakehouse.Contents([EnableFolding = false]){[workspaceId = "e5edf4c9-b8cd-441e-bd25-249f2416daf8"]}[Data]{[lakehouseId = "895b8482-b064-4262-b386-188e23c4b0ce"]}[Data];
[BindToDefaultDestination = true]
shared dim_sales_territory = let
  Source = Excel.Workbook(Web.Contents("https://mngenvmcap145525-my.sharepoint.com/personal/datadetective_mngenvmcap145525_onmicrosoft_com/Documents/Apps/Microsoft Power Query/Uploaded Files/AdventureWorks Sales 5.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "SalesTerritory", Kind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"SalesTerritoryKey", Int64.Type}, {"Region", type text}, {"Country", type text}, {"Group", type text}}),
  #"Filtered rows" = Table.SelectRows(#"Changed column type", each ([SalesTerritoryKey] <> 11))
in
  #"Filtered rows";
[BindToDefaultDestination = true]
shared fact_sales = let
  Source = Excel.Workbook(Web.Contents("https://mngenvmcap145525-my.sharepoint.com/personal/datadetective_mngenvmcap145525_onmicrosoft_com/Documents/Apps/Microsoft Power Query/Uploaded Files/AdventureWorks Sales 5.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Sales", Kind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"SalesOrderLineKey", Int64.Type}, {"ResellerKey", Int64.Type}, {"CustomerKey", Int64.Type}, {"ProductKey", Int64.Type}, {"OrderDateKey", Int64.Type}, {"DueDateKey", Int64.Type}, {"ShipDateKey", Int64.Type}, {"SalesTerritoryKey", Int64.Type}, {"Order Quantity", Int64.Type}, {"Unit Price", type number}, {"Extended Amount", type number}, {"Unit Price Discount Pct", Int64.Type}, {"Product Standard Cost", type number}, {"Total Product Cost", type number}, {"Sales Amount", type number}}),
  #"Filtered rows" = Table.SelectRows(#"Changed column type", each [CustomerKey] <> -1),
  #"Removed columns" = Table.RemoveColumns(#"Filtered rows", {"ResellerKey"}),
  #"Rounded off" = Table.TransformColumns(#"Removed columns", {{"Product Standard Cost", each Number.Round(_, 2), type number}}),
  #"Rounded off 1" = Table.TransformColumns(#"Rounded off", {{"Total Product Cost", each Number.Round(_, 2), type number}}),
  #"Rounded off 2" = Table.TransformColumns(#"Rounded off 1", {{"Sales Amount", each Number.Round(_, 2), type number}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Rounded off 2", {"Extended Amount"}),
  #"Rounded off 3" = Table.TransformColumns(#"Removed columns 1", {{"Unit Price", each Number.Round(_, 2), type number}})
in
  #"Rounded off 3";
[BindToDefaultDestination = true]
shared dim_date = let
  Source = Excel.Workbook(Web.Contents("https://mngenvmcap145525-my.sharepoint.com/personal/datadetective_mngenvmcap145525_onmicrosoft_com/Documents/Apps/Microsoft Power Query/Uploaded Files/AdventureWorks Sales 5.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Date", Kind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"DateKey", Int64.Type}, {"Date", type date}, {"Fiscal Year", type text}, {"Fiscal Quarter", type text}, {"Month", type date}, {"Full Date", type date}, {"MonthKey", Int64.Type}})
in
  #"Changed column type";
[BindToDefaultDestination = true]
shared dim_product = let
  Source = Excel.Workbook(Web.Contents("https://mngenvmcap145525-my.sharepoint.com/personal/datadetective_mngenvmcap145525_onmicrosoft_com/Documents/Apps/Microsoft Power Query/Uploaded Files/AdventureWorks Sales 5.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Product", Kind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"ProductKey", Int64.Type}, {"SKU", type text}, {"Product", type text}, {"Standard Cost", type number}, {"Color", type text}, {"List Price", type number}, {"Model", type text}, {"Subcategory", type text}, {"Category", type text}})
in
  #"Changed column type";
[BindToDefaultDestination = true]
shared dim_customer = let
  Source = Excel.Workbook(Web.Contents("https://mngenvmcap145525-my.sharepoint.com/personal/datadetective_mngenvmcap145525_onmicrosoft_com/Documents/Apps/Microsoft Power Query/Uploaded Files/AdventureWorks Sales 5.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Customer", Kind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"CustomerKey", Int64.Type}, {"Customer ID", type text}, {"Customer", type text}, {"City", type text}, {"State-Province", type text}, {"Country-Region", type text}, {"Postal Code", type text}})
in
  #"Changed column type";
