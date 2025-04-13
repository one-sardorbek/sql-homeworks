import pyodbc

con_str = "DRIVER={SQL SERVER};SERVER=sardor\SQLEXPRESS;DATABASE=mySql;Trusted_Connection=yes;"
con = pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute(
    """
    SELECT * FROM products;
    """
)

row = cursor.fetchone()
img_id, image_data = row

with open('image.jpg', 'wb') as f:
    f.write(image_data)