class UsersController < ApplicationController
    helper_method :month_distance, :chartdatas, :calc_rate_practice, :calc_time

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

    def edit
      @user = User.find_by(id: params[:id])
      unless @user == current_user
        redirect_to user_path(@user)
      end
    end

    def update
      if params[:user][:min_800]
        time_800 = shape_times(min: params[:user][:min_800].to_f, sec: params[:user][:sec_800].to_f, msec: params[:user][:msec_800].to_f)
        params[:user][:time_800] = time_800
      end
      if params[:user][:min_1000]
        time_1000 = shape_times(min: params[:user][:min_1000].to_f, sec: params[:user][:sec_1000].to_f, msec: params[:user][:msec_1000].to_f)
        params[:user][:time_1000] = time_1000
      end
      
      # if params[:user][:min_1500]
      #   time_1500 = shape_times(min=params[:min_1500], sec=params[:sec_1500], msec=params[:msec_1500])
      #   params[:user][:time_1500] = time_1500
      # end
      # if params[:user][:min_3000]
      #   time_3000 = shape_times(min=params[:min_3000], sec=params[:sec_3000], msec=params[:msec_3000])
      #   params[:user][:time_3000] = time_3000
      # end
      # if params[:user][:min_5000]
      #   time_5000 = shape_times(min=params[:min_5000], sec=params[:sec_5000], msec=params[:msec_5000])
      # end
      # if params[:user][:min_10000]
      #   time_10000 = shape_times(min=params[:min_10000], sec=params[:sec_10000], msec=params[:msec_10000])
      # end
      # if params[:user][:min_3000sc]
      #   time_3000sc = shape_times(min=params[:min_3000sc], sec=params[:sec_3000sc], msec=params[:msec_3000sc])
      #   params[:user][:time_3000sc] = time_3000sc
      # end
      # if params[:user][:min_5km]
      #   time_5km = shape_times(hour=params[:hour_5k], min=params[:min_5k], sec=params[:sec_5k])
      #   params[:user][:time_5000] = time_5000
      # end
      # if params[:user][:min_10km]
      #   time_10km = shape_times(hour=params[:hour_10k], min=params[:min_10k], sec=params[:sec_10k])
      #   params[:user][:time_10000] = time_10000
      # end
      # if params[:user][:min_half]
      #   time_half = shape_times(hour=params[:hour_half], min=params[:min_half], sec=params[:sec_half])
      #   params[:user][:time_half] = time_half
      # end
      # if params[:user][:min_marathon]
      #   time_marathon = shape_times(hour=params[:hour_marathon], min=params[:min_5k], sec=params[:sec_5k])
      #   params[:user][:time_marathon] = time_marathon
      # end

      if current_user.update(user_params)
        redirect_to("/users/#{current_user.id}/mypage")
      else
        redirect_to edit_user_path(current_user)
      end
    end

    private

    def shape_times(hour: 0, min: 0, sec: 0, msec: 0)
      return hour*3600 + min*60 + sec + msec*0.01
    end

    def user_params
      params.fetch(:user, {}).permit(:name, :email, :age, :sex, :height, :weight, :time_800, :time_1000, :time_1500, :time_2000, :time_3000, :time_5000, :time_10000, :time_3000sc, :time_5km, :time_10km, :time_half, :time_marathon)
    end

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

    def calc_time(time)
      hour = (time / 3600).floor
      time -= hour*3600
      minute = (time / 60).floor
      time -= minute*60
      second = time.floor
      time -= second
      msecond = 100*time
      msecond = msecond.floor
      if msecond < 10
        msecond = "0" + msecond.to_s
      end
      return hour, minute, second, msecond
    end
end