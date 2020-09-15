# Make the guest user inherit from User because petergate gem only communicates
# with active record type models
class GuestUser < User
  attr_accessor :name, :first_name, :last_name, :email, :id
end
