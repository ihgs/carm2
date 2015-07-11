module Network

  class << self

    def yaml
      YAML.load_file(File.join(Rails.root, "dot", "curriculum.yaml"))
    end

    def nodes level_map={}
      copy_level_map = level_map.clone
      base_nodes = yaml["nodes"].map do | node |
        id = node.keys[0]
        value = node[id]
        level = copy_level_map.delete(id)
        size = 5 + (level != nil ? level : 0 )
        {id: id, label: value.fetch("label", id), shape: "dot",size: size, group: value.fetch("group","undefined")}
      end
      unregister_nodes = copy_level_map.map do | key, value |
        {id: key, label: key, shape: "dot", size: 5 + value, group: "unregisgter"}
      end
      base_nodes.concat(unregister_nodes)
    end

    def edges
      yaml["edges"].map do |edge|
        from, to = edge.split(/\s*->\s*/)
        {from: from, to: to}
      end
    end

  end
end
