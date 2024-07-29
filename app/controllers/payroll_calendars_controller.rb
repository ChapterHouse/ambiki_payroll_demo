class PayrollCalendarsController < ApplicationController
  before_action :set_payroll_calendar, only: %i[ show edit update destroy ]

  # GET /payroll_calendars or /payroll_calendars.json
  def index
    @payroll_calendars = PayrollCalendar.all
  end

  # GET /payroll_calendars/1 or /payroll_calendars/1.json
  def show
  end

  # GET /payroll_calendars/new
  def new
    @payroll_calendar = PayrollCalendar.new
  end

  # GET /payroll_calendars/1/edit
  def edit
  end

  # POST /payroll_calendars or /payroll_calendars.json
  def create
    @payroll_calendar = PayrollCalendar.new(payroll_calendar_params)

    respond_to do |format|
      if @payroll_calendar.save
        format.html { redirect_to payroll_calendar_url(@payroll_calendar), notice: "Payroll calendar was successfully created." }
        format.json { render :show, status: :created, location: @payroll_calendar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payroll_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payroll_calendars/1 or /payroll_calendars/1.json
  def update
    respond_to do |format|
      if @payroll_calendar.update(payroll_calendar_params)
        format.html { redirect_to payroll_calendar_url(@payroll_calendar), notice: "Payroll calendar was successfully updated." }
        format.json { render :show, status: :ok, location: @payroll_calendar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payroll_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payroll_calendars/1 or /payroll_calendars/1.json
  def destroy
    @payroll_calendar.destroy!

    respond_to do |format|
      format.html { redirect_to payroll_calendars_url, notice: "Payroll calendar was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payroll_calendar
      @payroll_calendar = PayrollCalendar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payroll_calendar_params
      params.require(:payroll_calendar).permit(:starts_on)
    end
end
