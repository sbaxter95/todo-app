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
      @list = current_user.lists.create(list_params)
      if @list.save
        redirect_to "/lists"
      else
        render :new
      end
    end
    
      def update
      @list = current_user.lists.find(params[:id])
      if @list.update(list_params)
        redirect_to "/lists"
      else
        render :edit
      end
    end

    def edit
      @list = List.find(params[:id])
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

