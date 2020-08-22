class User < ApplicationRecord

  validates :name,presence: true,length: {minimum: 3,maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true,format: {with: VALID_EMAIL_REGEX},uniqueness: true
  validates :password,presence: true,length: {minimum: 6}

  has_secure_password


  has_many :entries
  has_many :messages

  # 相手と自分のルームが存在する場合はそのroom_idの配列を返す、ない場合はFalseを返す
  def room_exists?(user)
    self_rooms = get_self_rooms
    partner_rooms = user.entries.pluck(:room_id)
    dup_rooms = self_rooms & partner_rooms
    if !dup_rooms.empty?
      dup_rooms
    else
      false
    end
  end

  def get_self_rooms
    self.entries.pluck(:room_id)
  end

end
