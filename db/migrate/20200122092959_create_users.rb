# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.timestamps
    end

    add_index :users, :name, unique: true

    create_table :cards do |t|
      t.string :title, null: false
      t.timestamps
    end

    create_table :games do |t|
      t.boolean :started, default: false
      t.boolean :finished, default: false
      t.timestamps
    end

    create_table :players do |t|
      t.integer :game_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

    create_table :play_cards do |t|
      t.integer :game_id, null: false
      t.integer :player_id
      t.integer :card_id, null: false
      t.column "status", "ENUM ('initialized', 'drawn', 'thrown') DEFAULT 'initialized'"
      t.timestamps
    end

    create_table :play_logs do |t|
      t.integer :game_id, null: false
      t.integer :player_id, null: false
      t.integer :phase, default: 0
      t.string :hand_cards, default: ""
      t.string :thrown_cards, default: ""
      t.timestamps
    end
  end
end
