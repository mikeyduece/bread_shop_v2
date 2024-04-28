# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `stream-ruby` gem.
# Please instead update this file by running `bin/tapioca gem stream-ruby`.

# source://stream-ruby//lib/stream/errors.rb#1
module Stream
  class << self
    # source://stream-ruby//lib/stream/base.rb#9
    def connect(api_key, api_secret); end

    # source://stream-ruby//lib/stream/base.rb#13
    def get_feed_slug_and_id(feed_id); end
  end
end

# source://stream-ruby//lib/stream/url.rb#8
class Stream::APIURLGenerator < ::Stream::URLGenerator
  # @return [APIURLGenerator] a new instance of APIURLGenerator
  #
  # source://stream-ruby//lib/stream/url.rb#9
  def initialize(options); end

  private

  # source://stream-ruby//lib/stream/url.rb#36
  def make_location(loc); end
end

# source://stream-ruby//lib/stream/activities.rb#2
module Stream::Activities
  # Partial update activity, via activity ID or Foreign ID + timestamp
  #
  # @example Identify using activity ID
  #   @client.activity_partial_update(
  #   id: "4b39fda2-d6e2-42c9-9abf-5301ef071b12",
  #   set: {
  #   "product.price.eur": 12.99,
  #   "colors": {
  #   "blue": "#0000ff",
  #   "green": "#00ff00",
  #   }
  #   },
  #   unset: [ "popularity", "size.xl" ]
  #   )
  # @example Identify using Foreign ID + timestamp
  #   @client.activity_partial_update(
  #   foreign_id: 'product:123',
  #   time: '2016-11-10T13:20:00.000000',
  #   set: {
  #   "product.price.eur": 12.99,
  #   "colors": {
  #   "blue": "#0000ff",
  #   "green": "#00ff00",
  #   }
  #   },
  #   unset: [ "popularity", "size.xl" ]
  #   )
  # @param data [Hash<:id, :foreign_id, :time, :set, :unset>] the request params (id and foreign_id+timestamp mutually exclusive)
  # @return the updated activity.
  #
  # source://stream-ruby//lib/stream/activities.rb#77
  def activity_partial_update(data = T.unsafe(nil)); end

  # Batch partial activity update
  #
  # @example Identify using activity IDs
  #   @client.batch_activity_partial_update([
  #   {
  #   id: "4b39fda2-d6e2-42c9-9abf-5301ef071b12",
  #   set: {
  #   "product.price.eur": 12.99,
  #   "colors": {
  #   "blue": "#0000ff",
  #   "green": "#00ff00",
  #   }
  #   },
  #   unset: [ "popularity", "size.x2" ]
  #   },
  #   {
  #   id: "8d2dcad8-1e34-11e9-8b10-9cb6d0925edd",
  #   set: {
  #   "product.price.eur": 17.99,
  #   "colors": {
  #   "red": "#ff0000",
  #   "green": "#00ff00",
  #   }
  #   },
  #   unset: [ "rating" ]
  #   }
  #   ])
  # @example Identify using Foreign IDs + timestamps
  #   @client.batch_activity_partial_update([
  #   {
  #   foreign_id: "product:123",
  #   time: '2016-11-10T13:20:00.000000',
  #   set: {
  #   "product.price.eur": 22.99,
  #   "colors": {
  #   "blue": "#0000ff",
  #   "green": "#00ff00",
  #   }
  #   },
  #   unset: [ "popularity", "size.x2" ]
  #   },
  #   {
  #   foreign_id: "product:1234",
  #   time: '2017-11-10T13:20:00.000000',
  #   set: {
  #   "product.price.eur": 37.99,
  #   "colors": {
  #   "black": "#000000",
  #   "white": "#ffffff",
  #   }
  #   },
  #   unset: [ "rating" ]
  #   }
  #   ])
  # @param changes [Array< Hash<:id, :foreign_id, :time, :set, :unset> >] the list of changes to be applied
  # @return the updated activities
  #
  # source://stream-ruby//lib/stream/activities.rb#143
  def batch_activity_partial_update(changes = T.unsafe(nil)); end

  # Get activities directly, via ID or Foreign ID + timestamp
  #
  # @example Retrieve by activity IDs
  #   @client.get_activities(
  #   ids: [
  #   '4b39fda2-d6e2-42c9-9abf-5301ef071b12',
  #   '89b910d3-1ef5-44f8-914e-e7735d79e817'
  #   ]
  #   )
  # @example Retrieve by Foreign IDs + timestamps
  #   @client.get_activities(
  #   foreign_id_times: [
  #   { foreign_id: 'post:1000', time: '2016-11-10T13:20:00.000000' },
  #   { foreign_id: 'like:2000', time: '2018-01-07T09:15:59.123456' }
  #   ]
  #   )
  # @param params [Hash<:ids, :foreign_id_times>] the request params (ids or list of <:foreign_id, :time> objects)
  # @return the found activities, if any.
  #
  # source://stream-ruby//lib/stream/activities.rb#26
  def get_activities(params = T.unsafe(nil)); end
