class ArticlesController < ApplicationController
  before_filter :require_login, except: [:index, :show]

  def index
    @articles = Article.all
    @popular = Article.all.sort_by{ |a| a.view_count }.reverse.first(3)

    case params[:type]
      when 'month'
        @articles = Article.by_month(params[:month])
      end

    respond_to do |format|
      format.html
      format.xml {render xml: @articles }
    end
      
  end

  def show
    @article = Article.find params[:id]
    @article.increment_view
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new params[:article]
    @article.save
    flash.notice = "Article #{@article.title} created!"

    redirect_to article_path @article
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy
    flash.notice = "Article #{@article.title} removed"

    redirect_to articles_path
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]
    @article.update_attributes params[:article]

    flash.notice = "Article #{@article.title} updated!"

    redirect_to article_path(@article)
  end

end
