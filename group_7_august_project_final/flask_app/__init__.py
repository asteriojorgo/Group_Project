from flask import Flask
from flask_app.config.mysqlconnection import connectToMySQL

app = Flask(__name__)
app.secret_key = "XXXXX"