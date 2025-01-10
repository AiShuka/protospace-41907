class PrototypesController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all  # すべてのプロトタイプの情報を取得し、@prototypesに代入
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)  # ストロングパラメーターを使って新しいPrototypeを作成

    if @prototype.save  # データ保存に成功した場合
      redirect_to root_path # ルートパスにリダイレクト
    else
      render :new, status: :unprocessable_entity  # 保存に失敗した場合は新規作成フォームに戻る
    end
  end

  def show
    @prototype = Prototype.find(params[:id])  
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])

    if @prototype.update(prototype_params) # 更新成功時に詳細ページにリダイレクト
      redirect_to @prototype
    else
      render :edit, status: :unprocessable_entity # 更新失敗時には編集ページを再表示
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])  
    
    if @prototype.destroy  # プロトタイプを削除
      redirect_to root_path # 削除後にトップページにリダイレクト
    else
      redirect_to prototypes_path # 削除に失敗した場合
    end
  end

  private

  def prototype_params
    # ストロングパラメーターで許可するフィールドを設定
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def correct_user
    @prototype = Prototype.find(params[:id])
    unless @prototype.user == current_user
      redirect_to root_path
    end
  end
end