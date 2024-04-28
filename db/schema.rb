# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_106_135_311) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_categories_on_name'
  end

  create_table 'families', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_families_on_name'
  end

  create_table 'ingredients', force: :cascade do |t|
    t.bigint 'category_id'
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[category_id name], name: 'index_ingredients_on_category_id_and_name'
    t.index ['category_id'], name: 'index_ingredients_on_category_id'
    t.index ['name'], name: 'index_ingredients_on_name'
  end

  create_table 'recipe_ingredients', force: :cascade do |t|
    t.bigint 'recipe_id'
    t.bigint 'ingredient_id'
    t.float 'amount', null: false
    t.float 'bakers_percentage'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['ingredient_id'], name: 'index_recipe_ingredients_on_ingredient_id'
    t.index %w[recipe_id ingredient_id], name: 'index_recipe_ingredients_on_recipe_id_and_ingredient_id'
    t.index ['recipe_id'], name: 'index_recipe_ingredients_on_recipe_id'
  end

  create_table 'recipe_tags', force: :cascade do |t|
    t.bigint 'tag_id', null: false
    t.bigint 'recipe_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[recipe_id tag_id], name: 'idx_recipes_tags_on_recipe_and_tag', unique: true
    t.index ['recipe_id'], name: 'index_recipe_tags_on_recipe_id'
    t.index ['tag_id'], name: 'index_recipe_tags_on_tag_id'
  end

  create_table 'recipes', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'family_id'
    t.integer 'unit', default: 0, null: false
    t.string 'name', null: false
    t.integer 'number_of_portions', null: false
    t.float 'weight_per_portion', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['family_id'], name: 'index_recipes_on_family_id'
    t.index ['name'], name: 'index_recipes_on_name'
    t.index ['unit'], name: 'index_recipes_on_unit'
    t.index %w[user_id name family_id], name: 'index_recipes_on_user_id_and_name_and_family_id', unique: true
    t.index %w[user_id name], name: 'index_recipes_on_user_id_and_name', unique: true
    t.index ['user_id'], name: 'index_recipes_on_user_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_tags_on_name'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'phone_number'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'ingredients', 'categories'
  add_foreign_key 'recipe_ingredients', 'ingredients'
  add_foreign_key 'recipe_ingredients', 'recipes'
  add_foreign_key 'recipe_tags', 'recipes'
  add_foreign_key 'recipe_tags', 'tags'
  add_foreign_key 'recipes', 'families'
  add_foreign_key 'recipes', 'users'
end
