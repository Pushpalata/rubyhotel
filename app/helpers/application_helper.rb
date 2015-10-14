module ApplicationHelper

  def booking_params(booking_field, default_val)
    val = default_val
    if params[:booking].present? and params[:booking][booking_field.to_sym].present?
      val = params[:booking][booking_field.to_sym]
    end
    val
  end

end
