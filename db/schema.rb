# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100217021117) do

  create_table "announcements", :force => true do |t|
    t.string   "prefix"
    t.string   "title",                            :null => false
    t.text     "details"
    t.string   "url"
    t.string   "type",       :default => "rotate"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audios", :force => true do |t|
    t.string   "audioable_type"
    t.integer  "audioable_id"
    t.integer  "user_id"
    t.string   "url"
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "audios", ["audioable_type", "audioable_id"], :name => "index_audios_on_audioable_type_and_audioable_id"
  add_index "audios", ["user_id"], :name => "index_audios_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentid",        :default => 0
    t.integer  "commentable_id",   :default => 0
    t.integer  "contentid",        :default => 0
    t.text     "comments"
    t.string   "postedByName",     :default => ""
    t.integer  "postedById",       :default => 0
    t.integer  "user_id",          :default => 0
    t.datetime "created_at"
    t.boolean  "is_blocked",       :default => false
    t.integer  "videoid",          :default => 0
    t.datetime "updated_at"
    t.string   "commentable_type"
    t.integer  "flags_count",      :default => 0
    t.integer  "likes_count",      :default => 0
    t.boolean  "is_featured",      :default => false
    t.datetime "featured_at"
  end

  add_index "comments", ["commentable_type", "commentable_id"], :name => "index_comments_on_commentable_type_and_commentable_id"

  create_table "content_images", :force => true do |t|
    t.string   "url",        :default => ""
    t.integer  "content_id", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_images", ["content_id"], :name => "index_content_images_on_content_id"
  add_index "content_images", ["content_id"], :name => "siteContentId"

  create_table "contents", :force => true do |t|
    t.integer  "contentid",                         :default => 0
    t.string   "title",                             :default => ""
    t.text     "caption"
    t.string   "source",             :limit => 150, :default => ""
    t.string   "url",                               :default => ""
    t.string   "permalink",                         :default => ""
    t.integer  "postedById",                        :default => 0
    t.string   "postedByName",                      :default => ""
    t.datetime "created_at"
    t.integer  "score",                             :default => 0
    t.integer  "numComments",                       :default => 0
    t.boolean  "isFeatured",                        :default => false
    t.integer  "user_id",                           :default => 0
    t.integer  "imageid",                           :default => 0
    t.integer  "videoIntroId",                      :default => 0
    t.boolean  "is_blocked",                        :default => false
    t.integer  "videoid",                           :default => 0
    t.integer  "widgetid",                          :default => 0
    t.boolean  "isBlogEntry",                       :default => false
    t.boolean  "isFeatureCandidate",                :default => false
    t.integer  "comments_count",                    :default => 0
    t.datetime "updated_at"
    t.integer  "article_id"
    t.string   "cached_slug"
    t.integer  "flags_count",                       :default => 0
  end

  add_index "contents", ["contentid"], :name => "contentid"
  add_index "contents", ["title"], :name => "relatedItems"
  add_index "contents", ["title"], :name => "relatedText"

  create_table "events", :force => true do |t|
    t.integer  "eid"
    t.string   "name"
    t.string   "tagline"
    t.string   "pic"
    t.string   "pic_big"
    t.string   "pic_small"
    t.string   "host"
    t.string   "location"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.text     "description"
    t.string   "event_type"
    t.string   "event_subtype"
    t.string   "privacy_type"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "update_time"
    t.boolean  "isApproved"
    t.integer  "nid"
    t.integer  "creator"
    t.integer  "user_id"
    t.integer  "likes_count"
    t.integer  "comments_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_featured",    :default => false
    t.datetime "featured_at"
    t.boolean  "is_blocked",     :default => false
    t.integer  "flags_count",    :default => 0
  end

  create_table "fbSessions", :force => true do |t|
    t.integer  "userid",                     :limit => 8, :default => 0
    t.integer  "fbId",                       :limit => 8, :default => 0
    t.string   "fb_sig_session_key",                      :default => ""
    t.datetime "fb_sig_time"
    t.datetime "fb_sig_expires"
    t.datetime "fb_sig_profile_update_time"
  end

  create_table "featured_items", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "featurable_id"
    t.string   "featurable_type"
    t.string   "featured_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "featured_items", ["featurable_type", "featurable_id"], :name => "index_featured_items_on_featurable_type_and_featurable_id"
  add_index "featured_items", ["featured_type"], :name => "index_featured_items_on_featured_type"
  add_index "featured_items", ["name"], :name => "index_featured_items_on_name"
  add_index "featured_items", ["parent_id"], :name => "index_featured_items_on_parent_id"

  create_table "feeds", :force => true do |t|
    t.integer  "wireid",                   :default => 0
    t.string   "title",                    :default => ""
    t.string   "url",                      :default => ""
    t.string   "rss",                      :default => ""
    t.datetime "lastFetch",                                       :null => false
    t.string   "feedType",                 :default => "wire"
    t.string   "specialType",              :default => "default"
    t.string   "loadOptions",              :default => "none"
    t.integer  "user_id",     :limit => 8, :default => 0
    t.string   "tagList",                  :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", :force => true do |t|
    t.string   "flag_type"
    t.integer  "user_id"
    t.string   "flagable_type"
    t.integer  "flagable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flags", ["flagable_type", "flagable_id"], :name => "index_flags_on_flagable_type_and_flagable_id"

  create_table "idea_boards", :force => true do |t|
    t.string   "name"
    t.string   "section"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", :force => true do |t|
    t.integer  "user_id",        :limit => 8, :default => 0
    t.string   "title",                       :default => ""
    t.text     "details"
    t.integer  "old_tag_id",                  :default => 0
    t.integer  "old_video_id",                :default => 0
    t.integer  "likes_count",                 :default => 0
    t.integer  "comments_count",              :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "idea_board_id"
    t.boolean  "is_featured",                 :default => false
    t.datetime "featured_at"
    t.integer  "flags_count",                 :default => 0
    t.boolean  "is_blocked",                  :default => false
  end

  add_index "ideas", ["title"], :name => "related"

  create_table "images", :force => true do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "remote_image_url"
    t.boolean  "is_blocked",         :default => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["imageable_type", "imageable_id"], :name => "index_images_on_imageable_type_and_imageable_id"
  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.string   "email"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newswires", :force => true do |t|
    t.string   "title",                     :default => ""
    t.text     "caption"
    t.string   "source",     :limit => 150, :default => ""
    t.string   "url",                       :default => ""
    t.datetime "created_at"
    t.integer  "wireid",                    :default => 0
    t.string   "feedType",                  :default => "wire"
    t.string   "mediaUrl",                  :default => ""
    t.string   "imageUrl",                  :default => ""
    t.text     "embed"
    t.integer  "feed_id",                   :default => 0
    t.datetime "updated_at"
  end

  add_index "newswires", ["feed_id"], :name => "feedid"

  create_table "resource_sections", :force => true do |t|
    t.string   "name"
    t.string   "section"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.string   "title",                                  :null => false
    t.text     "details"
    t.string   "url"
    t.string   "mapUrl"
    t.string   "twitterName"
    t.integer  "likes_count"
    t.integer  "comments_count"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flags_count",         :default => 0
    t.integer  "resource_section_id"
    t.boolean  "is_blocked",          :default => false
    t.boolean  "is_featured",         :default => false
    t.datetime "featured_at"
    t.boolean  "is_sponsored",        :default => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id",               :limit => 8,                    :null => false
    t.integer  "facebook_user_id",      :limit => 8, :default => 0
    t.boolean  "isAppAuthorized",                    :default => false
    t.datetime "born_at"
    t.datetime "created_at",                                            :null => false
    t.text     "bio"
    t.integer  "referred_by_user_id",   :limit => 8, :default => 0
    t.boolean  "comment_notifications",              :default => false
  end

  add_index "user_profiles", ["user_id"], :name => "index_user_infos_on_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.integer  "ncu_id",                     :limit => 8,  :default => 0
    t.string   "name",                                     :default => ""
    t.string   "email",                                    :default => ""
    t.boolean  "is_admin",                                 :default => false
    t.boolean  "is_blocked",                               :default => false
    t.integer  "vote_power",                               :default => 1
    t.string   "remoteStatus",                             :default => "noverify"
    t.boolean  "is_member",                                :default => false
    t.boolean  "is_moderator",                             :default => false
    t.boolean  "is_sponsor",                               :default => false
    t.boolean  "is_email_verified",                        :default => false
    t.boolean  "is_researcher",                            :default => false
    t.boolean  "accept_rules",                             :default => false
    t.boolean  "opt_in_study",                             :default => true
    t.boolean  "opt_in_email",                             :default => true
    t.boolean  "opt_in_profile",                           :default => true
    t.boolean  "opt_in_feed",                              :default => true
    t.boolean  "opt_in_sms",                               :default => true
    t.datetime "dateRegistered"
    t.string   "eligibility",                              :default => "team"
    t.integer  "cachedPointTotal",                         :default => 0
    t.integer  "cachedPointsEarned",                       :default => 0
    t.integer  "cachedPointsEarnedThisWeek",               :default => 0
    t.integer  "cachedPointsEarnedLastWeek",               :default => 0
    t.integer  "cachedStoriesPosted",                      :default => 0
    t.integer  "cachedCommentsPosted",                     :default => 0
    t.string   "userLevel",                  :limit => 25, :default => "reader"
    t.string   "login",                      :limit => 40
    t.string   "crypted_password",           :limit => 40
    t.string   "salt",                       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",             :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "fb_user_id",                 :limit => 8
    t.string   "email_hash"
    t.string   "cached_slug"
    t.integer  "karma_score",                              :default => 0
    t.datetime "last_active"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "videoable_type"
    t.integer  "videoable_id"
    t.integer  "user_id"
    t.string   "remote_video_url"
    t.boolean  "is_blocked",        :default => false
    t.text     "description"
    t.text     "embed_code"
    t.string   "embed_src"
    t.string   "remote_video_type"
    t.string   "remote_video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["user_id"], :name => "index_videos_on_user_id"
  add_index "videos", ["videoable_type", "videoable_id"], :name => "index_videos_on_videoable_type_and_videoable_id"

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "fk_voteables"
  add_index "votes", ["voter_id", "voter_type"], :name => "fk_voters"

  create_table "widget_pages", :force => true do |t|
    t.integer  "widget_id"
    t.integer  "parent_id"
    t.string   "widget_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "widget_pages", ["name"], :name => "index_widget_pages_on_name"
  add_index "widget_pages", ["parent_id"], :name => "index_widget_pages_on_parent_id"
  add_index "widget_pages", ["widget_id"], :name => "index_widget_pages_on_widget_id"
  add_index "widget_pages", ["widget_type"], :name => "index_widget_pages_on_widget_type"

  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.string   "load_functions"
    t.string   "locals"
    t.string   "partial"
    t.string   "content_type"
    t.text     "metadata"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "widgets", ["name"], :name => "index_widgets_on_name"

end
