class MedicalRecordsController < ApplicationController
  before_action :set_medical_record, only: %i[ show edit update destroy ]
  before_action :validate_required_input, only: %i[index]

  # GET /medical_records or /medical_records.json
  def index
    
      @min = 0
      @max = 0
      @avg = 0
      @user = User.find(params[:user_id])
      starDate = Date.parse(params[:from]).beginning_of_day
      endDate = Date.parse(params[:to]).end_of_day
      range = (starDate..endDate)


      @medical_records = MedicalRecord.where(
        user_id:params[:user_id],
        created_at: range
      ).order(:created_at)

      if !@medical_records.empty? 
        @max = @medical_records.pluck(:level).max
        @min= @medical_records.pluck(:level).min
        @avg = @medical_records.pluck(:level).inject{ |sum, el| sum + el } / @medical_records.size
      end
 
  end

  # GET /medical_records/new
  def new
    @medical_record = MedicalRecord.new
  end

  # POST /medical_records or /medical_records.json
  def create
    @medical_record = MedicalRecord.new(medical_record_params)


    respond_to do |format|
      if daily_limit_exceed 
        format.html { redirect_to user_url(@medical_record.user), notice: "Daily limit exceed"}
      elsif @medical_record.save 
        
        format.html { redirect_to user_url(@medical_record.user), notice: "Medical record was successfully created." }
        format.json { render :show, status: :created, location: @medical_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medical_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medical_records/1 or /medical_records/1.json
  def update
    respond_to do |format|
      if @medical_record.update(medical_record_params)
        format.html { redirect_to medical_record_url(@medical_record), notice: "Medical record was successfully updated." }
        format.json { render :show, status: :ok, location: @medical_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @medical_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medical_records/1 or /medical_records/1.json
  def destroy
    @medical_record.destroy

    respond_to do |format|
      format.html { redirect_to medical_records_url, notice: "Medical record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medical_record
      @medical_record = MedicalRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def medical_record_params
      params.require(:medical_record).permit(:user_id, :level)
    end

    def report_params
      params.permit(:type, :timeframe)
    end

    def validate_required_input
      puts params[:to]
      puts params[:to].present?
      if params[:from].present? && params[:to].present? && params[:user_id].present?
        return true
      elsif !params[:to].present?
        flash[:notice] = "Report should have end date"
        redirect_back(fallback_location: root_path)
      else 
        redirect_to root_path, notice: "Report should be have user"
      end
    end

    def daily_limit_exceed
      return false if MedicalRecord.where(user_id:medical_record_params["user_id"]).count < 4
      
      MedicalRecord.where(user_id:medical_record_params["user_id"])
        .order(created_at: :desc)
        .take(4)
        .last
        .created_at
        .to_i > Date.today.beginning_of_day.to_i
    end
end
