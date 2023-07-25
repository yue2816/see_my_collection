class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user
  
  # 投稿画像をリサイズするメソッド
  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end
