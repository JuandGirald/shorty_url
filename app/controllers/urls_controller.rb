class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.top(100)
  end

  def show
    @url = Url.find(params[:id])
  end

  def create
    @url = Url.new(urls_params)
    
    if @url.save
      redirect_to url_path(@url)
    else
      flash[:error] = @url.errors.full_messages
      redirect_to root_path
    end
  end

  def redirect
    url = Url.process(params[:id])
    redirect_to url.url
  end

  def not_found
  end

  private
    def urls_params
      params.require(:url).permit(:url)
    end
end
