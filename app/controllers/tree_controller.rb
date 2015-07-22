class TreeController < ApplicationController

  def index
    @subjects = Subject.select(:label, :all_labels, :tree_number)
    .from("(select label, all_labels, unnest(tree_numbers) as tree_number from subjects) as subjects")
    .where("tree_number LIKE '___'")
    .order(:tree_number)
    .limit(500)
  end

  def show

    @subject = Subject.select('*')
    .from("(select *, unnest(tree_numbers) as tree_number from subjects) as subjects")
    .find_by(tree_number: params[:id].gsub('/', '.'))

    if params[:id].length == 3

      @parent_subjects = []
    else

      parent_tree_numbers = []
      tree_number = params[:id].gsub('/', '.')

      while !tree_number.blank?

        tree_number = tree_number.gsub(/\.?[^\/\.]+\z/, '')
        parent_tree_numbers << tree_number unless tree_number.blank?

      end

      @parent_subjects = Subject.select('*')
      .from("(select *, unnest(tree_numbers) as tree_number from subjects) as subjects")
      .where(tree_number: parent_tree_numbers)
      .order(:tree_number)

    end

    @child_subjects = Subject.select(:label, :tree_number, :all_labels)
    .from("(select label, all_labels, unnest(tree_numbers) as tree_number from subjects) as subjects")
    .where("tree_number LIKE '#{@subject.tree_number}.___'")
    .order(:tree_number)
    .limit(500)

    @records = @subject.records.select(:identifier, :title).limit(50)

  end


end
