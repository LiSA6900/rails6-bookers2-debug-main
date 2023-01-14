class Favorite < ApplicationRecord
# ユーザーがいいねを押すことが出来るようにいいね機能を作成。
# 下記のようにアソシエーションを設定する事でユーザーといいね同士が繋がり、誰がいいねしたかが分かる。
  belongs_to :user
  belongs_to :book
  validates_uniqueness_of :book_id, scope: :user_id
  # validates_uniqueness_ofによって属性の値が一意であることをバリデーションが成立
  # 【参考URL】https://qiita.com/N396184501/items/109f23eff40bbd4e8b50
end
