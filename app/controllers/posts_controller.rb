class PostsController < ApplicationController
    def new
        @post = Post.new
        @post.post_records.build
    end

    def create
        if not params[:post][:post_records_attributes][:"0"][:time_hour]
        params[:post][:post_records_attributes][:"0"][:time_hour] = 0
        end
        if not params[:post][:post_records_attributes][:"0"][:time_minute]
        params[:post][:post_records_attributes][:"0"][:time_minute] = 0
        end
        if not params[:post][:post_records_attributes][:"0"][:time_second]
        params[:post][:post_records_attributes][:"0"][:time_second] = 0
        end
        params[:post][:post_records_attributes][:"0"][:time_hour] = 
        params[:post][:post_records_attributes][:"0"][:time_hour].to_i
        params[:post][:post_records_attributes][:"0"][:time_minute] = 
        params[:post][:post_records_attributes][:"0"][:time_minute].to_i
        params[:post][:post_records_attributes][:"0"][:time_second] = 
        params[:post][:post_records_attributes][:"0"][:time_second].to_i
        if not params[:post][:kind_of_practice] == "レスト"
        total_seconds = 
            3600 * params[:post][:post_records_attributes][:"0"][:time_hour] + 
            60 * params[:post][:post_records_attributes][:"0"][:time_minute] + 
            params[:post][:post_records_attributes][:"0"][:time_second]
        pace = total_seconds / params[:post][:post_records_attributes][:"0"][:distance_km].to_i
        pace_minute = pace.div(60)
        pace_second = pace % 60
        pace_undersecond = pace - pace.to_i
        params[:post][:post_records_attributes][:"0"][:pace_minute] = pace_minute
        params[:post][:post_records_attributes][:"0"][:pace_second] = pace_second
        params[:post][:post_records_attributes][:"0"][:pace_undersecond] = pace_undersecond
        end

        post_params = params.require(:post).permit(
        :practice_timezone, :weather, :place, :kind_of_practice, 
        :strength, :content, :practice_day,
        post_records_attributes:[:distance_km, :time_hour, :time_minute, :time_second, :interval_type, :pace_minute, :pace_second, :pace_undersecond]
        ).merge(user_id: current_user.id)
        @post = Post.create(post_params)
        
        @post.user_id = current_user.id
        @post.practice_day_year = @post.practice_day.year
        @post.practice_day_month = @post.practice_day.month
        @post.practice_day_day = @post.practice_day.day
        days = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
        @post.practice_day_of_week = days[@post.practice_day.wday]
        if @post.save
        flash[:notice] = "投稿を作成しました"
        # redirect_to("/users/#{current_user.id}/#{@post.practice_day_year}/#{@post.practice_day_month}")
        redirect_to("/users/#{current_user.id}")
        else
        render("posts/new")
        end
    end
end