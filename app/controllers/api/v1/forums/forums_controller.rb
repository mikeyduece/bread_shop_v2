module Api
  module V1
    module Forums
      class ForumsController < WebController
        before_action :doorkeeper_authorize!
        helper_method :forum
        def index
          # TODO: Set up filterring

        end

        private

        def forum_params
          params.require(:forum).permit(:id, :title, :body, :user_id)
        end

        def forum
          @forum ||= Forum.find_by(id: params[:forum_id] || params[:id])
        end
      end
    end
  end
end