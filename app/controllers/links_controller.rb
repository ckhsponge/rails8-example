class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]

  def index
    @links = Link.all
  end

  def show; end

  def new
    @link = Link.new
  end

  def edit; end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to @link, notice: "Link created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      redirect_to @link, notice: "Link updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    redirect_to links_path, notice: "Link deleted."
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:name, :url)
  end
end
