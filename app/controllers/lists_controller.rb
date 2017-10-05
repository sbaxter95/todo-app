class ListsController < ApplicationController
    def index
      @user = User.find(current_user.id)
      @userid = @user.id
      @lists = List.all
      @userlists = @lists.where(user_id: current_user.id)
    end

    def new
      @list = List.new
    end

    def show
      @list = List.find(params[:id])
    end

    def create
      @user = User.find(current_user.id)

      new_item = List.create(list_params)
      new_item.user_id = current_user.id
      new_item.save

      redirect_to new_item

    end

    def edit
      @list = List.find(params[:id])
    end

    def update

      list = List.find(params[:id])
      list.update(list_params)

      redirect_to list
    end

    def destroy
      List.destroy(params[:id])
      redirect_to lists_path
    end

    protected
    def list_params
      params.require(:list).permit(:item, :user_id)
    end
  end