end

# source://stream-ruby//lib/stream/batch.rb#2
module Stream::Batch
  # Adds an activity to many feeds in one single request
  #
  # @param activity_data [Hash] the activity do add
  # @param feeds [Array<string>] list of feeds (eg. 'user:1', 'flat:2')
  # @return [nil]
  #
  # source://stream-ruby//lib/stream/batch.rb#51
  def add_to_many(activity_data, feeds); end

  # Follows many feeds in one single request
  #
  # @example
  #   follows = [
  #   {:source => 'flat:1', :target => 'user:1'},
  #   {:source => 'flat:1', :target => 'user:3'}
  #   ]
  #   @client.follow_many(follows)
  # @param follows [Array<Hash<:source, :target>>] the list of follows
  # @return [nil]
  #
  # source://stream-ruby//lib/stream/batch.rb#17
  def follow_many(follows, activity_copy_limit = T.unsafe(nil)); end

  # Unfollow many feeds in one single request
  #
  # return [nil]
  #
  # @example
  #   unfollows = [
  #   {source: 'user:1', target: 'timeline:1'},
  #   {source: 'user:2', target: 'timeline:2', keep_history: false}
  #   ]
  #   @client.unfollow_many(unfollows)
  # @param unfollows [Array<Hash<:source, :target, :keep_history>>] the list of follows to remove.
  #
  # source://stream-ruby//lib/stream/batch.rb#38
  def unfollow_many(unfollows); end
end

