from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from models import User
from functools import wraps



bp = Blueprint('auth', __name__, url_prefix='/auth')



def init_login_manager(app):
    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.login_message = 'Для доступа к данной странице нужно пройти процедуру аутентификации.'
    login_manager.login_message_category = 'warning'
    login_manager.user_loader(Load_User)
    login_manager.init_app(app)



def Load_User(user_id):
    user = User.query.get(user_id)
    return user



@bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        login = request.form.get('login')
        password = request.form.get('password')
        remember_me = request.form.get('remember_me') == "on"
        if login and password:
            user = User.query.filter_by(login=login).first()
            if user and user.check_password(password):
                login_user(user, remember=remember_me)
                flash('Вы успешно аутентифицировались.', 'success')
                next = request.args.get('next')
                return redirect(next or url_for('index'))
        flash('Невозможно аутентифицироваться с указанным логином и паролем', 'danger')
    return render_template('auth/login.html')



@bp.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))

def check_rights(action):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            if not current_user.can(action, current_user.role_id):
                flash('У вас нету прав для доступа к данной странице', 'danger')
                return redirect(url_for('index'))
            return func(*args, **kwargs)
        return wrapper
    return decorator