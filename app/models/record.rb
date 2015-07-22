class Record < ActiveRecord::Base


  def to_param
    identifier
  end

  def mesh_subjects

    subject_ids = []

    metadata['650'].each do |subject|

      if subject['0'] && subject['0'].match(/D\d+/)
        subject_ids << subject['0'].match(/(D\d+)/)[1]
      end

    end

    Subject.where(identifier: subject_ids)
  end

end
