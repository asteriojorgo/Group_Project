from flask_app import connectToMySQL
from flask import session

class Comment:
    DB = 'reddit_database'
    
    def __init__(self, id, post_id, form_data):
        self.id = id
        self.post_id = post_id
        self.body = form_data['body']
        self.user_id = form_data['user_id']
        
    @classmethod
    def create_new_comment(cls, form_data, post_id):
        new_form_data = {
            'user_id': session['user_id'],
            'content': form_data['comment'],
            'post_id': post_id
        }
        query = """
            INSERT INTO comments (comment_body, users_id, posts_id)
            VALUES (%(content)s, %(user_id)s, %(post_id)s)
        """
        connectToMySQL(cls.DB).query_db(query, new_form_data)

    @classmethod
    def get_comments_by_post_id(cls, post_id):
        query = """
            SELECT c.*, u.username
            FROM comments c
            JOIN users u ON c.users_id = u.id
            WHERE c.posts_id = %(post_id)s;
        """

        data = {'post_id': post_id}
        results = connectToMySQL(cls.DB).query_db(query, data)
        
        comments = [cls(result['id'], result['posts_id'], {
            'body': result['comment_body'],
            'user_id': result['users_id']
        }) for result in results]
        
        return comments
    
    
    @classmethod
    def delete_comments_by_post_id(cls, post_id):
        query = "DELETE FROM comments WHERE posts_id = %(post_id)s;"
        data = {'post_id': post_id}
        connectToMySQL(cls.DB).query_db(query, data)
