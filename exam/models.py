from flask import url_for
from app import db
import sqlalchemy as sa
from flask_login import UserMixin
from werkzeug.security import check_password_hash, generate_password_hash
import os
from user_policy import UsersPolicy



class User(db.Model, UserMixin):
    __tablename__ = 'users'


    id = db.Column(db.Integer, primary_key=True)
    login = db.Column(db.String(100), unique=True, nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    first_name = db.Column(db.String(100), nullable=False)
    middle_name = db.Column(db.String(100), nullable=True) 
    role_id = db.Column(db.Integer, db.ForeignKey('roles.id'))
    
    role = db.relationship('Role')

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
    
    @property
    def full_name(self):
        return ' '.join([self.last_name, self.first_name, self.middle_name or ''])

    def can(self, action, role_id):
        users_policy = UsersPolicy(role_id)
        method = getattr(users_policy, action, role_id)
        if method is not None:
            return method()
        return False

    def __repr__(self):
        return '<User %r>' % self.login



class Role(db.Model):
    __tablename__ = 'roles'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text())

    def __repr__(self):
        return '<Role %r>' % self.name



class Book(db.Model):
    __tablename__ = 'books'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    short_description = db.Column(db.Text(), nullable=False)
    year = db.Column(db.Integer, nullable=False)
    publishing_house = db.Column(db.String(100), nullable=False)
    author = db.Column(db.String(100), nullable=False)
    pages = db.Column(db.Integer, nullable=False)
    rating_sum = db.Column(db.Integer, nullable=False, default=0)
    rating_num = db.Column(db.Integer, nullable=False, default=0)
    created_at = db.Column(db.DateTime, nullable=False, server_default=sa.sql.func.now())

    def __repr__(self): 
        return '<Book %r>' % self.name
        
    @property
    def rating(self):
        if self.rating_num > 0:
            return self.rating_sum / self.rating_num
        return 0


class Review(db.Model):
    __tablename__ = 'reviews'

    id = db.Column(db.Integer, primary_key=True)
    book_id = db.Column(db.Integer, db.ForeignKey('books.id'))
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    rating = db.Column(db.Integer, nullable=False)
    text = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, nullable=False, server_default=sa.sql.func.now())

    book = db.relationship('Book')
    user = db.relationship('User')

    def __repr__(self):
        return '<Review %r>' % self.text



class Genre(db.Model):
    __tablename__ = 'genres'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False, unique=True)

    def __repr__(self): 
        return '<Genre %r>' % self.name



class Book_genre(db.Model):
    __tablename__ = 'book_genres'

    id = db.Column(db.Integer, primary_key=True)
    book_id = db.Column(db.Integer, db.ForeignKey('books.id'), primary_key=True)
    genre_id = db.Column(db.Integer, db.ForeignKey('genres.id'), primary_key=True)

    book = db.relationship('Book', backref='book_genre')
    genre = db.relationship('Genre')

    def __repr__(self): 
        return '<Book_genre %r>' % self.id



class Cover(db.Model):
    __tablename__ = 'covers'

    id = db.Column(db.String(100), primary_key=True)
    file_name = db.Column(db.String(100), nullable=False)
    mime_type = db.Column(db.String(100), nullable=False)
    md5_hash = db.Column(db.String(100), nullable=False, unique=True)
    book_id = db.Column(db.Integer, db.ForeignKey('books.id'))
    object_id = db.Column(db.Integer)
    object_type = db.Column(db.String(100))

    book = db.relationship('Book')

    def __repr__(self): 
            return '<Cover %r>' % self.file_name
    
    @property
    def storage_filename(self):
        _, ext = os.path.splitext(self.file_name)
        return self.id + ext

    @property
    def url(self):
        return url_for('image', cover_id=self.id)

