from flask import Flask, jsonify, render_template, redirect
import os
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

# Database configuration
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Model
class Article(db.Model):
    __tablename__ = 'articles'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), unique=True, nullable=False)
    slug = db.Column(db.String(255), unique=True, nullable=False)
    pub_date = db.Column(db.DateTime, default=db.func.now())
    time_to_read = db.Column(db.Integer)
    excerpt = db.Column(db.Text)
    html_file_path = db.Column(db.String(255))
    created_at = db.Column(db.DateTime, default=db.func.now())
    updated_at = db.Column(db.DateTime, default=db.func.now(), onupdate=db.func.now())

    def to_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'slug': self.slug,
            'pubtime': self.pub_date.strftime('%Y-%m-%d'),
            'timereq': self.time_to_read,
            'excerpt': self.excerpt
        }

# Routes
@app.route("/")
def index():
    blogs = Article.query.order_by(Article.pub_date.desc()).limit(3).all()
    return render_template('index.html', blogs=[blog.to_dict() for blog in blogs])

@app.route("/about", methods = ["GET", "POST"])
def about():
    return render_template("about.html")

@app.route("/projects", methods = ["GET", "POST"])
def projects():
    return render_template("index.html")

@app.route('/read')
def articles():
    blogs = Article.query.order_by(Article.pub_date.desc()).all()
    return render_template('articles.html', blogs=[blog.to_dict() for blog in blogs])

@app.route('/posts/<slug>')
def post(slug):
    return render_template(f"{slug}.html")

@app.route("/search", methods = ["GET", "POST"])
def searxng():
    return redirect("https://searx.rajimayur.me")

@app.route("/donate", methods = ["GET", "POST"])
def donate():
    return render_template("donate.html")

# Error Handlers
@app.errorhandler(403)
def accessdenied(e):
    return render_template("403.html")

@app.errorhandler(404)
def notfound(e):
    return render_template("404.html")

@app.errorhandler(500)
def notfound(e):
    return render_template("500.html")
