class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @prototype = Prototype.find(params[:prototype_id])  
    @comment = @prototype.comments.build(comment_params)  

      # コメントが空でないかを確認
    if @comment.content.blank?
      # 空のコメントが送信された場合、処理を中止してそのページに留まる
      @comments = @prototype.comments
      render 'prototypes/show', status: :unprocessable_entity
    else
      if @comment.save  # コメントが正常に保存された場合
        redirect_to prototype_path(@prototype)  # プロトタイプの詳細ページにリダイレクト
      else
        # 保存に失敗した場合は再度フォームを表示
        @comments = @prototype.comments
        render 'prototypes/show', status: :unprocessable_entity  # コメント保存に失敗した場合、詳細ページに戻る
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end