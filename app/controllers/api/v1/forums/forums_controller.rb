module Api
  module V1
    module Forums
      class ForumsController < ApiController
        before_action :doorkeeper_authorize!
        helper_method :forum
        helper_method :forums

        def index
          forum_list = forums.limit(params[:limit]) || []

          success_response(data: Forums::PrivateSerializer.new(forum_list))
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
            error_response(code: 500, message: t('forum.error.create'))
          end
        end

        private

        def forums
          @forums ||= Forum.all
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