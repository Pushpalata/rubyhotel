class BookingsController < ApplicationController
  
  def index
    session[:booking_detail] = params[:booking]
    @room_types, @room_info = RoomType.search(params)
  end

  def new
    @booking = Booking.new(session[:booking_detail])
    @booking.checkin_date = Date.strptime(session[:booking_detail]["checkin_date"], "%m/%d/%Y") #rescue nil
    @booking.checkout_date = Date.strptime(session[:booking_detail]["checkout_date"], "%m/%d/%Y") rescue nil
    if params[:type].present?  
      @booking.room_type_id = params[:type]
      @booking.set_night_count
      @booking.set_payment_amount
      @room_type = @booking.room_type
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @room_type = @booking.room_type
    if @booking.save
      redirect_to @booking
    else
      logger.info @booking.errors.inspect
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @room_type = @booking.room_type
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:checkin_date, :checkout_date, :room_type_id, :room_count, :adult_count, :child_count, :name_title, :first_name, :last_name, :email, :phone_no, :address_line1, :address_line2, :city, :country, :state, :zipcode, :status, :payment_amount, :night_count)
    end
  
end
