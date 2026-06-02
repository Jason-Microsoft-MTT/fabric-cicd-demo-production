# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "895b8482-b064-4262-b386-188e23c4b0ce",
# META       "default_lakehouse_name": "RetailSalesLH",
# META       "default_lakehouse_workspace_id": "e5edf4c9-b8cd-441e-bd25-249f2416daf8",
# META       "known_lakehouses": [
# META         {
# META           "id": "895b8482-b064-4262-b386-188e23c4b0ce"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# Load source tables from the lakehouse production
fact_sales = spark.read.table("fact_sales")
dim_date = spark.read.table("dim_date")
dim_product = spark.read.table("dim_product")
dim_customer = spark.read.table("dim_customer")
dim_sales_territory = spark.read.table("dim_sales_territory")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.functions import col

df = (
    fact_sales.alias("f")
    .join(dim_date.alias("d"), col("f.OrderDateKey") == col("d.DateKey"), "left")
    .join(dim_product.alias("p"), col("f.ProductKey") == col("p.ProductKey"), "left")
    .join(dim_sales_territory.alias("t"), col("f.SalesTerritoryKey") == col("t.SalesTerritoryKey"), "left")
)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.functions import sum, count

gold_sales_summary = (
    df.groupBy(
        col("d.Fiscal Year").alias("year"),
        col("d.Month").alias("month"),
        col("p.Product").alias("product"),
        col("t.Country").alias("country")
    )
    .agg(
        sum("f.Sales Amount").alias("total_sales"),
        count("f.SalesOrderLineKey").alias("order_count")
    )
)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

display(gold_sales_summary)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

gold_sales_summary.write.mode("overwrite").saveAsTable("sales_summary")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
