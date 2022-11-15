# frozen_string_literal: true

class SortImages
  attr_reader :sort_image_ids

  def initialize(sort_image_ids)
    @sort_image_ids = sort_image_ids
  end

  def temporary_new_ids
    blank_ids.size.times { |i| sort_image_ids[blank_ids[i]] = sort_ids.max + 1 }
  end

  def index_of_ids
    sort_ids.each_with_object(sort_ids.sort).map { |id, sorted| sorted.index(id) }
  end

  # def upload_filename
  #   image_id_index.map(&:to_i).each.with_index(1) { |id, index| images[id].blob.update(filename: index) }
  # end

  private

  def blank_ids
    sort_image_ids.each_index.select { |id| sort_image_ids[id] == '' }
  end

  def sort_ids
    sort_image_ids.map(&:to_i)
  end
end
