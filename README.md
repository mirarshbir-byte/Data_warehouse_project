Data Warehouse Project (Medallion Architecture)
📌 Overview

This project implements a Data Warehouse using the Medallion Architecture (Bronze, Silver, Gold layers) to process and organize data from multiple business systems including ERP, CRM, and WMS. The goal is to provide clean, structured, and analytics-ready data for reporting and decision-making.

✅ Architecture

Bronze Layer (Staging)
Raw ingested data from sources such as ERP, CRM, and WMS.

Silver Layer (Integration)
Cleansed, standardized, and integrated data across multiple domains.

Gold Layer (Presentation)
Business-ready aggregated data, modeled for BI and reporting (e.g., star schema).

🛠 Tech Stack

ETL Tool: [Name your ETL tool, e.g., SQL scripts, Apache Airflow, or SSIS]

Database: [SQL Server / Snowflake / BigQuery / etc.]

Language: [SQL, Python (if used)]

Orchestration: [If using any scheduling tool]

Visualization: [Power BI / Tableau / Looker] (optional)

📂 Data Sources

ERP → Order, Inventory, Finance Data

CRM → Customer and Sales Data

WMS → Warehouse Operations Data

⚙ Pipeline Flow

Extract data from ERP, CRM, WMS.

Load into Bronze (staging).

Transform and cleanse in Silver.

Aggregate and model in Gold for analytics.

📊 Schema Design

Fact Tables: Sales, Inventory, Orders

Dimension Tables: Customer, Product, Date, Location


📜 License

This project is licensed under the MIT License. See LICENSE for details.
