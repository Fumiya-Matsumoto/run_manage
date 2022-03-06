class HomeController < ApplicationController
    def top
        if user_signed_in?
            redirect_to("/users/#{current_user.id}/#{Date.today.year}/#{Date.today.month}")
        else
            render :layout => nil
        end
    end
end