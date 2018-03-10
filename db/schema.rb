# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20180310203754) do

  create_table "event_partnerships", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "event_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "event_translations", :force => true do |t|
    t.integer  "event_id"
    t.string   "locale",      :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.text     "description"
    t.text     "definition"
  end

  add_index "event_translations", ["event_id"], :name => "index_event_translations_on_event_id"
  add_index "event_translations", ["locale"], :name => "index_event_translations_on_locale"

  create_table "events", :force => true do |t|
    t.integer  "project_id"
    t.string   "address"
    t.string   "url"
    t.date     "date_begun"
    t.date     "date_ended"
    t.string   "zone"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "time"
    t.string   "email"
    t.string   "tel_1"
    t.string   "tel_2"
    t.string   "facebook_event_url"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "organization_id"
    t.string   "event_type"
    t.string   "event_category"
    t.string   "slug"
  end

  add_index "events", ["slug"], :name => "index_events_on_slug", :unique => true

  create_table "external_organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "url"
  end

  create_table "external_partnerships", :force => true do |t|
    t.integer  "external_organization_id"
    t.integer  "organization_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "external_project_partnerships", :force => true do |t|
    t.integer  "external_organization_id"
    t.integer  "project_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "highlights", :force => true do |t|
    t.integer  "weight"
    t.integer  "highlightable_id"
    t.string   "highlightable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "order"
    t.integer  "imageble_id"
    t.string   "imageble_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "url"
    t.string   "email",                                :default => "",    :null => false
    t.string   "telephone"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "keywords"
    t.string   "definition"
    t.text     "description"
    t.string   "twitter_name"
    t.string   "facebook_url"
    t.string   "linkedin_url"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                                :default => false
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "slug"
  end

  add_index "organizations", ["email"], :name => "index_organizations_on_email", :unique => true
  add_index "organizations", ["invitation_token"], :name => "index_organizations_on_invitation_token"
  add_index "organizations", ["invited_by_id"], :name => "index_organizations_on_invited_by_id"
  add_index "organizations", ["reset_password_token"], :name => "index_organizations_on_reset_password_token", :unique => true
  add_index "organizations", ["slug"], :name => "index_organizations_on_slug", :unique => true

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.text     "text"
  end

  add_index "page_translations", ["locale"], :name => "index_page_translations_on_locale"
  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"

  create_table "pages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  create_table "partnerships", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "project_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "post_translations", :force => true do |t|
    t.integer  "post_id"
    t.string   "locale",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.text     "summary"
    t.text     "body"
  end

  add_index "post_translations", ["locale"], :name => "index_post_translations_on_locale"
  add_index "post_translations", ["post_id"], :name => "index_post_translations_on_post_id"

  create_table "posts", :force => true do |t|
    t.date     "date_published"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
  end

  add_index "posts", ["slug"], :name => "index_posts_on_slug", :unique => true

  create_table "project_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_translations", :force => true do |t|
    t.integer  "project_id"
    t.string   "locale",      :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.text     "definition"
    t.text     "description"
  end

  add_index "project_translations", ["locale"], :name => "index_project_translations_on_locale"
  add_index "project_translations", ["project_id"], :name => "index_project_translations_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "address"
    t.string   "url"
    t.date     "date_begun"
    t.date     "date_ended"
    t.boolean  "active"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "invisible",           :default => false, :null => false
    t.integer  "organization_id"
    t.integer  "zone"
    t.integer  "project_category_id"
    t.string   "slug"
  end

  add_index "projects", ["slug"], :name => "index_projects_on_slug", :unique => true

  create_table "section_translations", :force => true do |t|
    t.integer  "section_id"
    t.string   "locale",      :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "title"
    t.text     "description"
  end

  add_index "section_translations", ["locale"], :name => "index_section_translations_on_locale"
  add_index "section_translations", ["section_id"], :name => "index_section_translations_on_section_id"

  create_table "sections", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "organization_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workshop_partnerships", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "workshop_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "workshops", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "url"
    t.date     "date"
    t.boolean  "active"
    t.boolean  "invisible"
    t.integer  "zone"
    t.text     "definition"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "pdf_download_file_name"
    t.string   "pdf_download_content_type"
    t.integer  "pdf_download_file_size"
    t.datetime "pdf_download_updated_at"
    t.date     "date_begun"
    t.date     "date_ended"
    t.string   "slug"
  end

  add_index "workshops", ["slug"], :name => "index_workshops_on_slug", :unique => true

end
