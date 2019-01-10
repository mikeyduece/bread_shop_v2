module Api
  module V1
    module Forums
      class ForumsController < ApiController
        before_action :doorkeeper_authorize!
        helper_method :forum
        def index
          # TODO: Set up filterring
        end

        def show
          success_response(data: Forums::OverviewSerializer.new(forum))
        end

        def create
          new_forum = Forum.new(forum_params)

          if new_forum.valid?
            new_forum.save

            success_response(code: 201, data: Forums::OverviewSerializer.new(new_forum))
          else
            error_response(code: 500, message: t('forum.errors.create'))
          end
        end

        private

        def forums
          @fourms ||= Forum.all
        end

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