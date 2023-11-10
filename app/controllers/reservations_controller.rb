# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[edit update]

  def index
    @reservations = if current_user.admin?
                      Reservation.by_code(params[:q])
                    else
                      current_user.reservations
                    end
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.status = Reservation.statuses[:reserved]

    if @reservation.save
      redirect_to books_path, notice: "Your book is reserved. Reservation number #{@reservation.code}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    status = Reservation.statuses.key(params[:reservation][:status].to_i)

    if @reservation.update(status: status)
      redirect_to reservations_path, notice: "Reservation updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:book_id, :status, :pickup_time)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
