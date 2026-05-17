# Customer Feedback Management System - Flask UI

This project is a professional Flask + MySQL admin dashboard for your **Customer Feedback Management System for Sentiment Analysis**.

## Features
- Clean sidebar based admin layout
- Dashboard cards for quick stats
- Sentiment and category charts
- Feedback listing page
- Add feedback form
- Customers page
- Products page
- Notifications page
- Admin responses page
- Analytics page with charts
- MySQL connection using `mysql-connector-python`

## Project Structure
```bash
customer_feedback_flask_app/
│── app.py
│── requirements.txt
│── schema.sql
│── README.md
│── templates/
│   ├── base.html
│   ├── dashboard.html
│   ├── feedback.html
│   ├── add_feedback.html
│   ├── customers.html
│   ├── products.html
│   ├── responses.html
│   ├── notifications.html
│   └── analytics.html
│── static/
│   └── css/
│       └── style.css
```

## How to Run

### 1. Install packages
```bash
pip3 install -r requirements.txt
```

### 2. Create database and tables
Open MySQL Workbench and run:
```sql
SOURCE path_to_your_folder/schema.sql;
```
Or copy paste the contents of `schema.sql` into MySQL Workbench and run it.

### 3. Update MySQL password
Open `app.py` and edit this part:
```python
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "your_mysql_password",
    "database": "customer_feedback_db",
}
```

### 4. Run Flask app
```bash
python3 app.py
```

### 5. Open in browser
```bash
http://127.0.0.1:5000
```

## Notes
- Your current table design uses manual IDs, so the add form asks for `FeedbackID`.
- If you want, you can later convert IDs to `AUTO_INCREMENT`.
- This version is designed to look clean and professional for project submission and demo.
