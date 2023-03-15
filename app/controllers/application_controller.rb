class ApplicationController < ActionController::Base
  before_action :set_q

  def search
    @results = @q.result.page(params[:page]).per(10)
  end

   private

  def set_q
    @q = Shop.ransack(params[:q])
  end

end

