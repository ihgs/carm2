class LearningLevelMap
  include Mongoid::Document

  field :_id, type: String
  field :learning_level, type: Hash #{tag: grade}

  def push tag, level
    begin
      level = Integer(level)
    rescue
      raise ArgumentError.new "level must be neumeric."
    end
    raise ArgumentError.new "tag's length must be orver 1." if tag.empty?
    raise ArgumentError.new "level must be between 0 and 25." if level > 20 or level < 0

    self.learning_level = Hash.new unless self.learning_level
    self.learning_level[tag] = level
  end
end
