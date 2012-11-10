class SiteController < ApplicationController
  def index
    #random five pictures for the caroussel
    @photos = Photo.where("is_private = false").order("RAND()").limit(5)
  end
end
