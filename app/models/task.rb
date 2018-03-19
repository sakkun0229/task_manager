class Task < ApplicationRecord
  validates :content, presence: true
  #enum status: { NOT:0, WIP:1, DONE:2 }
  #enum priority: { Low:0, Mid:1, High:2 }
end
