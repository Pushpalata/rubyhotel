class RoomTypesController < ApplicationController
  before_action :set_room_type, only: [:show, :edit, :update, :destroy]
  before_filter :user_authentication!
  layout 'admin'
  
  def index
    @room_types = RoomType.all
  end

  def show
  end

  def new
    @room_type = RoomType.new
  end

  def edit
  end

  def create
    @room_type = RoomType.new(room_type_params)

    respond_to do |format|
      if @room_type.save
        format.html { redirect_to @room_type, notice: 'Room type was successfully created.' }
        format.json { render :show, status: :created, location: @room_type }
      else
        format.html { render :new }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room_type.update(room_type_params)
        format.html { redirect_to @room_type, notice: 'Room type was successfully updated.' }
        format.json { render :show, status: :ok, location: @room_type }
      else
        format.html { render :edit }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room_type.destroy
    respond_to do |format|
      format.html { redirect_to room_types_url, notice: 'Room type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_type
      @room_type = RoomType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_type_params
      params.require(:room_type).permit(:name, :rate, :room_count)
    end
end
