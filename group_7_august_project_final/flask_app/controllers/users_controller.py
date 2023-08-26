from flask_app import app
from flask import render_template,redirect,request,session,flash
from flask_app.models.user_model import User
from flask_bcrypt import Bcrypt
bcrypt = Bcrypt(app)

@app.route('/login')
def index():
    return render_template('login.html')

@app.route('/newuser', methods=['POST'])
def signup():
    is_valid = User.new_user_validation(request.form)
    if not is_valid:
        return redirect('/login')
    pass_hash = bcrypt.generate_password_hash(request.form['password'])
    
    data={
        'username': request.form['username'],
        'email': request.form['email'],
        'password': pass_hash
    }
    user_id=User.create_user(data)
    session['user_id']=user_id
    flash('Login success!')
    return redirect('/')

@app.route('/login', methods = ['POST'])
def login():
    data = {'email': request.form['email']}
    user_info = User.get_one_by_email(data)
    
    if not user_info or not bcrypt.check_password_hash(user_info.password, request.form['password']):
        flash("Invalid Email/Password", 'login')
        return redirect('/login')
    
    session['username'] = user_info.username
    session['user_id'] = user_info.id
    return redirect('/')

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')