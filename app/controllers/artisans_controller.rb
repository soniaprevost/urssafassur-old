class ArtisansController < ApplicationController

  def new
    @artisan = Artisan.new
  end

  def create
    @artisan = Artisan.create(artisan_params)

    if @artisan.save
      update_artisan_with_sirene_api(siret: @artisan.siret)

      redirect_to artisan_path(@artisan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @artisan = Artisan.find(params[:id])
    @new_artisan = Artisan.new
  end

  private

  def update_artisan_with_sirene_api(siret:)
    find_artisan = ArtisanContact.get(siret: siret)
    @artisan.update(
      name: find_artisan.name,
      ape_code: find_artisan.ape
    )
  end

  def artisan_params
    params.require(:artisan).permit(:siret, :secteur)
  end
end
