# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      # This cop enforces that private methods are defined using
      # `private def` for instance methods or
      # `private_class_method def self` for class methods.
      class PrivateMethodStyle < Base
        MSG_INSTANCE = 'Use `private def` for instance methods.'
        MSG_CLASS = 'Use `private_class_method def self` for class methods.'

        # def on_send(node)
        #   puts "Checking method: #{node.method_name}"
        #   return unless node.command?(:private)

        #   method_def_node = node.parent

        #   if instance_method?(method_def_node)
        #     add_offense(method_def_node, message: MSG_INSTANCE)
        #   elsif class_method?(method_def_node)
        #     add_offense(method_def_node, message: MSG_CLASS)
        #   end
        # end
        def on_def(node)
          method_name = node.children[0]&.to_s

          return unless class_method_definition?(node)

          puts "Checking method: #{method_name}"
          add_offense(node, message: MSG_CLASS)
        end

        private def class_method_definition?(node)
          node.defs_type? && node.children[0]&.to_s == 'self.use_collection'
        end

        private def instance_method?(node)
          return false unless node.def_type?

          method_name, _args, _body = *node
          method_name.to_s.start_with?('def') && !node.singleton_method?
        end

        private def class_method?(node)
          return false unless node.defs_type?

          _scope, method_name, _args, _body = *node
          method_name.to_s.start_with?('self.') && !node.arguments? && !node.singleton_method?
        end
      end
    end
  end
end
