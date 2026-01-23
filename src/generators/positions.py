from uuid import uuid4
from datetime import datetime

BUY = 1

def gen_positions(q):
    """
    Builds positions from Trade table using a single query.
    """
    NOW = datetime.now().isoformat()

    df = q("""
        SELECT 
            account_id,
            asset_id,
            type_id,
            quantity,
            price
        FROM public."Trade"
        WHERE deleted_at IS NULL
    """)

    positions = {}

    for row in df.itertuples(index=False):
        key = (str(row.account_id), str(row.asset_id))

        if key not in positions:
            positions[key] = {
                'net_qty': 0,
                'buy_notional': 0,
                'buy_qty': 0
            }

        if row.type_id == BUY:
            positions[key]['net_qty'] += float(row.quantity)
            positions[key]['buy_notional'] += float(row.quantity * row.price)
            positions[key]['buy_qty'] += float(row.quantity)

        else:  # SELL
            positions[key]['net_qty'] -= float(row.quantity)

    for (account_id, asset_id), agg in positions.items():

        if agg['net_qty'] <= 0:
            continue  # ignore closed positions

        avg_price = (
            agg['buy_notional'] / agg['buy_qty']
            if agg['buy_qty'] > 0
            else 0
        )

        yield (
            str(uuid4()),
            account_id,
            asset_id,
            round(agg['net_qty'], 6),
            round(avg_price, 6),
            NOW,
            NOW
        )
