class UrlsController < ApplicationController
  def index
    @url = Url.new
  end

  def create
    @url = Url.new(urls_params)
    
    if @url.save
      redirect_to url_path(@url)
    else
      flash[:error] = @url.errors.full_messages
      format.html { render :show}
    end
  end

  private
    def urls_params
      params.require(:url).permit(:url)
    end
end
