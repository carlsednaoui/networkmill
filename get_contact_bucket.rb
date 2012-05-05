@user = User.find_by_id(1)


@contacts = Contact.find_all_by_user_id(@user.id)
puts @contacts
