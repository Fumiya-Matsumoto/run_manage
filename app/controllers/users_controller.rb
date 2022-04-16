class UsersController < ApplicationController
    helper_method :month_distance, :chartdatas, :calc_rate_practice

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
      @user = User.find_by(id: params[:id])
      @posts  = Post.where(user_id: @user.id)
    end

    private

    def month_distance(posts, year, month)
      posts = posts.where(practice_day_year: year, practice_day_month: month)
      distance = 0

      posts.each do |post|
        post.post_records.each do |record|
          distance += record.distance_km
        end
      end

      return distance
    end

    def chartdatas(posts, year)
      data_list = (1...13).map {|i| month_distance(posts, year, i)}
      return data_list
    end

    def calc_rate_practice(posts, year, month)
      posts = posts.where(practice_day_year: year, practice_day_month: month)
      num_posts = posts.count
      li = []
      practice_kinds = ["ジョグ", "ペース走", "ビルドアップ", "距離走", "インターバル", "レペティション", "レース", "レスト"]
      practice_kinds.each do |practice|
        count = 0
        posts.each do |post|
          if post.kind_of_practice == practice
            count += 1
          end
        end
        li.append(count)
      end
      return li
    end
end