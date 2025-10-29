# 🛍️ Shopify GraphQL Automation with Python Robot Framework & Allure Reporting

This project automates key Shopify GraphQL API flows using Robot Framework, with professional-grade reporting powered by Allure. 

---

## 🚀 Features

- ✅ Automated testing of Shopify GraphQL endpoints
- ✅ Modular test design using Robot Framework
- ✅ Allure reporting integration with listener activation
- ✅ Clean folder structure for results and reports
- ✅ Git version control and GitHub publishing

---

## 🧰 Tech Stack

- **Robot Framework**
- **Allure Framework**
- **Python 3.13**
- **Git & GitHub**

---

## 🔐 Shopify Setup (Prerequisite)

To run this automation, you must first create a **custom private app** in your Shopify development store:

### ✅ Steps to Create the App

1. Log in to your [Shopify Partner Dashboard](https://partners.shopify.com/)
2. Navigate to your **development store**
3. Go to **Apps → Develop apps for your store**
4. Click **Create an app**
5. Name your app (e.g., `GraphQL Automation`)
6. Under **Configuration**, enable required Admin API scopes:
   - `read_orders`
   - `read_products`
   - `read_customers`
   - Any other scopes your tests require
7. Click **Install app**
8. Copy the **Admin API access token** — this is your bearer token for authentication

For more details on the Prerequisite, please refer the shopify dev documentation (https://shopify.dev/docs/api/admin-graphql)

### 🔐 Token Usage

Use this token in your test suite to authenticate GraphQL requests:

```robot
*** Variables ***
${access_token}   your-api-token-here
