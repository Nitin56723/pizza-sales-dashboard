import pandas as pd
from sqlalchemy import create_engine


def main():
    db_user = 'postgres'
    db_password = '34567'  # Use your password
    db_host = 'localhost'
    db_port = '5432'
    db_name = 'pizza_db'

    connection_string = f'postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}'

    try:
        engine = create_engine(connection_string)
        print("Database connection successful.")
    except Exception as e:
        print(f"Database connection failed: {e}")
        return

    sql_query = """
    SELECT
        pt.name,
        SUM(od.quantity) as total_sold
    FROM
        order_details AS od
    JOIN
        pizzas AS p ON od.pizza_id = p.pizza_id
    JOIN
        pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY
        pt.name
    ORDER BY
        total_sold DESC
    LIMIT 5;
    """

    df = pd.read_sql_query(sql_query, engine)

    print("\nTop 5 Best-Selling Pizzas:")
    print(df)


if __name__ == '__main__':
    main()