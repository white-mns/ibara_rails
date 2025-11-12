class World < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"

  scope :world_graph, ->(params)   {
    notnil().group(:world).ransack(params[:q]).result.world_id_to_name()
  }

  scope :world_id_to_name, ->()   {
    hash = self.count
    hash[:イバラシティ] = hash.delete(0)
    hash[:アンジニティ] = hash.delete(1)
    hash
  }

end
