class AddStoryTriggers < ActiveRecord::Migration
  def change
    # Table level trigger for calling notify_trigger on 
    execute "
      CREATE TRIGGER story_changes
      AFTER INSERT OR UPDATE OR DELETE ON stories 
      FOR EACH ROW EXECUTE PROCEDURE notify_trigger();
    "
  end
end
