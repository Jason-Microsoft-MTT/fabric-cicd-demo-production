# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse_name": "",
# META       "default_lakehouse_workspace_id": "",
# META       "known_lakehouses": []
# META     }
# META   }
# META }

# MARKDOWN ********************

# ## Development Notebook

# CELL ********************

from notebookutils import variableLibrary

vl = variableLibrary.getLibrary("env_config")

print("Environment:", vl.environment_name)
print("Data Source:", vl.data_source_name)
print("Load Mode:", vl.load_mode)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
