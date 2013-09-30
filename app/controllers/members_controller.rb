class MembersController < ApplicationController
  def index
    @members = Member.paginate(:page => params[:page], :per_page => 30).order('id ASC')
    respond_to do |format|
        format.html
        format.csv { send_data @members.to_csv } #{ render text: @members.to_csv }
      end
  end
  
  def import
    Member.import(params[:file])
    redirect_to root_url, notice: "Members imported."
  end
  
end
