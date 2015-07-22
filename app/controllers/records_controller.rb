class RecordsController < ApplicationController


  def show
    @record = Record
      .select(:identifier, :title, :metadata)
      .find_by(identifier: params[:id])
  end


end
