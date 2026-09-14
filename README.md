# E-Commerce Customer Retention & Revenue Optimization

An end-to-end e-commerce analytics project using **SQL, Python, and Power BI** to analyze sales performance, customer retention, RFM segments, product performance, seller performance, and customer experience.

## Business Question

**How can an e-commerce business increase revenue and customer retention by identifying high-value customers, understanding repeat-purchase behavior, and finding the products, sellers, and service factors that influence customer experience?**

---

## Key KPIs

| KPI | Value |
|---|---:|
| Total Sales | **$13.59M** |
| Total Orders | **99,441** |
| Total Customers | **96,096** |
| Average Order Value | **$136.68** |
| Total Freight | **$2.25M** |
| Total Sellers | **3,095** |
| Repeat Customers | **2,997** |
| Repeat Customer Rate | **3.12%** |
| Average Customer Spend | **$141.44** |
| Average Delivery Time | **11.98 days** |
| Average Review Score | **4.09 / 5** |

> Revenue is defined as the sum of item prices in the dataset. Freight is reported separately.

---

## Dashboard 1 — Executive Sales & Business Performance

Provides a high-level view of overall business performance, sales trends, geographic performance, product categories, and order status.

![Dashboard 1](Screenshots/Dashboard%201.png)

### Key Insights

- Recorded item-price sales totaled **$13.59M** across **99,441 orders**.
- **São Paulo (SP)** generated the highest sales contribution, followed by Rio de Janeiro (RJ) and Minas Gerais (MG).
- **Health & Beauty** was the highest-revenue product category.
- **96,478 orders** were delivered, representing the majority of recorded orders.
- The customer base was heavily concentrated in one-time purchasers, highlighting a significant retention opportunity.

---

## Dashboard 2 — Customer Retention & RFM

Analyzes customer purchasing behavior using repeat-purchase analysis, cohort analysis, and **RFM (Recency, Frequency, Monetary)** segmentation.

![Dashboard 2](Screenshots/Dashboard%202.png)

### Key Insights

- **96,096 unique customers** were identified.
- Only **2,997 customers** were repeat purchasers, resulting in a **3.12% repeat customer rate**.
- **New Customers** and **Lost Customers** represented the largest RFM segments.
- **Champions** represented a smaller but high-value segment with the highest average customer spend.
- The results indicate a strong opportunity to improve **second-purchase conversion, customer retention, and reactivation of at-risk customers**.

### RFM Segments

- Champions
- Loyal Customers
- New Customers
- Potential Loyalists
- At Risk
- Lost Customers

---

## Dashboard 3 — Product, Seller & Customer Experience

Examines product categories, seller performance, delivery time, review scores, freight, and order status.

![Dashboard 3](Screenshots/Dashboard%203.png)

### Key Insights

- **Health & Beauty** generated the highest category-level sales.
- Seller sales were concentrated in **São Paulo**, followed by Paraná and Minas Gerais.
- Average delivery time was approximately **11.98 days**.
- The overall average review score was **4.09 / 5**.
- Delivery performance and review scores can be further investigated to identify potential customer-experience improvement areas.

---

## Analytical Approach

### SQL
- Data auditing and validation
- Aggregations and joins
- CTEs
- Window functions
- Customer-level analysis
- Cohort retention
- RFM segmentation
- Product and seller analysis
- Delivery and review analysis

### Python
- Data cleaning
- Exploratory Data Analysis
- Customer and order analysis
- Trend and segment analysis
- Data validation

### Power BI
- Data modeling
- Power Query transformations
- DAX measures
- KPI reporting
- Interactive dashboards
- Customer segmentation
- Business-focused visualization

---

## Key Business Recommendations

1. **Increase second-purchase conversion** through targeted post-purchase campaigns.
2. **Reactivate At-Risk and Lost Customers** using personalized offers and relevant product recommendations.
3. **Nurture Champions and Potential Loyalists** with loyalty-focused strategies.
4. **Monitor high-performing categories and sellers** to identify opportunities for revenue expansion.
5. **Investigate delivery performance** where longer delivery times are associated with weaker customer reviews.
  

---

## Project Structure

```text
Ecommerce-Customer-Retention-Revenue-Optimization/
│
├── README.md
│
├── Screenshots/
│   ├── Dashboard 1.png
│   ├── Dashboard 2.png
│   └── Dashboard 3.png
│
├── SQL/
│   └── ecommerce.sql
│
└── Notebook/
    └── ecommerce.ipynb
