module Network

  class << self

    def yaml
      YAML.load_file(File.join(Rails.root, "dot", "curriculum.yaml"))
    end

    def nodes
      yaml["nodes"].map do | node |
        id = node.keys[0]
        value = node[id]
        {id: id, label: value.fetch("label", id), group: value.fetch("group","undefined")}
      end
    end

    def edges
      yaml["edges"].map do |edge|
        from, to = edge.split(/\s*->\s*/)
        {from: from, to: to}
      end
    end

    def groups
      yaml["groups"]
    end
  end
end
