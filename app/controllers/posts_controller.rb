class PostsController < ApplicationController
    def new
        @post = Post.new
        @post_records = @post.post_records.build
    end

    def create
        params[:post][:post_records_attributes].each do |num, hash|
            # タイムが未記入の箇所は0で補う
            if not hash[:time_hour]
                params[:post][:post_records_attributes][num][:time_hour] = 0
            end
            if not hash[:time_minute]
                params[:post][:post_records_attributes][num][:time_hour] = 0
            end
            if not hash[:time_second]
                params[:post][:post_records_attributes][num][:time_hour] = 0
            end

            # 入力値をint型に変換
            params[:post][:post_records_attributes][num][:time_hour] = 
            params[:post][:post_records_attributes][num][:time_hour].to_f
            params[:post][:post_records_attributes][num][:time_minute] = 
            params[:post][:post_records_attributes][num][:time_minute].to_f
            params[:post][:post_records_attributes][num][:time_second] = 
            params[:post][:post_records_attributes][num][:time_second].to_f

            # レスト以外ではペースを計算する
            if not params[:post][:kind_of_practice] == "レスト"
                total_seconds = 
                    3600 * params[:post][:post_records_attributes][num][:time_hour] + 
                    60 * params[:post][:post_records_attributes][num][:time_minute] + 
                    params[:post][:post_records_attributes][num][:time_second]

                params[:post][:post_records_attributes][num][:time] = total_seconds

                # distance_km、distance_m問題が解決したら以下のif文は直す
                if params[:post][:kind_of_practice] == "ペース走" or params[:post][:kind_of_practice] == "ビルドアップ" or params[:post][:kind_of_practice] == "インターバル" or params[:post][:kind_of_practice] == "レペティション" or params[:post][:kind_of_practice] == "レース"
                    params[:post][:post_records_attributes][num][:distance_m] = params[:post][:post_records_attributes][num][:distance].to_f
                    params[:post][:post_records_attributes][num][:distance_km] = params[:post][:post_records_attributes][num][:distance].to_f / 1000
                    pace = total_seconds / (params[:post][:post_records_attributes][num][:distance_km])
                else
                    params[:post][:post_records_attributes][num][:distance_km] = params[:post][:post_records_attributes][num][:distance].to_f
                    params[:post][:post_records_attributes][num][:distance_m] = params[:post][:post_records_attributes][num][:distance].to_f * 1000
                    pace = total_seconds / params[:post][:post_records_attributes][num][:distance_km]
                end

                pace_minute = pace.div(60)
                pace_second = pace % 60
                pace_undersecond = pace - pace.to_f
                params[:post][:post_records_attributes][num][:pace] = pace
                params[:post][:post_records_attributes][num][:pace_minute] = pace_minute
                params[:post][:post_records_attributes][num][:pace_second] = pace_second
                params[:post][:post_records_attributes][num][:pace_undersecond] = pace_undersecond
            end
        end

        post_params = params.require(:post).permit(
        :practice_timezone, :weather, :place, :kind_of_practice, 
        :strength, :content, :practice_day,
        post_records_attributes:[:distance_km, :distance_m, :time, :time_hour, :time_minute, :time_second, :record_type, :pace_minute, :pace_second, :pace_undersecond, :pace, :distance]
        ).merge(user_id: current_user.id)

        @post = Post.create(post_params) # createだとsaveまでしちゃってる？
        @post.user_id = current_user.id
        @post.practice_day_year = @post.practice_day.year
        @post.practice_day_month = @post.practice_day.month
        @post.practice_day_day = @post.practice_day.day
        days = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
        @post.practice_day_of_week = days[@post.practice_day.wday]
        @post.num = @post.post_records.length
        @post.num_s = @post.post_records.where(record_type: 0).length
        @post.num_r = @post.post_records.where(record_type: 1).length

        @post.time = @post.post_records.average(:time)
        @post.time_s = @post.post_records.where(record_type: 0).average(:time)
        @post.time_r = @post.post_records.where(record_type: 1).average(:time)

        @post.pace = @post.post_records.average(:pace)
        @post.pace_s = @post.post_records.where(record_type: 0).average(:pace)
        @post.pace_r = @post.post_records.where(record_type: 1).average(:pace)
        
        if @post.save
            flash[:notice] = "投稿を作成しました"
            redirect_to("/users/#{current_user.id}")
        else
            render("posts/new")
        end
    end

    def destroy_show
        @post = Post.find_by(id: params[:id])
        @post.destroy
        flash[:notice] = "投稿を削除しました"
        redirect_to("/users/#{@post.user_id}/#{@post.practice_day_year}/#{@post.practice_day_month}")
    end
    
    def destroy_main
        @post = Post.find_by(id: params[:id])
        @post.destroy
        flash[:notice] = "投稿を削除しました"
        redirect_to("/users/#{@post.user_id}")
    end

    def edit
        @post = Post.find_by(id: params[:id])
    end

    private
        def post_params
            params.require(:post).permit(
                :practice_timezone, :weather, :place, :kind_of_practice, 
                :strength, :content, :practice_day,
                post_records_attributes:[:distance_km, :time_hour, :time_minute, :time_second, :record_type, :pace_minute, :pace_second, :pace_undersecond]
                ).merge(user_id: current_user.id)
        end
end