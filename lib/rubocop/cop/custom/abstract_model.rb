# frozen_string_literal: true

# path/to/custom_cops/abstract_class_cop.rb
module RuboCop
  module Cop
    module Custom
      # Enforces that models inherit from AbstractClass
      class AbstractModel < Base
        def on_class(node)
          return unless in_app_models?(node)
          return if inherits_from_abstract_class?(node)

          add_offense(node, message: 'Classes in app/models/ must inherit from AbstractClass')
        end

        private def in_app_models?(_)
          file_path = processed_source.file_path
          file_path.start_with?(Rails.root.join('app', 'models').to_s)
        end

        private def inherits_from_abstract_class?(node)
          parent_class = node.children[1]
          return false unless parent_class&.const_name

          parent_class.const_name == 'AbstractClass'
        end
      end
    end
  end
end
