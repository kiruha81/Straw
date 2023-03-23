class Public::CommentsController < ApplicationController
  def create
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    comment = current_customer.comments.new(comment_params)
    comment.shop_id = @shop.id
    if @comment.save
    else
      render shop_path(@shop)
    end
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    Comment.find_by(params[:id], shop_id: params[:shop_id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

end
