# == Schema Information
#
# Table name: delivery_costs
#
#  id         :integer          not null, primary key
#  price      :decimal(18, 2)
#  threshold  :decimal(18, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DeliveryCostsController < ApplicationController
  before_action :set_delivery_cost, only: %i[ show edit update destroy ]

  # GET /delivery_costs
  def index
    @delivery_costs = DeliveryCost.ordered
  end

  # GET /delivery_costs/1
  def show
  end

  # GET /delivery_costs/new
  def new
    @delivery_cost = DeliveryCost.new
  end

  # GET /delivery_costs/1/edit
  def edit
  end

  # POST /delivery_costs
  def create
    @delivery_cost = DeliveryCost.new(delivery_cost_params)

    if @delivery_cost.save
      redirect_to @delivery_cost, notice: "Delivery cost was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /delivery_costs/1
  def update
    if @delivery_cost.update(delivery_cost_params)
      redirect_to @delivery_cost, notice: "Delivery cost was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /delivery_costs/1
  def destroy
    @delivery_cost.destroy!
    redirect_to delivery_costs_path, notice: "Delivery cost was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_cost
      @delivery_cost = DeliveryCost.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def delivery_cost_params
      params.expect(delivery_cost: [ :threshold, :price ])
    end
end
