class BooksController < ApplicationController

  # 一覧画面のアクション
  def index

    # Bookモデルの管理する全レコードを取得し、instance変数に格納。
    # 全データなので、instance変数を複数にした。【@books】
    @books = Book.all

    # Bookモデルの空のobjectを生成し、それをviewへ渡すinstance変数に格納。
    @book = Book.new

  end


  # newアクションを、indexページに一緒に表示するため、indexアクションに移動する。
  # 保存画面のアクション
  def create

    # 入力データをstrongパラメータのメソッドで受け取り、それを引数として
    # Book.newメソッドに渡す。そしてinstance変数に格納。
    @book = Book.new(book_params)


    # flashメッセージ は、ifでtrueを返すなら、flash[:notice] = "" & redirect_to
    ## flashメッセージ は、ifでfalseを返すなら、flash.new[:notice] = "" & render
    ## 今回は、flashメッセージのサクセスメッセージだけ (で、エラーメッセージの方は無い)。
    # 【バリデーション】の追加記述② (新規保存の場合)。
    ## この後は、newアクションのあるviewファイル (今回は、index) で(画面に)表示するエラーメッセージを記述へ。。
    # 【バリデーション】をif〜else で表す。
    ## ①対象カラムにデータが入力されていれば、(saveメソッドで) trueが返される。
    ## ②対象カラムにデータが入力されていなければ、(saveメソッドで) falseが返される。
    ## ①なら、表示したいページにredirect_toで遷移する。
    ## ②なら、新規ページをrenderで再表示する。

    # ①つまり、DBに保存できたら、
    if @book.save



      # flashメッセージのサクセスメッセージ (created)
      flash[:notice] = "Book was successfully created."

      # ifでtrueの時、基本的に redirect_to。
      # 詳細(show)画面に遷移する。
      redirect_to book_path(@book.id)

    # ②つまり、DBに保存ができなかったら、
    else


      # 今回は、見本サイトにflashでのエラーメッセージは無い。
      # 一覧(index)画面を再表示 (上書き) する。
      # つまり、bookモデルの管理する全レコードを再取得し、instance変数に格納。
      @books = Book.all

      # 【render :アクション名】 で、同じcontroller内の別アクションを表示する。
      # ifでfalseの時、基本的に render。
      # 今回は、一覧(index)画面を再表示。
      render :index

    end
  end



  # 詳細画面のアクション
  def show

    # 入力フォームから送信された(番号付きURL)データと、それに紐づくBookモデルが管理するレコードを1件取得。
    # それを、instance変数に格納。1件なので単数変数。
    @book = Book.find(params[:id])

  end



  # 編集画面のアクション
  def edit

    # 今回は、投稿済みデータを編集するので、保存されているデータが必要。
    # findメソッドで、保存されているデータを取得。
    @book = Book.find(params[:id])
  end



  # 編集を更新するアクション
  def update

    # 今回は、投稿済みデータを編集するので、保存されているデータが必要。
    # findメソッドで、保存されているデータを取得。
    # 今回は、instance変数にして、後で【バリデーションの】editのviewで参照できるようにする。
    @book = Book.find(params[:id])



    # バリデーションの追加記述② (更新保存の場合)。

    # book_params は、更新されたデータ。(つまり、自動代入後に自分で編集したデータ。)
    # book.update は、変数bookに updateメソッドを使用する事。
    # book.save と同じような事、update = 再save のような。
    # つまり、更新されたデータを引数に渡し(上書きされ)、変数@bookを再保存する。
    if @book.update(book_params)

    # flashメッセージのサクセスメッセージ (updated)
      flash[:notice] = "Book was successfully updated."

    # 詳細(show)画面に遷移。
    # book_path で、#show #update #destroyを兼ねる。(httpメソッドは違うけど。)
      redirect_to book_path(@book.id)

    # 対象カラムにデータが未入力ならば、(updateメソッドで) falseが返される。
    # つまり、DBに保存ができなかったら、
    else

      # 編集 (edit) 画面を再表示する。
      render :edit

    end
  end


  def destroy
    # 入力データをstrongパラメータのメソッドで受け取り、それを引数として
    # 該当するDBから1件取得し、変数bookに格納。
    book = Book.find(params[:id])

    # DBから削除する
    book.destroy

    # indexへ遷移する。
    # prefixの場合は、そのまま後ろへ記述。
    ## action名指定なら、 action: :new を後ろへ。
    ## 前のページなら、:back を後ろへ。
    redirect_to books_path

  end



  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
