from flask import Flask, request, jsonify, abort
from flask_sqlalchemy import SQLAlchemy
import secrets
import random
from datetime import datetime, timedelta


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///test.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# User credentials (for illustration purposes)
users = {'admin@x.com': 'password'}

# Token storage
token_storage = {}

# Token expiration duration (7 days)
TOKEN_EXPIRATION_DURATION = timedelta(days=7)

# Define the Order model
class Order(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    items = db.relationship('OrderItem', backref='order', lazy=True)

class OrderItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    sku = db.Column(db.String(50))
    ean = db.Column(db.Integer)
    quantity = db.Column(db.Integer)
    box = db.Column(db.String(50))
    order_id = db.Column(db.Integer, db.ForeignKey('order.id'), nullable=False)  # Added foreign key relationship

# Routes
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")

    # Check if username and password are provided
    if not username or not password:
        abort(400, "Username and password are required.")

    # Validate user credentials
    if users.get(username) == password:
        # Generate a random token
        token = secrets.token_urlsafe(32)

        # Store token with expiration time
        expiration_time = datetime.now() + TOKEN_EXPIRATION_DURATION
        token_storage[token] = {'username': username, 'expiration_time': expiration_time}

        return jsonify({"token": token, "message": "Login successful"})
    else:
        abort(401, "Invalid username or password.")


@app.route('/orders', methods=['GET'])
def get_orders():
    token = validate_token(request)

    # Perform actual token validation (for simplicity, assuming valid token)
    # In a real-world application, you would use a proper authentication mechanism

    orders = Order.query.all()
    return jsonify({"results": [{"id": order.id, "name": order.name} for order in orders]})

@app.route('/orders/<order_id>', methods=['GET'])
def get_order_details(order_id):
    token = validate_token(request)

    # Perform actual token and order_id validation (for simplicity, assuming valid token and order_id)
    # In a real-world application, you would use a proper authentication and authorization mechanism

    order = Order.query.get(order_id)
    if not order:
        abort(404, f"Order with ID {order_id} not found.")

    items = order.items
    result = [{"id": item.id, "sku": item.sku, "quantity": item.quantity, "box": item.box, "ean": item.ean} for item in items]
    return jsonify({"results": result})

@app.route('/orders/<order_id>/items/<item_id>', methods=['POST'])
def handle_order_item(order_id, item_id):
    token = validate_token(request)

    data = request.get_json()
    if not data or "quantity" not in data:
        abort(400, "Invalid request. 'quantity' field is required.")

    # Create new OrderItem
    new_item = OrderItem(sku="example_sku", quantity=data["quantity"], 
                        box="example_box", 
                        ean=123456, 
                        order_id=int(order_id))
    db.session.execute
    db.session.add(new_item)
    db.session.commit()
    return jsonify({"id": new_item.id, "sku": new_item.sku, "quantity": new_item.quantity, "box": new_item.box, "ean": new_item.ean})

@app.route('/orders/<order_id>/items/<sku>', methods=['GET'])
def get_order_item(order_id, sku):
    token = validate_token(request)

    # Perform actual token, order_id, and sku validation (for simplicity, assuming valid token, order_id, and sku)
    # In a real-world application, you would use a proper authentication and authorization mechanism

    # Fetch item details
    item = OrderItem.query.filter_by(order_id=order_id, sku=sku).first()
    if not item:
        abort(404, f"Item with SKU {sku} not found in order with ID {order_id}.")

    result = {"id": item.id, "sku": item.sku, "quantity": item.quantity, "box": item.box, "ean": item.ean}
    return jsonify(result)

@app.route('/create_order', methods=['POST'])
def create_order():
    token = validate_token(request)

    # Perform actual token validation (for simplicity, assuming valid token)
    # In a real-world application, you would use a proper authentication mechanism

    # Extract data from the request
    data = request.get_json()
    if not data or "items" not in data:
        abort(400, "Invalid request. 'items' field is required.")

    order_name = "Order " + generate_random_string() 
    # Create a new order
    new_order = Order(id=generate_random_number(), name=order_name)
    db.session.add(new_order)
    db.session.commit()
    
    # Create items for the order
    for item_data in data["items"]:
        new_item = OrderItem(
            id=generate_random_number(),
            sku=item_data.get("sku", "example_sku"),
            ean=item_data.get("ean", 123456),
            quantity=item_data.get("quantity", 1),
            box=item_data.get("box", "example_box"),
            order_id=new_order.id
        )
        print(order_name)
        db.session.add(new_item)

    db.session.commit()
    return jsonify({"message": f'Orders created successfully.'})

def validate_token(request):
    token = request.headers.get('Authorization').split(' ')[1]

    # Check if the token is valid and not expired
    user_info = token_storage.get(token)
    if not user_info or user_info['expiration_time'] < datetime.now():
        abort(401, "Invalid or expired token.")

    return token

def generate_random_string(length=10):
    return secrets.token_urlsafe(length)

def generate_random_number(length=10000000):
    return random.randint(0,length)

if __name__ == '__main__':
    with app.app_context():
        # Initialize the database
        db.create_all()

    app.run(debug=True)
