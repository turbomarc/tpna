class MembersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
     puts "SEARCH: #{params[:search]} -- REN_SEARCH: #{params[:ren_search]} -- REN_SEARCH_END: #{params[:ren_search_end]}"
    @members = Member.search(params[:search], params[:ren_search], params[:ren_search_end]).order(sort_column + " " + sort_direction).paginate(:per_page => 25, :page => params[:page])
    respond_to do |format|
        format.html
        format.csv { send_data @members.to_csv } #{ render text: @members.to_csv }
        format.xls# { send_data @members.to_csv(col_sep: "\t") }
        format.xlsx {
          send_data Member.search(params[:search], params[:ren_search], params[:ren_search_end]).to_xlsx.to_stream.read, :filename => download_filename, :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        }
        format.js
      end
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
    Member.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def download_filename
    ['tpna-members', params[:search], Time.current.to_s(:number)].compact.join('-') + '.xlsx'
  end

end
