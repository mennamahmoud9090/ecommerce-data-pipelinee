# 🛒 E-Commerce End-to-End Batch Data Pipeline

An enterprise-grade, scalable batch ETL pipeline designed to simulate, ingest, transform, and analyze e-commerce transactional data using modern Big Data tools and architectures.

---

## 📐 Pipeline Architecture

Below is the end-to-end data processing workflow from source ingestion to analytics warehousing:

![Architecture Diagram](Architecture%20Diagram.jpg)

### 🔄 Data Flow Summary:
1. **Source Layer:** Python script generates synthetic e-commerce data and stores it in MariaDB.
2. **Ingestion & Orchestration:** Apache NiFi extracts table records incrementally and ingests them into HDFS.
3. **Landing Layer (HDFS):** Raw data is preserved in staging using **Apache Avro** binary format.
4. **Transformation Layer:** PySpark cleans duplicates, casts data types, handles null values, and executes analytical joins.
5. **Data Warehouse:** Transformed datasets are saved as **External Hive Tables** (Star Schema design).

---

## 🛠️ Tech Stack & Infrastructure

| Layer | Tool / Technology |
| :--- | :--- |
| **Data Generation** | Python, Pandas |
| **Relational Database** | MariaDB |
| **Ingestion & Orchestration** | Apache NiFi |
| **Data Landing / Lake** | HDFS (Hadoop Distributed File System) |
| **Processing Engine** | Apache Spark (PySpark), YARN |
| **Data Warehouse & Querying** | Apache Hive, Hue |

---

## 📊 Data Warehouse Schema (Hive)

The analytical data layer in Hive follows a **Star-Schema** model:

* **`fact_sales`**: Operational sales records containing line-item orders, quantities, unit prices, and status.
* **`daily_sales`**: Aggregated metrics tracking daily order count, total revenue, and average order value.
* **`customer_sales`**: Customer demographics and lifetime spending analytics.
* **`product_sales`**: Product performance breakdown by category and total quantities sold.

---

## 📁 Repository Structure

```text
.
├── Architecture Diagram.jpg    # Pipeline Architecture Visual
├── README.md                   # Project Documentation
├── data-generator/            # Python scripts for synthetic data creation & chunking
├── docs/                       # Project task definitions & documentation
├── hive/                       # SQL DDL & analytical warehouse queries

🚀 Getting Started & Execution Flow
1. Database Setup & Data Generation
Execute the Python script to create schema tables and populate MariaDB:

Bash
python data-generator/data_generator.py
2. Ingestion via Apache NiFi
Import the NiFi flow template located in nifi/.

Enable the JDBC Connection Controller and start processors (ListDatabaseTables ➔ GenerateTableFetch ➔ ExecuteSQLRecord ➔ PutHDFS).

3. Transformation via PySpark
Submit the PySpark job to read raw Avro files from HDFS staging and perform business logic:

Bash
spark-submit --master yarn pyspark/transformations.py
4. Load & Query Data in Hive
Run DDL scripts in hive/ to instantiate External Hive tables over processed HDFS directories:

SQL
SOURCE hive/schema_ddl.sql;
SOURCE hive/analytics_queries.sql;
├── nifi/                       # Apache NiFi flow templates (.xml)
└── pyspark/                    # PySpark cleaning & transformation scripts
