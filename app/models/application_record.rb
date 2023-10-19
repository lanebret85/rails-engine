class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.searched_by_name(class_name, params)
    class_name.where("name ILIKE ?", "%#{params}%")
        .order(:name)
  end
end
