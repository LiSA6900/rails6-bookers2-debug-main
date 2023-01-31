class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_belginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  # 特定の期間の投稿数表示：今日の投稿数、今週の投稿数　scope
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日日
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日日
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日日
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日日

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
