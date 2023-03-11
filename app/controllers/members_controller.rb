class MembersController < ApplicationController
  check_authorization

  helper_method :sort_column, :sort_direction

  def index
    authorize! :read, @user, :message => 'Not authorized to read.'
    @members = filtered_paginated_members
    respond_to do |format|
        format.html
        format.js
      end
  end

  def export
    authorize! :read, @user, :message => 'Not authorized to read.'
    @members = filtered_members
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"#{download_filename}\""
        headers['Content-Type'] ||= 'text/csv'
        column_names = Member.column_names
        csv_data = CSV.generate do |csv|
          csv <<  column_names
          @members.each do |member|
            csv << member.attributes.values_at(*column_names) 
          end
        end
        send_data csv_data, type: 'text/csv; charset=utf-8; header=present', disposition: "attachment; filename=#{download_filename}"
      end
    end
  end

  def new
    authorize! :create, @user, :message => 'Not authorized to create.'
    @member = Member.new
  end

  def create
    authorize! :create, @user, :message => 'Not authorized to create.'
      @member = Member.new(member_params)
      if @member.save
        redirect_to members_path, :notice => "Member created."
      else
        render 'new'
      end
  end

  def edit
    authorize! :read, @user, :message => 'Not authorized to view details.'
    @member = Member.find(params[:id])
  end

  def update
    authorize! :update, @user, :message => 'Not authorized to edit.'
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to members_path, :notice => "Member updated."
    else
      render 'edit'
    end
  end

  def import
    authorize! :update, @user, :message => 'Not authorized to edit.'
    Member.import(params[:file])
    redirect_to root_url, notice: "Members imported."
  end

  private

  def sort_column
    Member.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def download_filename
    ['tpna-members', params[:search], Time.current.to_s(:number)].compact.join('-') + '.csv'
  end

  def filtered_members
    Member.search(params[:search]).renewal_between(params[:renewal_date_start], params[:renewal_date_end]).order(sort_column + " " + sort_direction)
  end

  def filtered_paginated_members
    filtered_members.paginate(:per_page => 50, :page => params[:page])
  end

  def member_params
    params.require(:member).permit(:name, :street_address, :member_since, :last_payment_date, :amt, :paid_thru, :email, :phone)
  end
end
