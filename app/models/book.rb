class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # favorited_by?メソッドを作成する事でユーザーidがfavoriteテーブル内に存在するかどうかを判別している（いいねを既に押しているか、押していないか）
  # bookモデルで定義したものは後ほどviewで使用する。
  
end
