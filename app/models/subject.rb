class Subject < ActiveRecord::Base


  def records
    Record.where("metadata->'650' @> '[{\"0\" : \"#{identifier}\"}]'::jsonb")
  end

end
