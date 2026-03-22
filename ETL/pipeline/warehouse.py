from ..warehouse.dims import dim_customer

def create_dim_customer():
    print('---------------Customer dimension creation')
    c_data = dim_customer.extract()
    c_t_data = dim_customer.transform(c_data)
    print('---------------Create customer [OK]')
    

if __name__ == '__main__':
    create_dim_customer()