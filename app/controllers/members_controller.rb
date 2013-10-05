class MembersController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    @members = Member.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    respond_to do |format|
        format.html
        format.csv { send_data @members.to_csv } #{ render text: @members.to_csv }
        format.js
      end
  end
  
  def show
    @member = Member.find(params[:id])
  end
  
  def edit
    @member = Member.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      redirect_to members_path, :notice => "Member updated."
    else
      redirect_to members_path, :alert => "Unable to update member."
    end
  end
  
  def import
    Member.import(params[:file])
    redirect_to root_url, notice: "Members imported."
  end
  
  private

    def sort_column
      Member.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
  
end
