from pathlib import Path
from sqlalchemy import text
from src.db.ingestion import run_sql_file
from src.db.connection import get_engine


def create_dw_schema(engine):
    with engine.begin() as conn:
        conn.execute(
            text('CREATE SCHEMA IF NOT EXISTS dw;')
        )
    

def create_dimension_tables(engine):
    ddl_script_dimensions = Path('ETL/warehouse/dims/create_dims.sql').absolute()
    run_sql_file(engine, ddl_script_dimensions)


if __name__ == '__main__':
    engine = get_engine()

    create_dw_schema(engine)

    create_dimension_tables(engine)

