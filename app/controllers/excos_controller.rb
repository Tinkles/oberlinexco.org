class ExcosController < ApplicationController

  # we check all authorizations in the standard fashion except :all due to namespace collision
  # we authorize :all in the method itself (see below)
  load_and_authorize_resource

  # GET /excos
  # GET /excos.json
  def index
    @excos = Exco.current.by_course_number

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @excos }
    end
  end

  # GET /excos/all
  # GET /excos/all.json
  def all
    @excos = Exco.by_offered.by_course_number

    respond_to do |format|
      format.html { render :index } # index.html.haml
      format.json { render json: @excos }
    end
  end

  # GET /excos/1
  # GET /excos/1.json
  def show
    @exco = Exco.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @exco }
    end
  end

  # GET /excos/new
  # GET /excos/new.json
  def new
    @exco = Exco.new
    @exco.instructors.build

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @exco }
    end
  end

  # GET /excos/1/edit
  def edit
    @exco = Exco.find(params[:id])
  end

  # POST /excos
  # POST /excos.json
  def create
    @exco = Exco.new(params[:exco])

    respond_to do |format|
      if @exco.save
        format.html { redirect_to @exco, notice: 'Exco was successfully created.' }
        format.json { render json: @exco, status: :created, location: @exco }
      else
        format.html { render action: "new" }
        format.json { render json: @exco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /excos/1
  # PUT /excos/1.json
  def update
    @exco = Exco.find(params[:id])

    respond_to do |format|
      if @exco.update_attributes(params[:exco])
        format.html { redirect_to @exco, notice: 'Exco was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /excos/1
  # DELETE /excos/1.json
  def destroy
    @exco = Exco.find(params[:id])
    @exco.destroy

    respond_to do |format|
      format.html { redirect_to excos_path }
      format.json { head :no_content }
    end
  end

end
