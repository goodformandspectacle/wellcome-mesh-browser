class Subject < ActiveRecord::Base


  def records
    Record.where("metadata->'650' @> '[{\"0\" : \"#{identifier}\"}]'::jsonb")
  end

  def related_subjects

    @related_subjects ||= begin

      if related_identifiers.length > 0
        Subject.where(identifier: related_identifiers)
      else
        []
      end

    end

  end

end
