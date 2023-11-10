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
    service = BookReservation::Create.new(params[:reservation][:book_id],
                                          current_user,
                                          params[:reservation][:pickup_time])
    @reservation = service.run

    if @reservation.errors.blank?
      redirect_to books_path, notice: "Your book is reserved. Reservation number #{@reservation.code}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    service = BookReservation::Update.new(@reservation,
                                          params[:reservation][:status])
    @reservation = service.run

    if @reservation.errors.blank?
      redirect_to reservations_path, notice: "Reservation updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
