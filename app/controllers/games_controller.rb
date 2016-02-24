class GamesController < ApplicationController

  def new
    @object = Game.new

    @users = User.all
    @players = @users
  end

  def create

    @object = Game.new(get_request_as_json params, :game)

    @users = User.all
    @players = @users

    if @object.winner
      if @object.winner == @object.player1
        @object.loser = @object.player2
      end
    end

    if @object.save

      respond_to do |format|
        format.html  {redirect_to @object}
        format.json  { render :json => @object }
      end

    else
      respond_to do |format|
        format.html  {render 'new'}
        format.json  { render :json => {:result => "Error"} }
      end
    end
  end

  def show
    @title = 'Details'
    id = params[:id]
    @object = Game.find(id)

    respond_to do |format|
      format.html  #normal flow
      format.json  { render :json => @object}
    end

  end

  def edit

    @users = User.all
    @players = @users

    @title = "Edit"
    @object = Game.find(id = params[:id])

    respond_to do |format|
      format.html  #normal flow
      format.json  { render :json => @object }
    end
  end

  def update
    @object = Game.find(params[:id])

    @users = User.all
    @players = @users

    if @object.winner
      if @object.winner == @object.player1
        @object.loser = @object.player2
      end
    end

    if @object.update_attributes(get_request_as_json params, :game)

      respond_to do |format|
        format.html  {redirect_to @object}
        format.json  { render :json => @object }
      end

    else
      respond_to do |format|
        format.html  {render 'edit'}
        format.json  { render :json => {:result => "Error"} }
      end
    end
  end

  def index

    @objects = Game.all

    respond_to do |format|
      format.html  #normal flow
      format.json  {render :json => @objects }
    end
  end

  def destroy
    object = Game.find(params[:id])

    object.destroy

    respond_to do |format|
      format.html  {redirect_to games_path, :flash => {:success => "Object Deleted"}}
      format.json  {render :json => {:result => "success"}}
    end
  end

  def winner

    user = User.find(params[:user_id])
    @object = Game.find(params[:game_id])

    if(!@object.winner)
    @object.winner = user
      if @object.winner == @object.player1
        @object.loser = @object.player2
      end

    end

    respond_to do |format|
      format.html  {render :show}
      format.json  { render :json => @object}
    end

  end

end