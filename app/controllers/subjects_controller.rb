class SubjectsController < ApplicationController


  def show
    @subject = Subject.find_by(scheme: 'mesh', identifier: params[:id])

    @trees = []

    @subject.tree_numbers.each do |tree_number|

      parent_tree_numbers = [tree_number]

      while !tree_number.blank?

        tree_number = tree_number.gsub(/\.?[^\/\.]+\z/, '')
        parent_tree_numbers << tree_number unless tree_number.blank?

      end

      @trees << Subject.select('*')
      .from("(select *, unnest(tree_numbers) as tree_number from subjects) as subjects")
      .where(tree_number: parent_tree_numbers)
      .order(:tree_number)

    end

    @records = @subject.records.select(:identifier, :title).limit(10)

  end


end
