json.extract! order, :id, :orderuserid, :orderproductid, :orderamount, :ordershipaddress, :ordercity, :orderphone, :ordershipping, :ordertax, :orderemail, :orderdate, :ordershipped, :ordertrackingnumber, :created_at, :updated_at
json.url order_url(order, format: :json)
