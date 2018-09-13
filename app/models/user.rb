class User < ApplicationRecord
  def self.from_omniauth(auth)
    # Retrieve relevant User or create a new one if necessary
    possible_users = User.where(email: auth["info"]["email"])
    possible_users = User.where(provider: auth["provider"], uid: auth["uid"]) if possible_users.length == 0
    new_user = possible_users.length == 0
    user = new_user ? User.new : possible_users[0]

    # Process the name provided by Google (fix capitalization as necessary, downcase letters if the name is all upper case)
    name = auth["info"]["name"].downcase
    [" ", "-", "\"", "'"].each do |char_split|
      name = name.split(char_split).map { |name_part| name_part[0].capitalize + name_part[1..-1] }.join(char_split)
    end

    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = name if user.name == nil or user.name == ""
    user.email = auth["info"]["email"]
    user.save!
    return user
  end
end
