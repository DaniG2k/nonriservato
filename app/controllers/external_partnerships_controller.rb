class ExternalPartnershipsController < ApplicationController
  # GET /external_partnerships
  # GET /external_partnerships.json
  def index
    @external_partnerships = ExternalPartnership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @external_partnerships }
    end
  end

  # GET /external_partnerships/1
  # GET /external_partnerships/1.json
  def show
    @external_partnership = ExternalPartnership.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @external_partnership }
    end
  end

  # GET /external_partnerships/new
  # GET /external_partnerships/new.json
  def new
    @external_partnership = ExternalPartnership.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @external_partnership }
    end
  end

  # GET /external_partnerships/1/edit
  def edit
    @external_partnership = ExternalPartnership.find(params[:id])
  end

  # POST /external_partnerships
  # POST /external_partnerships.json
  def create
    @external_partnership = ExternalPartnership.new(params[:external_partnership])

    respond_to do |format|
      if @external_partnership.save
        format.html { redirect_to @external_partnership, notice: 'External partnership was successfully created.' }
        format.json { render json: @external_partnership, status: :created, location: @external_partnership }
      else
        format.html { render action: "new" }
        format.json { render json: @external_partnership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /external_partnerships/1
  # PUT /external_partnerships/1.json
  def update
    @external_partnership = ExternalPartnership.find(params[:id])

    respond_to do |format|
      if @external_partnership.update_attributes(params[:external_partnership])
        format.html { redirect_to @external_partnership, notice: 'External partnership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @external_partnership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_partnerships/1
  # DELETE /external_partnerships/1.json
  def destroy
    @external_partnership = ExternalPartnership.find(params[:id])
    @external_partnership.destroy

    respond_to do |format|
      format.html { redirect_to external_partnerships_url }
      format.json { head :no_content }
    end
  end
end
