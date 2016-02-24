class TokensController < ApplicationController

  def create
    user = User.authenticate params[:username],params[:password]
    printf params.inspect
    if(user)
      Token.where(:user => user).delete_all
      token = Token.generate (user)
    else
      render :json => {:errors => "invalid login"}
      return
    end


    if token.save
      render json: token, :methods => [:access_token, :refresh_token], :except => [:hashed_access_token, :hashed_refresh_token]
    else
      render :json => {:errors => "invalid login"}
    end
  end

  def refresh
    token = Token.refresh(params[:refresh_token])
    if token.save
      render json: token, :methods => [:access_token, :refresh_token], :except => [:hashed_access_token, :hashed_refresh_token]
    else
      render :json => {:errors => "refresh token invalid"}
    end
  end

  def index
    @objects = Token.paginate(:page => params[:page])
  end

  def destroy
    current_user.token.delete
    render :json => {:result => "success"}
  end

end
