from flask import Flask, render_template, request, redirect, url_for, flash
import sqlite3
from datetime import datetime

app = Flask(__name__)
app.secret_key = "secret"

DATABASE = "feedback.db"


def get_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn


def fetch_all(query, params=()):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    rows = cursor.fetchall()
    conn.close()
    return rows


def fetch_one(query, params=()):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    row = cursor.fetchone()
    conn.close()
    return row


@app.route("/")
def home():
    return redirect(url_for("dashboard"))


@app.route("/dashboard")
def dashboard():

    cards = {
        "feedback": 0,
        "customers": 0,
        "products": 0,
        "responses": 0,
        "negative": 0,
        "avg_score": 0
    }

    try:
        feedback = fetch_one("SELECT COUNT(*) as count FROM Feedback")
        customers = fetch_one("SELECT COUNT(*) as count FROM Customers")
        products = fetch_one("SELECT COUNT(*) as count FROM Products")
        responses = fetch_one("SELECT COUNT(*) as count FROM FeedbackResponses")

        cards["feedback"] = feedback["count"]
        cards["customers"] = customers["count"]
        cards["products"] = products["count"]
        cards["responses"] = responses["count"]

    except Exception as e:
        print(e)

    return render_template(
        "dashboard.html",
        cards=cards,
        sentiment_breakdown=[],
        category_breakdown=[],
        recent_feedback=[]
    )


@app.route("/feedback")
def feedback():
    feedback_items = fetch_all("""
        SELECT * FROM Feedback
    """)
    return render_template("feedback.html", feedback_items=feedback_items)


@app.route("/feedback/add", methods=["GET", "POST"])
def add_feedback():

    customers = fetch_all("SELECT * FROM Customers")
    products = fetch_all("SELECT * FROM Products")

    if request.method == "POST":

        customer_id = request.form["customer_id"]
        product_id = request.form["product_id"]
        feedback_text = request.form["feedback_text"]

        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("""
            INSERT INTO Feedback
            (CustomerID, ProductID, FeedbackText, FeedbackDate)
            VALUES (?, ?, ?, ?)
        """, (
            customer_id,
            product_id,
            feedback_text,
            datetime.now().strftime("%Y-%m-%d")
        ))

        conn.commit()
        conn.close()

        flash("Feedback Added!")

        return redirect(url_for("feedback"))

    return render_template(
        "add_feedback.html",
        customers=customers,
        products=products
    )


@app.route("/customers")
def customers():

    customer_items = fetch_all("""
        SELECT * FROM Customers
    """)

    return render_template(
        "customers.html",
        customer_items=customer_items
    )


@app.route("/products")
def products():

    product_items = fetch_all("""
        SELECT * FROM Products
    """)

    return render_template(
        "products.html",
        product_items=product_items
    )


@app.route("/responses")
def responses():

    response_items = fetch_all("""
        SELECT * FROM FeedbackResponses
    """)

    return render_template(
        "responses.html",
        response_items=response_items
    )


@app.route("/notifications")
def notifications():

    notification_items = fetch_all("""
        SELECT * FROM Notifications
    """)

    return render_template(
        "notifications.html",
        notification_items=notification_items
    )


@app.route("/analytics")
def analytics():

    return render_template(
        "analytics.html",
        monthly_data=[],
        sentiment_data=[]
    )


if __name__ == "__main__":
    app.run(debug=True) 