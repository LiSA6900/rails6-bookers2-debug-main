class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    @comment.save
    # 非同期通信にするために下記削除する
    # redirect_to request.referer ※request.referer:遷移元のURLを取得してリダイレクトする
  end

  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    # 非同期通信にするために下記削除する
    # redirect_to request.referer
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
