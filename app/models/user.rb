class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :items
         has_many :orders

         validates :nickname, presence: true
         validates :last_name, 
         format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/},
         presence: true
         validates :first_name,
         format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/},
         presence: true
         validates :last_name_k, 
         format: { with: /\A[ァ-ヶー－]+\z/},
         presence: true
         validates :first_name_k, 
         format: { with: /\A[ァ-ヶー－]+\z/},
         presence: true
         validates :birthday, presence: true

end
