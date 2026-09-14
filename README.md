# E-Commerce Customer Retention & Revenue Optimization

An end-to-end **e-commerce analytics project** using **Python, MySQL, and Power BI** to analyze revenue performance, customer retention, RFM segments, product performance, seller performance, and customer experience.

---

## Business Objective

Identify opportunities to improve **revenue and customer retention** by understanding customer purchasing behavior, repeat purchases, high-value customers, product performance, and customer experience.

---

## Key KPIs

| KPI                        |         Result |
| -------------------------- | -------------: |
| **Total Sales**            |   **R$13.59M** |
| **Total Orders**           |     **99,441** |
| **Total Customers**        |     **96,096** |
| **Average Order Value**    |   **R$136.68** |
| **Total Freight**          |    **R$2.25M** |
| **Total Sellers**          |      **3,095** |
| **Repeat Customers**       |      **2,997** |
| **Repeat Customer Rate**   |      **3.12%** |
| **Orders per Customer**    |       **1.03** |
| **Average Customer Spend** |   **R$141.44** |
| **Average Delivery Time**  | **11.98 days** |
| **Average Review Score**   |   **4.09 / 5** |

> **Note:** Sales represent the sum of item prices in the dataset. Freight is reported separately.

---

## Key Insights

* Generated approximately **R$13.59M** in recorded item-price sales across **99,441 orders**.
* Only **3.12% of customers** were repeat customers, highlighting a significant retention opportunity.
* **Health & Beauty** was the highest-selling product category with approximately **R$1.26M** in sales.
* **São Paulo (SP)** generated the highest state-level sales contribution.
* RFM analysis identified **37,269 Lost Customers**, **37,238 New Customers**, and **998 Champions**.
* The large **New and Lost customer segments** indicate opportunities for targeted engagement, retention, and reactivation campaigns.
* Average delivery time was approximately **12 days**, with an overall average review score of **4.09/5**.

---

# Power BI Dashboards

## Dashboard 1 — Executive Sales & Business Performance

Provides an executive overview of **sales, orders, customers, revenue trends, state performance, product categories, and order status**.

### Dashboard Preview

![Dashboard 1](Screenshots/Dashboard%201.png)

---

## Dashboard 2 — Customer Retention & RFM Analysis

Analyzes **customer purchasing behavior, repeat customers, customer value, RFM segmentation, and retention patterns**.

### Dashboard Preview

![Dashboard 2](Screenshots/Dashboard%202.png)

---

## Dashboard 3 — Product, Seller & Customer Experience

Analyzes **product categories, seller performance, delivery time, review scores, and order status** to evaluate business and customer-experience performance.

### Dashboard Preview

![Dashboard 3](Screenshots/Dashboard%203.png)

---

## Tools & Technologies

* **Python** — Data cleaning, preprocessing, validation, EDA, and data loading
* **Pandas & NumPy** — Data manipulation and preparation
* **MySQL / SQL** — Joins, aggregations, CTEs, window functions, customer analysis, cohort analysis, and RFM segmentation
* **Power BI** — Data modeling, interactive dashboards, and visualization
* **DAX** — Calculated measures and business KPIs
* **Power Query** — Data transformation and preparation

---

## Project Workflow

```text
Raw E-Commerce Data
        ↓
Python Data Cleaning & Validation
        ↓
Load Cleaned Data into MySQL
        ↓
SQL Analysis
        ↓
Customer & Revenue Analysis
        ↓
Cohort & RFM Analysis
        ↓
Power BI Data Model & DAX
        ↓
Interactive Dashboards
        ↓
Business Insights
```

---

## Repository Structure

```text
E-Commerce-Customer-Retention-Analytics/
│
├── Screenshots/
│   ├── Dashboard 1.png
│   ├── Dashboard 2.png
│   └── Dashboard 3.png
│
├── SQL/
│   └── ecommerce.sql
│
├── Notebook/
│   └── ecommerce.ipynb
│
└── README.md
```

---

## Project Files

| File                          | Description                                                             |
| ----------------------------- | ----------------------------------------------------------------------- |
| `Notebook/ecommerce.ipynb`    | Python data cleaning, EDA, preparation, and data loading                |
| `SQL/ecommerce.sql`           | SQL analysis, customer analytics, cohort analysis, and RFM segmentation |
| `Screenshots/Dashboard 1.png` | Executive Sales & Business Performance dashboard                        |
| `Screenshots/Dashboard 2.png` | Customer Retention & RFM dashboard                                      |
| `Screenshots/Dashboard 3.png` | Product, Seller & Customer Experience dashboard                         |

---

## Dataset

**Brazilian E-Commerce Public Dataset by Olist**

[Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
