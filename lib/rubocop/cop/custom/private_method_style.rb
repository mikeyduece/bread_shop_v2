# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      # This cop enforces that private methods are defined using
      # `private def` for instance methods or
      # `private_class_method def self` for class methods.
      class PrivateMethodStyle < Base
        MSG = 'Use `private def` for instance methods or `private_class_method def self` for class methods.'

        def on_send(node)
          return unless node.command?(:private)

          method_def_node = node.parent

          if instance_method?(method_def_node) && !method_def_node.arguments?
            add_offense(method_def_node, message: MSG)
          elsif class_method?(method_def_node) && !method_def_node.arguments? && method_def_node.receiver&.type == :self
            add_offense(method_def_node, message: MSG)
          end
        end

        private def instance_method?(node)
          node.def_type? && !node.singleton_method?
        end

        private def class_method?(node)
          node.defs_type?
        end
      end
    end
  end
end
