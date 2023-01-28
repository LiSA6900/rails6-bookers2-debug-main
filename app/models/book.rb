class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_belginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  # favorited_by?メソッドを作成する事でユーザーidがfavoriteテーブル内に存在するかどうかを判別している（いいねを既に押しているか、押していないか）
  # bookモデルで定義したものは後ほどviewで使用する。
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.search_for(content, method)
    if method == 'perfect' # タイトルが完全一致
      Book.where(title: content)
    elsif method == 'forward'  # タイトルが前方一致
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'  # タイトルが後方一致
      Book.where('title LIKE ?', '%'+content)
    else  # タイトルが部分一致
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end
end
