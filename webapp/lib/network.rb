module Network

  class Node
    attr_accessor :id, :label, :level, :shape, :group

    @@base_size = 5

    def initialize opts={}
      @id = opts[:id]
      @label = opts.fetch(:label, @id)
      @shape = opts.fetch(:shape, "dot")
      @group = opts.fetch(:group, "undefined")
      @level = opts.fetch(:level, 0)
    end

    def size
      @size = @@base_size + (@level != nil ? @level : 0 )
    end

    def data
      h = Hash.new
      [:id, :label, :size, :shape, :group].each do |key|
        h[key] = self.send(key)
      end
      h
    end
  end

  class << self

    def graph_data level_map={}
      copy_level_map = level_map.clone
      nodes, edges = load_data
      base_nodes = nodes.map do | node |
        level = copy_level_map.delete(node.id)
        node.level = (level != nil ? level : 0 )
        node.data
      end
      unregister_nodes = copy_level_map.map do | key, value |
        {id: key, label: key, shape: "dot", size: 5 + value, group: "unregisgter"}
      end
      base_nodes.concat(unregister_nodes)

      return base_nodes, edges
    end


    private
      def load_data
        yaml_dir = File.join(Rails.root, "curriculum")
        all_nodes = []
        all_edges = []
        Dir::glob(File.join(yaml_dir, "*.yaml")) do |f|
          nodes, edges = load_yaml f
          all_nodes.concat(nodes) if nodes
          all_edges.concat(edges) if edges
        end
        return all_nodes, all_edges
      end

      def load_yaml path
        yaml = YAML.load_file(path)
        default_group = yaml["default"].fetch("group", "undefined")

        nodes = yaml["nodes"].map do | node |
          id = node.keys[0]
          value = node[id] ? node[id] : {}
          node = Network::Node.new  id:     id,
                                    group:  value.fetch("group", default_group)
        end if yaml["nodes"]

        edges = yaml["edges"].map do |edge|
          from, to = edge.split(/\s*->\s*/)
          {from: from, to: to}
        end if yaml["edges"]

        return nodes, edges
      end

  end
end
