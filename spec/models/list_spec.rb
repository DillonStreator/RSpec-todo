require 'rails_helper'

RSpec.describe List, type: :model do
  describe "#complete_all_tasks!" do
    it "should change the complete status of all tasks to true" do
      list = List.create(name: "Chores")
      task1 = Task.create(complete: false, list_id: list.id)
      task2 = Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe "#snooze_all_tasks!" do
    it "should add 1 hour to the deadline of all tasks" do
      this_deadline = Time.now
      list = List.create(name: "Chores")
      task1 = Task.create(deadline: this_deadline, list_id: list.id)
      task2 = Task.create(deadline: this_deadline, list_id: list.id)
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(this_deadline + 1.hour)
      end
    end
  end

  describe "#total_duration" do
    it "should return the sum of the durations of each task" do
      list = List.create(name: "Chores")
      task1 = Task.create(duration: 10, list_id: list.id)
      task2 = Task.create(duration: 10, list_id: list.id)
      expect(list.total_duration).to eq(20)
    end
  end

  describe "#incomplete_tasks" do
    it "should return an array of tasks where complete is true" do
      list = List.create(name: "Chores")
      task1 = Task.create(complete: false, list_id: list.id)
      task2 = Task.create(complete: false, list_id: list.id)
      task3 = Task.create(complete: true, list_id: list.id)
      expect(list.incomplete_tasks).to eq(list.tasks.select{|task| task.complete == false})
    end
  end

  describe "#favorite_tasks" do
    it "should return an array of tasks where favorite is true" do
      list = List.create(name: "Chores")
      task1 = Task.create(favorite: false, list_id: list.id)
      task2 = Task.create(favorite: true, list_id: list.id)
      task3 = Task.create(favorite: true, list_id: list.id)
      expect(list.favorite_tasks).to eq(list.tasks.select{|task| task.favorite == true})
    end
  end

end
