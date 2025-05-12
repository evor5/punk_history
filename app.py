from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import (
    LoginManager,
    UserMixin,
    login_user,
    login_required,
    logout_user,
    current_user
)
from werkzeug.security import generate_password_hash, check_password_hash
from flask_migrate import Migrate
from sqlalchemy.exc import IntegrityError
from faker import Faker
import os
from werkzeug.utils import secure_filename

# Инициализация приложения
app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key-here'  # Важно заменить на сложный ключ!
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:2046@localhost/prime_punk'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


# В начало файла
UPLOAD_FOLDER = 'static/uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Инициализация расширений
db = SQLAlchemy(app)
migrate = Migrate(app, db)

login_manager = LoginManager(app)
login_manager.login_view = 'login'

fake = Faker()

# Модели
class User(db.Model, UserMixin):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(256), unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=True)
    articles_count = db.Column(db.Integer, nullable=False, default=0)
    age = db.Column(db.Integer, nullable=False, default=0)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

class Article(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    content = db.Column(db.Text, nullable=False)
    media_filename = db.Column(db.String(255), nullable=True)
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

article_tag = db.Table(
    'article_tag',
    db.Column('article_id', db.Integer, db.ForeignKey('article.id')),
    db.Column('tag_id', db.Integer, db.ForeignKey('tag.id'))
)

# Загрузчик пользователя
@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@app.route('/register', methods=['GET', 'POST'])
def register():
    form_errors = {}
    form_data = {}
    
    if request.method == 'POST':
        form_data = {
            'username': request.form.get('username', '').strip(),
            'email': request.form.get('email', '').strip().lower(),
            'password': request.form.get('password', '')
        }

        # Валидация имени пользователя
        if not form_data['username']:
            form_errors['username'] = 'Введите имя пользователя'
        else:
            if len(form_data['username']) < 4:
                form_errors['username'] = 'Имя слишком короткое (минимум 4 символа)'
            elif len(form_data['username']) > 80:
                form_errors['username'] = 'Имя слишком длинное (максимум 80 символов)'
            elif not form_data['username'].isalnum():
                form_errors['username'] = 'Только буквы и цифры (без пробелов и спецсимволов)'

        # Валидация email
        if not form_data['email']:
            form_errors['email'] = 'Введите email'
        else:
            if '@' not in form_data['email']:
                form_errors['email'] = 'Email должен содержать @'
            elif '.' not in form_data['email'].split('@')[-1]:
                form_errors['email'] = 'Email должен содержать домен (например: example.com)'
            elif len(form_data['email']) > 256:
                form_errors['email'] = 'Email слишком длинный'

        # Валидация пароля
        if not form_data['password']:
            form_errors['password'] = 'Введите пароль'
        else:
            if len(form_data['password']) < 8:
                missing = 8 - len(form_data['password'])
                form_errors['password'] = f'Добавьте еще {missing} символов'
            elif len(form_data['password']) > 50:
                form_errors['password'] = 'Пароль слишком длинный (максимум 50 символов)'
            elif not any(c.isupper() for c in form_data['password']):
                form_errors['password'] = 'Добавьте хотя бы одну заглавную букву'
            elif not any(c.isdigit() for c in form_data['password']):
                form_errors['password'] = 'Добавьте хотя бы одну цифру'

        # Проверка уникальности
        if not form_errors:
            existing_user = User.query.filter(
                (User.username == form_data['username']) | 
                (User.email == form_data['email'])
            ).first()

            if existing_user:
                if existing_user.username == form_data['username']:
                    form_errors['username'] = 'Это имя уже занято'
                if existing_user.email == form_data['email']:
                    form_errors['email'] = 'Этот email уже используется'

        # Регистрация если нет ошибок
        if not form_errors:
            try:
                new_user = User(
                    username=form_data['username'],
                    email=form_data['email'],
                    articles_count=0,
                    age=0
                )
                new_user.set_password(form_data['password'])

                db.session.add(new_user)
                db.session.commit()
                flash('Регистрация успешно завершена! Теперь вы можете войти.', 'success')
                return redirect(url_for('login'))
            except Exception as e:
                db.session.rollback()
                form_errors['general'] = 'Произошла ошибка при регистрации. Пожалуйста, попробуйте позже.'
                app.logger.error(f'Registration error: {str(e)}')

    return render_template('register.html', 
                         form_errors=form_errors,
                         form_data=form_data)

@app.route('/articles', methods=['GET', 'POST'])
@login_required
def articles_page():
    if request.method == 'POST':
        title = request.form.get('title')
        content = request.form.get('content')
        media_file = request.files.get('media')

        filename = None
        if media_file and media_file.filename:
            filename = secure_filename(media_file.filename)
            media_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            media_file.save(media_path)

        article = Article(
            title=title,
            content=content,
            media_filename=filename
        )
        db.session.add(article)
        db.session.commit()
        flash('Статья успешно опубликована!', 'success')
        return redirect(url_for('articles_page'))

    articles = Article.query.order_by(Article.created_at.desc()).all()
    return render_template('articles.html', articles=articles)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        user = User.query.filter_by(username=username).first()
        if user is None or not user.check_password(password):
            flash('Неверное имя пользователя или пароль!', 'danger')
            return redirect(url_for('login'))

        login_user(user)
        return redirect(url_for('index'))

    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))

# Тестовые данные
@app.route('/add_test_user')
def add_test_user():
    try:
        username = fake.unique.user_name()
        email = fake.unique.email()
        user = User(username=username, email=email)
        user.set_password('test123')
        db.session.add(user)
        db.session.commit()
        return f"Тестовый пользователь {username} добавлен!"
    except IntegrityError:
        db.session.rollback()
        return "Ошибка при добавлении тестового пользователя"

# Основные маршруты
@app.route('/')
def index():
    articles = Article.query.order_by(Article.created_at.desc()).all()
    return render_template('index.html', articles=articles)

@app.route('/profile')
@login_required
def profile():
    return render_template('profile.html', user=current_user)

@app.route('/article/<int:article_id>')
def article_details(article_id):
    article = Article.query.get_or_404(article_id)
    return render_template('article.html', article=article)

# Инициализация БД
@app.cli.command('init-db')
def init_db():
    with app.app_context():
        db.drop_all()
        db.create_all()
    print("База данных инициализирована")

if __name__ == '__main__':
    with app.app_context():
        # Автоматическое применение миграций при запуске
        from flask_migrate import upgrade
        upgrade()
    app.run(debug=True)