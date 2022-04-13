class UsersController < ApplicationController
    def index
    end
  
    def show
      @user = User.find_by(id: params[:id])
      @posts = Post.where(user_id: @user.id).order("practice_day DESC")
      @days = ["日", "月", "火", "水", "木", "金", "土"]
    end
  
    def main
      @user = User.find_by(id: params[:id])
      @posts = Post.where(user_id: @user.id).order("practice_day DESC")
      @days = ["日", "月", "火", "水", "木", "金", "土"]
    end

    def mypage
      @distance_labels = ["1月", "2月", "3月", "4月", "5月", "6月", '7月', "8月", "9月", "10月", "11月", "12月"].to_json.html_safe
    end
  end