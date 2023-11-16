import mysql.connector
from mysql.connector import Error
from tabulate import tabulate

try:
    connection = mysql.connector.connect(host="localhost", database="assign_8connect", user="root", password="root")
    
    if connection.is_connected():
        db_info = connection.get_server_info()
        print("Connected to MySQL server version", db_info)

    def insert(id, name, age, city):
        res = connection.cursor()
        sql = "INSERT INTO user VALUES (%s, %s, %s, %s);"
        values = (id, name, age, city)
        res.execute(sql, values)
        connection.commit()
        res.close()
        print("Data is Inserted")

    def select():
        res = connection.cursor()
        sql = "SELECT * FROM user"
        res.execute(sql)
        data = res.fetchall()
        if data:
            print(tabulate(data, headers=('Roll No', 'Name', 'Age', 'City')))
        else:
            print("No records found.")
        res.close()

    def delete(id):
        res = connection.cursor()
        sql = "DELETE FROM user WHERE id = %s;"
        values = (id,)
        res.execute(sql, values)
        connection.commit()
        res.close()
        print("Data Deleted")

    def update(id, name, age, city):
        res = connection.cursor()
        sql = "UPDATE user SET name = %s, age = %s, city = %s WHERE id = %s"
        values = (name, age, city, id)
        res.execute(sql, values)
        connection.commit()
        res.close()
        print("The Record is updated")

    while True:
        print("##### MENU #####")
        print("1. Insert a Record")
        print("2. Display Records")
        print("3. Update a Record")
        print("4. Delete a Record")
        print("5. Quit")

        ch = int(input("Enter your choice:"))

        if ch == 1:
            id = int(input("Enter the Roll No:"))
            name = input("Enter the Name:")
            age = int(input("Enter the Age:"))
            city = input("Enter the City:")
            insert(id, name, age, city)

        if ch == 2:
            select()

        if ch == 3:
            id = int(input("Enter the Roll No:"))
            name = input("Enter the Name:")
            age = int(input("Enter the Age:"))
            city = input("Enter the City:")
            update(id, name, age, city)

        if ch == 4:
            id = int(input("Enter the Roll No:"))
            delete(id)

        if ch == 5:
            quit()

        if ch > 5:
            print("Enter a valid choice")

except Error as e:
    print("Error while connecting to MySQL:", e)

finally:
    if connection.is_connected():
        connection.close()
        print("MySQL connection is closed")