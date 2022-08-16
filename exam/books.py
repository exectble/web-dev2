from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import current_user, login_required
from app import db
from models import Book, Book_genre, Genre, Cover, Review
from tools import ImageServer
import bleach
from auth import check_rights


bp = Blueprint('books', __name__, url_prefix='/books')


PARAM_OF_BOOK = ['name', 'short_description', 'year', 'publishing_house', 'author', 'pages']


PARAM_OF_REVIEW = ['rating', 'book_id', 'user_id', 'text']


def params():
    dict_param_of_book = {}
    for p in PARAM_OF_BOOK:
        if p == 'short_description': 
            dict_param_of_book[p] = bleach.clean(request.form.get(p))
        else:
            dict_param_of_book[p] = request.form.get(p)
    return dict_param_of_book


def params_review():
    dict_param_of_review = {}
    for p in PARAM_OF_REVIEW:
        if p == 'text':
            dict_param_of_review[p] = bleach.clean(request.form.get(p))
        else:
            dict_param_of_review[p] = request.form.get(p)
    return dict_param_of_review


@bp.route('/new')
@check_rights('create')
# >auth check_rights(action)
@login_required
def new():
    genres = Genre.query.all()
    return render_template('books/new.html', genres=genres)


@bp.route('/create', methods=['POST'])
@check_rights('create')
@login_required
def create():


    f = request.files.get('cover_img')
    if f and f.filename:
        img_saver = ImageServer(f)
        img = img_saver.save()

    
    book = Book(**params())

    if len(request.form.get('short_description')) == 0 :
        flash('Поле "Краткое описание" является обязательным. Ошибка сохранения, попробуйте снова', 'danger')
        return redirect(url_for('books.new'))
        

    if len(request.form.get('name')) == 0 :
        flash('Поле "Название" является обязательным. Ошибка сохранения, попробуйте снова', 'danger')
        return redirect(url_for('books.new'))

    if len(request.form.get('year')) == 0 :
        flash('Поле "Год издания" является обязательным. Ошибка сохранения, попробуйте снова', 'danger')
        return redirect(url_for('books.new'))

    if len(request.form.get('publishing_house')) == 0 :
        flash('Поле "Издательство" является обязательным. Ошибка сохранения, попробуйте снова', 'danger')
        return redirect(url_for('books.new'))

    if len(request.form.get('author')) == 0 :
        flash('Поле "Автор" является обязательным. Ошибка сохранения, попробуйте снова', 'danger')
        return redirect(url_for('books.new'))

    if len(request.form.get('pages')) == 0 :
        flash('Поле "Кол-во страниц" является обязательным. Ошибка сохранения, попробуйте снова', 'danger')
        return redirect(url_for('books.new'))


    try:
        db.session.add(book)
        db.session.commit()
    except: 
        flash('Введены некорректные данные. Проверьте правильность заполнения полей. Ошибка сохранения.', 'danger')
        return redirect(url_for('books.new'))

    genres = request.form.getlist('genres')

    for genre in genres:
        book_genre = Book_genre(book_id=book.id, genre_id=genre)
        db.session.add(book_genre)
        db.session.commit()

    if img:
        img_saver.bind_to_object(book)

    flash(f'Книга "{book.name}" добавлена', 'success')

    return redirect(url_for('index'))


@bp.route('/<int:book_id>/edit')
@check_rights('update')
@login_required
def edit(book_id):
    book = Book.query.get(book_id)
    genres = Genre.query.all()
    book_genres  = Book_genre.query.all()

    return render_template('books/edit.html', book=book, genres=genres, book_genres=book_genres)


@bp.route('/<int:book_id>/update', methods=['POST'])
@check_rights('update')
@login_required
def update(book_id):
    book = Book.query.get(book_id)

    try: 
        if len(request.form.get('name')) > 0 : 
            book.name = request.form.get('name')
        else: 
            1/0
        
        short_description = bleach.clean(request.form.get('short_description')) 
        if len(request.form.get('short_description')) > 0 : 
            book.short_description = short_description
        else: 
            1/0
        
        if len(request.form.get('year')) > 0 : 
            book.year = request.form.get('year')
        else: 
            1/0
        
        if len(request.form.get('publishing_house')) > 0 : 
            book.publishing_house = request.form.get('publishing_house')
        else: 
            1/0
        
        if len(request.form.get('author')) > 0 : 
            book.author = request.form.get('author')
        else: 
            1/0

        if len(request.form.get('pages')) > 0 : 
            book.pages = request.form.get('pages')
        else: 
            1/0   

        db.session.add(book)
        db.session.commit()
    except:
        flash('Заполните все поля. Ошибка сохранения', 'danger')
        return redirect(url_for('books.edit', book_id=book_id))

    genres = request.form.getlist('genres')

    
    old_genres = Book_genre.query.filter(Book_genre.book_id == book_id)

    for old_genre in old_genres:
        db.session.delete(old_genre)
        db.session.commit()

    for genre in genres:
        book_genre = Book_genre(book_id=book.id, genre_id=genre)
        db.session.add(book_genre)
        db.session.commit()

    flash(f'Книга "{book.name}" была успешно обновлена.', 'success')
    return redirect(url_for('index'))



@bp.route('/<int:book_id>/delete', methods=['POST'])
@check_rights('delete')
@login_required
def delete(book_id):
    cover = Cover.query.filter(Cover.book_id == book_id).first()
    cover_id = cover.id
    img_del = ImageServer(cover)
    img_del.delete_img(cover_id)

    Book.query.filter(Book.id == book_id).delete()
    db.session.commit()

    flash(f'Книга была удалена', 'success')
    return redirect(url_for('index'))


@bp.route('/<int:book_id>')
def show(book_id):
    book = Book.query.get(book_id)
    covers = Cover.query.all()
    reviews = Review.query.filter(Review.book_id == book_id)
    check_user = False
    if current_user.is_authenticated:
        for review in reviews:
            if review.user_id == current_user.id:
                check_user = True
    return render_template('books/show.html', book=book, covers=covers, reviews=reviews, check_user=check_user)



@bp.route('/review/<int:book_id>', methods=['POST'])
@login_required
def review(book_id):
    review = Review(**params_review())
    if len(request.form.get('text')) == 0 :
        flash('Вы не заполнили поле текста рецензии. Ошибка сохранения', 'danger')
        return redirect(url_for('books.review', book_id=book_id))
    try:
        book = Book.query.filter_by(id=book_id).first()
        book.rating_num += 1
        book.rating_sum += int(review.rating)
        db.session.add(review)
        db.session.commit()
    except:
        flash('Ошибка сохранения', 'danger')
        return redirect(url_for('books.review', book_id=book_id))

    flash('Ваша рецензия сохранена!', 'success')
    return redirect(url_for('books.show', book_id=book_id))



@bp.route('/<int:book_id>/review')
@login_required
def review_render(book_id):
    book = Book.query.get(book_id)
    return render_template('books/review.html', book=book)


