class Public::SearchesController < ApplicationController
  def search
    @content = params[:content]
    @method = params[:method]

    @records = Materials.search_for(@content, @method)
  end
end