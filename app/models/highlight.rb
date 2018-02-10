class Highlight < ActiveRecord::Base
  attr_accessible :highlightable_id, :highlightable_type, :weight
  belongs_to :highlightable, polymorphic: true

  def is_last_event?(hl_relation)
    hl_relation.reverse.each do |ho|
      if ho.highlightable_type == "Event"
        return ho == self ? true : false
      end
    end
  end

  def get_parent
    case highlightable_type.downcase
    when 'event'
      Event.find(highlightable_id)
    when 'post'
      Post.find(highlightable_id)
    when 'project'
      Project.find(highlightable_id)
    end
  end
end
