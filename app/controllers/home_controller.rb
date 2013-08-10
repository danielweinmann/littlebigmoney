class HomeController < ApplicationController
  def index
    @title = t("site.title")
  end
end