# source://stream-ruby//lib/stream/client.rb#11
class Stream::Client
  include ::Stream::Batch
  include ::Stream::Activities

  # initializes a Stream API Client
  #
  # @example initialise the client to connect to EU-West location
  #   Stream::Client.new('my_key', 'my_secret', 'my_app_id', :location => 'us-east')
  # @param api_key [string] your application api_key
  # @param api_secret [string] your application secret
  # @param app_id [string] the id of your application (optional)
  # @param opts [hash] extra options
  # @return [Client] a new instance of Client
  #
  # source://stream-ruby//lib/stream/client.rb#38
  def initialize(api_key = T.unsafe(nil), api_secret = T.unsafe(nil), app_id = T.unsafe(nil), opts = T.unsafe(nil)); end

  # Returns the value of attribute api_key.
  #
  # source://stream-ruby//lib/stream/client.rb#12
  def api_key; end

  # Returns the value of attribute api_secret.
  #
  # source://stream-ruby//lib/stream/client.rb#13
  def api_secret; end

  # Returns the value of attribute app_id.
  #
  # source://stream-ruby//lib/stream/client.rb#14
  def app_id; end

  # Returns the value of attribute client_options.
  #
  # source://stream-ruby//lib/stream/client.rb#15
  def client_options; end

  # source://stream-ruby//lib/stream/client.rb#109
  def collections; end

  # Creates a user token
  #
  # @deprecated Use Client#create_user_token instead
  # @param user_id [string] the user_if of this token (e.g. User42)
  # @param extra_data [hash] additional token data
  # @return [string]
  #
  # source://stream-ruby//lib/stream/client.rb#90
  def create_user_session_token(user_id, extra_data = T.unsafe(nil)); end

  # Creates a user token
  #
  # @param user_id [string] the user_if of this token (e.g. User42)
  # @param extra_data [hash] additional token data
  # @return [string]
  #
  # source://stream-ruby//lib/stream/client.rb#101
  def create_user_token(user_id, extra_data = T.unsafe(nil)); end

  # Creates a feed instance
  #
  # @param feed_slug [string] the feed slug (eg. flat, aggregated...)
  # @param user_id [user_id] the user_id of this feed (eg. User42)
  # @return [Stream::Feed]
  #
  # source://stream-ruby//lib/stream/client.rb#77
  def feed(feed_slug, user_id); end

  # source://stream-ruby//lib/stream/client.rb#135
  def get_default_params; end

  # source://stream-ruby//lib/stream/client.rb#139
  def get_http_client; end

  # source://stream-ruby//lib/stream/client.rb#143
  def make_query_params(params); end

  # source://stream-ruby//lib/stream/client.rb#147
  def make_request(method, relative_url, signature, params = T.unsafe(nil), data = T.unsafe(nil), headers = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/client.rb#130
  def og(uri); end

  # source://stream-ruby//lib/stream/client.rb#105
  def personalization; end

  # source://stream-ruby//lib/stream/client.rb#113
  def reactions; end

  # source://stream-ruby//lib/stream/client.rb#125
  def update_activities(activities); end

  # source://stream-ruby//lib/stream/client.rb#121
  def update_activity(activity); end

  # source://stream-ruby//lib/stream/client.rb#117
  def users; end

  private

  # source://stream-ruby//lib/stream/client.rb#155
  def url_generator; end
end

# source://stream-ruby//lib/stream/collections.rb#2
class Stream::CollectionsClient < ::Stream::Client
  # source://stream-ruby//lib/stream/collections.rb#3
  def add(collection_name, collection_data, id: T.unsafe(nil), user_id: T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/collections.rb#55
  def create_reference(collection, id); end

  # source://stream-ruby//lib/stream/collections.rb#26
  def delete(collection_name, id); end

  # source://stream-ruby//lib/stream/collections.rb#47
  def delete_many(collection, ids = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/collections.rb#13
  def get(collection_name, id); end

  # source://stream-ruby//lib/stream/collections.rb#40
  def select(collection, ids = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/collections.rb#18
  def update(collection_name, id, data: T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/collections.rb#31
  def upsert(collection, objects = T.unsafe(nil)); end

  private

  # source://stream-ruby//lib/stream/collections.rb#63
  def make_collection_request(method, params, data, endpoint: T.unsafe(nil)); end
end

# source://stream-ruby//lib/stream/errors.rb#2
class Stream::Error < ::StandardError; end

# source://stream-ruby//lib/stream/feed.rb#5
class Stream::Feed
  # @raise [StreamInputData]
  # @return [Feed] a new instance of Feed
  #
  # source://stream-ruby//lib/stream/feed.rb#10
  def initialize(client, feed_slug, user_id); end

  # source://stream-ruby//lib/stream/feed.rb#62
  def add_activities(activities); end

  # source://stream-ruby//lib/stream/feed.rb#54
  def add_activity(activity_data); end

  # source://stream-ruby//lib/stream/feed.rb#108
  def follow(target_feed_slug, target_user_id, activity_copy_limit = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/feed.rb#122
  def followers(offset = T.unsafe(nil), limit = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/feed.rb#133
  def following(offset = T.unsafe(nil), limit = T.unsafe(nil), filter = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/feed.rb#35
  def get(params = T.unsafe(nil)); end

  # Returns the value of attribute id.
  #
  # source://stream-ruby//lib/stream/feed.rb#6
  def id; end

  # source://stream-ruby//lib/stream/feed.rb#23
  def readonly_token; end

  # source://stream-ruby//lib/stream/feed.rb#70
  def remove(activity_id, foreign_id: T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/feed.rb#74
  def remove_activity(activity_id, foreign_id: T.unsafe(nil)); end

  # Returns the value of attribute slug.
  #
  # source://stream-ruby//lib/stream/feed.rb#7
  def slug; end

  # source://stream-ruby//lib/stream/feed.rb#145
  def unfollow(target_feed_slug, target_user_id, keep_history: T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/feed.rb#87
  def update_activities(activities); end

  # source://stream-ruby//lib/stream/feed.rb#83
  def update_activity(activity); end

  # source://stream-ruby//lib/stream/feed.rb#93
  def update_activity_to_targets(foreign_id, time, new_targets: T.unsafe(nil), added_targets: T.unsafe(nil), removed_targets: T.unsafe(nil)); end

  # Returns the value of attribute user_id.
  #
  # source://stream-ruby//lib/stream/feed.rb#8
  def user_id; end

  # source://stream-ruby//lib/stream/feed.rb#27
  def valid_feed_slug(feed_slug); end

  # source://stream-ruby//lib/stream/feed.rb#31
  def valid_user_id(user_id); end

  private

  # source://stream-ruby//lib/stream/feed.rb#155
  def create_jwt_token(resource, action, feed_id = T.unsafe(nil), user_id = T.unsafe(nil)); end
end

# source://stream-ruby//lib/stream/personalization.rb#4
class Stream::PersonalizationClient < ::Stream::Client
  # source://stream-ruby//lib/stream/personalization.rb#17
  def delete(resource, params = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/personalization.rb#9
  def get(resource, params = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/personalization.rb#13
  def post(resource, params = T.unsafe(nil), data = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/personalization.rb#5
  def url_generator; end

  private

  # source://stream-ruby//lib/stream/personalization.rb#23
  def make_personalization_request(method, resource, params, data); end
end

# source://stream-ruby//lib/stream/url.rb#50
class Stream::PersonalizationURLGenerator < ::Stream::URLGenerator
  # @return [PersonalizationURLGenerator] a new instance of PersonalizationURLGenerator
  #
  # source://stream-ruby//lib/stream/url.rb#51
  def initialize(options); end
end

# source://stream-ruby//lib/stream/client.rb#199
class Stream::RaiseHttpException < ::Faraday::Middleware
  # @return [RaiseHttpException] a new instance of RaiseHttpException
  #
  # source://stream-ruby//lib/stream/client.rb#217
  def initialize(app); end

  # source://stream-ruby//lib/stream/client.rb#200
  def call(env); end

  private

  # source://stream-ruby//lib/stream/client.rb#224
  def _build_error_message(response); end

  # source://stream-ruby//lib/stream/client.rb#235
  def error_message(response, body = T.unsafe(nil)); end
end

# source://stream-ruby//lib/stream/reactions.rb#2
class Stream::ReactionsClient < ::Stream::Client
  # source://stream-ruby//lib/stream/reactions.rb#3
  def add(kind, activity_id, user_id, data: T.unsafe(nil), target_feeds: T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/reactions.rb#33
  def add_child(kind, parent_id, user_id, data: T.unsafe(nil), target_feeds: T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/reactions.rb#67
  def create_reference(id); end

  # source://stream-ruby//lib/stream/reactions.rb#28
  def delete(reaction_id); end

  # source://stream-ruby//lib/stream/reactions.rb#44
  def filter(params = T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/reactions.rb#14
  def get(reaction_id); end

  # source://stream-ruby//lib/stream/reactions.rb#19
  def update(reaction_id, data: T.unsafe(nil), target_feeds: T.unsafe(nil)); end

  private

  # source://stream-ruby//lib/stream/reactions.rb#75
  def make_reaction_request(method, params, data, endpoint: T.unsafe(nil)); end
end

# source://stream-ruby//lib/stream/client.rb#8
Stream::STREAM_URL_COM_RE = T.let(T.unsafe(nil), Regexp)

# source://stream-ruby//lib/stream/client.rb#9
Stream::STREAM_URL_IO_RE = T.let(T.unsafe(nil), Regexp)

# source://stream-ruby//lib/stream/signer.rb#5
class Stream::Signer
  # @return [Signer] a new instance of Signer
  #
  # source://stream-ruby//lib/stream/signer.rb#8
  def initialize(key); end

  class << self
    # source://stream-ruby//lib/stream/signer.rb#17
    def create_jwt_token(resource, action, api_secret, feed_id = T.unsafe(nil), user_id = T.unsafe(nil)); end

    # source://stream-ruby//lib/stream/signer.rb#12
    def create_user_token(user_id, payload = T.unsafe(nil), api_secret); end
  end
end

# source://stream-ruby//lib/stream/errors.rb#4
class Stream::StreamApiResponseException < ::Stream::Error; end

# source://stream-ruby//lib/stream/client.rb#160
class Stream::StreamHTTPClient
  # @return [StreamHTTPClient] a new instance of StreamHTTPClient
  #
  # source://stream-ruby//lib/stream/client.rb#167
  def initialize(url_generator); end

  # Returns the value of attribute base_path.
  #
  # source://stream-ruby//lib/stream/client.rb#165
  def base_path; end

  # Returns the value of attribute conn.
  #
  # source://stream-ruby//lib/stream/client.rb#163
  def conn; end

  # source://stream-ruby//lib/stream/client.rb#179
  def make_http_request(method, relative_url, params = T.unsafe(nil), data = T.unsafe(nil), headers = T.unsafe(nil)); end

  # Returns the value of attribute options.
  #
  # source://stream-ruby//lib/stream/client.rb#164
  def options; end
end

# source://stream-ruby//lib/stream/errors.rb#6
class Stream::StreamInputData < ::Stream::Error; end

# source://stream-ruby//lib/stream/url.rb#2
class Stream::URLGenerator
  # Returns the value of attribute base_path.
  #
  # source://stream-ruby//lib/stream/url.rb#4
  def base_path; end

  # Returns the value of attribute options.
  #
  # source://stream-ruby//lib/stream/url.rb#3
  def options; end

  # Returns the value of attribute url.
  #
  # source://stream-ruby//lib/stream/url.rb#5
  def url; end
end

# source://stream-ruby//lib/stream/users.rb#2
class Stream::UsersClient < ::Stream::Client
  # source://stream-ruby//lib/stream/users.rb#3
  def add(user_id, data: T.unsafe(nil), get_or_create: T.unsafe(nil)); end

  # source://stream-ruby//lib/stream/users.rb#32
  def create_reference(id); end

  # source://stream-ruby//lib/stream/users.rb#27
  def delete(user_id); end

  # source://stream-ruby//lib/stream/users.rb#14
  def get(user_id); end

  # source://stream-ruby//lib/stream/users.rb#19
  def update(user_id, data: T.unsafe(nil)); end

  private

  # source://stream-ruby//lib/stream/users.rb#40
  def make_user_request(method, params, data, endpoint: T.unsafe(nil)); end
end

# source://stream-ruby//lib/stream/version.rb#2
Stream::VERSION = T.let(T.unsafe(nil), String)