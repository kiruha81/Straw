class Public::HomesController < ApplicationController
  def top
    @view_count_ranks = Shop.find(ViewCount.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @review_ranks = Shop.find(Review.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @favorite_ranks = Shop.find(Favorite.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @comment_ranks = Shop.find(Comment.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @view_counts = ViewCount.all
    @reviews = Review.all
    @favorites = Favorite.all
    @comments = Comment.all
  end

  def about
  end
end
