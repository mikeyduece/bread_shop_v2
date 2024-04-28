# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      # This cop enforces that classes inheriting from AbstractModel must call token_prop method.
      class RequireTokenProp < Base
        include RangeHelp
        extend AutoCorrector

        MSG = 'Classes inheriting from AbstractModel must call token_prop method.'

        def on_class(node)
          return unless abstract_model_inherited?(node)
          return if class_calls_token_prop?(node)

          add_offense(node, message: MSG) do |corrector|
            corrector.insert_after(node.loc.expression, "\n  token_prop\n")
          end
        end

        private def abstract_model_inherited?(node)
          parent_class = node.children[1]
          return false unless parent_class&.const_name

          parent_class.const_name == 'AbstractModel'
        end

        private def class_calls_token_prop?(node)
          node.body&.each do |child|
            return true if child.send_type? && child.method_name == :token_prop
          end
          false
        end

        private def class_name(node)
          node.children[0].const_name
        end
      end
    end
  end
end
