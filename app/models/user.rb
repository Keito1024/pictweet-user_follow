class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable
  has_many :tweets
  has_many :comments               #commentsテーブルとのアソシエーション
  has_many :likes



  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy

has_many :followings, through: :following_relationships

has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy

has_many :followers, through: :follower_relationships

 def following?(other_user)
   following_relationships.find_by(following_id: other_user.id)
 end

 def follow!(other_user)
   following_relationships.create!(following_id: other_user.id)
 end

 def unfollow!(other_user)
   following_relationships.find_by(following_id: other_user.id).destroy
 end







 def self.from_omniauth(auth)
 where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
   user.email = auth.info.email
   user.password = Devise.friendly_token[0,20]
   user.nickname = auth.info.name   # assuming the user model has a name
   user.image = auth.info.image # assuming the user model has an image
   # If you are using confirmable and the provider(s) you use validate emails,
   # uncomment the line below to skip the confirmation emails.
   # user.skip_confirmation!
 end
 end

end
