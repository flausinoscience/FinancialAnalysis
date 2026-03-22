from src.db.connection import q


def extract():
    return q('SELECT * FROM staging.customer;')

    
def transform(df):
    print(df.head(20))

    
def load(df, conn):
   pass 
    
    