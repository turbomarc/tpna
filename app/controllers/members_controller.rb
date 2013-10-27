class MembersController < ApplicationController
  # FIXME: Ensure user is authenticated to access anything in this controller.

  helper_method :sort_column, :sort_direction

  def index
    @members = filtered_paginated_members
    respond_to do |format|
        format.html
        format.csv { send_data @members.to_csv } #{ render text: @members.to_csv }
        format.xls# { send_data @members.to_csv(col_sep: "\t") }
        format.xlsx {
          send_data filtered_members.to_xlsx.to_stream.read, :filename => download_filename, :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
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

  def filtered_members
    Member.search(params[:search]).renewal_between(params[:ren_search], params[:ren_search_end])
  end

  def filtered_paginated_members
    filtered_members.order(sort_column + " " + sort_direction)
                    .paginate(:per_page => 25, :page => params[:page])
  end

end
