class PayDurationsController < ApplicationController
  before_action :set_pay_duration, only: %i[ show edit update destroy position ]

  # GET /pay_durations or /pay_durations.json
  def index
    @pay_durations = PayDuration.all.order(position: :asc)
  end

  # GET /pay_durations/1 or /pay_durations/1.json
  def show
  end

  # GET /pay_durations/new
  def new
    @pay_duration = PayrollCalendar.first.pay_durations.new
  end

  # GET /pay_durations/1/edit
  def edit
    respond_to do |format|
      # format.turbo_stream {  render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@pay_duration)}") }
      format.turbo_stream
      format.html
    end
  end

  # POST /pay_durations or /pay_durations.json
  def create
    @pay_duration = PayrollCalendar.first.pay_durations.new(pay_duration_params)

    puts "Create pay period"
    respond_to do |format|
      if @pay_duration.save
        format.turbo_stream
        format.html { redirect_to pay_duration_url(@pay_duration), notice: "Pay period was successfully created." }
        format.json { render :show, status: :created, location: @pay_duration }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@pay_duration)}_form", partial: "form", locals: { pay_duration: @pay_duration }) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pay_duration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_durations/1 or /pay_durations/1.json
  def update
    respond_to do |format|
      if @pay_duration.update(pay_duration_params)
        format.turbo_stream {
          render :update
        }
        format.html { redirect_to pay_duration_url(@pay_duration), notice: "Pay period was successfully updated." }
        format.json { render :show, status: :ok, location: @pay_duration }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@pay_duration)}_form", partial: "form", locals: { pay_duration: @pay_duration }) }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pay_duration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_durations/1 or /pay_durations/1.json
  def destroy
    @pay_duration.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to pay_durations_url, notice: "Pay period was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def position
    @pay_duration.insert_at(params[:position].to_i)

    render turbo_stream:
             turbo_stream.replace("#pay_periods",
                                  partial: "list",
                                  locals: { payroll_calendar: @pay_duration.payroll_calendar })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_duration
      @pay_duration = PayDuration.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pay_duration_params
      params.require(:pay_duration).permit(:ending, :qualifier, :position, :payroll_calendar_id)
    end
end
