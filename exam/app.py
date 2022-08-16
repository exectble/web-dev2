import os
from flask import Flask, render_template, send_file, abort, send_from_directory, request
from sqlalchemy import MetaData
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate


app = Flask(__name__)
application = app


app.config.from_pyfile('config.py')


convention = {
    "ix": 'ix_%(column_0_label)s',
    "uq": "uq_%(table_name)s_%(column_0_name)s",
    "ck": "ck_%(table_name)s_%(constraint_name)s",
    "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
    "pk": "pk_%(table_name)s"
}



metadata = MetaData(naming_convention=convention)
db = SQLAlchemy(app, metadata=metadata)
migrate = Migrate(app, db)



from auth import bp as auth_bp, init_login_manager
from books import bp as books_bp
app.register_blueprint(auth_bp)
app.register_blueprint(books_bp)


init_login_manager(app)


from models import Book, Book_genre, Cover, Role


PER_PAGE = 6


@app.route('/')
def index():
    books = Book.query.order_by(Book.year.desc())
    book_genres = Book_genre.query.all()
    covers = Cover.query.all()
    page = request.args.get('page', 1, type=int)
    pagination = books.paginate(page, PER_PAGE)
    books = pagination.items
    return render_template('index.html', books = books, book_genres=book_genres, covers=covers, pagination=pagination)



@app.route('/media/images/<cover_id>')
def image(cover_id):
    image = Cover.query.get(cover_id)
    if image is None:
        abort(404)
    return send_from_directory(app.config['UPLOAD_FOLDER'], image.storage_filename)
