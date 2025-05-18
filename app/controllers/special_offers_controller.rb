# == Schema Information
#
# Table name: special_offers
#
#  id            :integer          not null, primary key
#  activated_on  :integer
#  active        :boolean          default(FALSE), not null
#  discount      :decimal(5, 4)
#  next_affected :integer
#  product_code  :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_special_offers_on_product_code  (product_code)
#
# Foreign Keys
#
#  product_code  (product_code => products.code)
#
class SpecialOffersController < ApplicationController
  before_action :set_special_offer, only: %i[ show edit update destroy ]

  # GET /special_offers
  def index
    @special_offers = SpecialOffer.ordered
  end

  # GET /special_offers/1
  def show
  end

  # GET /special_offers/new
  def new
    @special_offer = SpecialOffer.new
  end

  # GET /special_offers/1/edit
  def edit
  end

  # POST /special_offers
  def create
    @special_offer = SpecialOffer.new(special_offer_params)

    if @special_offer.save
      redirect_to @special_offer, notice: "Special offer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /special_offers/1
  def update
    if @special_offer.update(special_offer_params)
      redirect_to @special_offer, notice: "Special offer was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /special_offers/1
  def destroy
    @special_offer.destroy!
    redirect_to special_offers_path, notice: "Special offer was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_offer
      @special_offer = SpecialOffer.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def special_offer_params
      params.expect(special_offer: [ :product_code, :activated_on, :next_affected, :discount, :active ])
    end
end
