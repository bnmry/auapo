class Event < ActiveRecord::Base
  file_column :picture, :magick => { 
        :versions => { "thumb" => "50x50", "medium" => "200x200" }
      }
  belongs_to :code
  belongs_to :user
  has_many   :hours
  has_many   :reminders
  belongs_to :category
  validates_presence_of :title
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :description
  validates_length_of :description, :minimum => 20, :message => "should be a little longer, beef it up."
  validates_presence_of :location
  validates_length_of :location, :minimum => 20, :message => "should be a little longer. LA Quad isn't enough."
  validates_presence_of :length_in_hours
  validates_presence_of :category
  validates_presence_of :car_needed
  validates_presence_of :auto_needed
  validates_presence_of :attendee_limit
end
