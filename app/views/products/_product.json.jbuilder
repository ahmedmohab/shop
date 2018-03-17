json.extract! product, :id, :productname, :productprice, :productweight, :productdesc, :productthumb, :productimage, :productcategoryid, :productstock, :productlocation, :created_at, :updated_at
json.url product_url(product, format: :json)
