from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Настройка подключения к базе данных (используем SQLite для простоты)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///info_site.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Модели для статей, категорий и тегов
class Article(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    content = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, default=db.func.now())
    category_id = db.Column(db.Integer, db.ForeignKey('category.id'))
    category = db.relationship('Category', backref='articles')
    tags = db.relationship('Tag', secondary='article_tag', backref='articles')

class Category(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)

class Tag(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)

# Создание таблицы для связи "многие ко многим" между статьями и тегами
article_tag = db.Table(
    'article_tag',
    db.Column('article_id', db.Integer, db.ForeignKey('article.id')),
    db.Column('tag_id', db.Integer, db.ForeignKey('tag.id'))
)

# Создание таблиц в базе данных
with app.app_context():
    db.create_all()

# Маршруты для отображения статей
@app.route('/')
def index():
    articles = Article.query.order_by(Article.created_at.desc()).all()
    return render_template('index.html', articles=articles)

@app.route('/article/<int:article_id>')
def article_details(article_id):
    article = Article.query.get_or_404(article_id)
    return render_template('article.html', article=article)

# Запуск приложения
if __name__ == '__main__':
    app.run(debug=True)