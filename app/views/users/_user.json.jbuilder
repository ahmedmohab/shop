json.extract! user, :id, :useremail, :userpassword, :userfirstname, :userlastname, :usercity, :useremailverified, :userverificationcode, :userphone, :useraddress, :created_at, :updated_at
json.url user_url(user, format: :json)
