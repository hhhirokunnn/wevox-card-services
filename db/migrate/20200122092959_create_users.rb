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
      t.string :title
      t.timestamps
    end

    create_table :games do |t|
      t.boolean :started
      t.boolean :finished
      t.timestamps
    end

    create_table :players do |t|
      t.integer :game_id
      t.integer :user_id
      t.timestamps
    end

    create_table :play_cards do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :card_id
      t.column 'status', "ENUM ('initialized', 'drawn', 'thrown') DEFAULT 'initialized'"
      t.timestamps
    end

    create_table :play_logs do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :phase, default: 0
      t.string :hand_cards, default: ''
      t.string :thrown_cards, default: ''
      t.timestamps
    end
  end
end
