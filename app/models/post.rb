class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user

  # 検索方法分岐
  def self.looks(search, word)
    # 完全一致
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    # 部分一致
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  # 投稿画像をリサイズするメソッド
  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end
