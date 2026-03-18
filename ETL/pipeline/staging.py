from src.db.connection import get_engine
from src.db.ingestion import run_sql_file
from sqlalchemy import text
from pathlib import Path


def create_staging_schema(engine):
    with engine.begin() as conn:
        conn.execute(
            text('CREATE SCHEMA IF NOT EXISTS staging;')
        )


def get_staging_module_path():
   staging_module_path = Path('ETL/staging').absolute()
   return staging_module_path


if __name__ == '__main__':
    engine = get_engine()
    path = get_staging_module_path() 
    
    # ---------------------------------------------
    print('Creating staging schema ----->')
    create_staging_schema(engine)
    print('Create schema [OK]') 
    # ---------------------------------------------

    # ---------------------------------------------
    print('Creating staging tables---->')
    create_tables_sql_file = path / 'create_tables.sql' 
    run_sql_file(engine, create_tables_sql_file)
    print('Create tables [OK]')
    # ---------------------------------------------

    # ---------------------------------------------
    print('Loading data to the staging tables----->')
    load_files = [
        'load_countries.sql',
        'load_currencies.sql',
        'load_customers.sql',
        'load_account_status.sql',
        'load_account_types.sql',
        'load_accounts.sql',
        'load_asset_types.sql',
        'load_assets.sql',
        'load_brokerages.sql',
        'load_market_prices.sql',
        'load_positions.sql',
        'load_trade_types.sql',
        'load_trades.sql'
    ]
    for file_to_load in load_files:
        run_sql_file(engine, path / file_to_load)
        print(f'\t{file_to_load} [OK]')
    print('Loading [OK]')
    # ---------------------------------------------



    