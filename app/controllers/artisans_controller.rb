class ArtisansController < ApplicationController

  def new
    @artisan = Artisan.new
  end

  def create
    @artisan = Artisan.create(artisan_params)

    if @artisan.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def artisan_params
    params.require(:artisan).permit(:siret, :secteur)
  end
end
