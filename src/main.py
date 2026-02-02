import pandas as pd
from sqlalchemy import create_engine

def run_inventory_audit():
    # Database Connection (Replace 'your_password' before running)
    try:
        engine = create_engine('mysql+pymysql://root:your_password@localhost:3306/Anti_stockout')
        
        query = """
        SELECT 
            product_name, 
            current_stock, 
            reorder_level,
            (reorder_level - current_stock) AS units_to_order,
            unit_price,
            ((reorder_level - current_stock) * unit_price) AS investment_required
        FROM Inventory
        WHERE current_stock < reorder_level;
        """
        
        df = pd.read_sql(query, engine)
        
        print("\n" + "="*50)
        print(" OFFICE OF TRADE: PHARMACY PROCUREMENT REPORT")
        print("="*50)
        
        if not df.empty:
            print(df.to_string(index=False))
            total_investment = df['investment_required'].sum()
            print("-" * 50)
            print(f"TOTAL CAPITAL REQUIRED: KES {total_investment:,.2f}")
        else:
            print("MARKET EFFICIENCY: 100%. NO STOCK-OUTS DETECTED.")
            
    except Exception as e:
        print(f"Infrastructure Error: {e}")

if __name__ == "__main__":
    run_inventory_audit()
