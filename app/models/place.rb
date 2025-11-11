class Place < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :field, :foreign_key => :field_id, :primary_key => :proper_id, :class_name => "ProperName"

    scope :pc_to_place_array, ->(params)   {
        pcs = Place.notnil().includes(:pc_name).ransack(params[:q]).result.pluck(:area_column, :area_row)
        areas = []
        pcs.each do |array| 
            columns = [array[0].ord, array[0].ord - 1, array[0].ord + 1]
            rows = [array[1], array[1] - 1, array[1] + 1]
            columns.each do |column|
                rows.each do |row|
                    areas.push( column.chr + "-" + sprintf("%d", row))
                end
            end
        end
        areas.uniq
    }
end
