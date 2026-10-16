import os
import pyodbc


def get_connection_string(driver, server, database, user=None, password=None):
    if user:
        return (
            f"DRIVER={{{driver}}};SERVER={server};DATABASE={database};"
            f"UID={user};PWD={password};TrustServerCertificate=yes;"
        )
    return (
        f"DRIVER={{{driver}}};SERVER={server};DATABASE={database};"
        f"Trusted_Connection=yes;TrustServerCertificate=yes;"
    )


def connect_to_sql_server(driver, server, database, user=None, password=None):
    """Return an open pyodbc connection."""
    conn_str = get_connection_string(driver, server, database, user, password)
    try:
        return pyodbc.connect(conn_str, timeout=10)
    except pyodbc.Error as e:
        raise RuntimeError(f"SQL Server connection failed: {e}")


def execute_query(connection, query, params=None):
    """Run a SELECT and return a list of dicts."""
    cursor = connection.cursor()
    cursor.execute(query, params or [])
    columns = [c[0] for c in cursor.description]
    rows = [dict(zip(columns, row)) for row in cursor.fetchall()]
    cursor.close()
    return rows

def execute_sql_file(connection, file_path):
    """Read a .sql file, run it, and return the rows as a list of dicts."""
    with open(file_path, "r", encoding="utf-8") as f:
        query = f.read()
    return execute_query(connection, query)

def close_connection(connection):
    if connection:
        connection.close()