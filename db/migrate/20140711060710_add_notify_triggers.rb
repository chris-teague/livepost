class AddNotifyTriggers < ActiveRecord::Migration
  def change

    # Add notify_trigger() function to post appropriate messages to notify when triggered
    execute "
      CREATE OR REPLACE FUNCTION notify_trigger() RETURNS trigger AS $$
      DECLARE
      BEGIN
       -- TG_TABLE_NAME is the name of the table who's trigger called this function
       -- TG_OP is the operation that triggered this function: INSERT, UPDATE or DELETE.

        IF TG_OP = 'DELETE' THEN
          execute 'NOTIFY ' || TG_TABLE_NAME || '_' || TG_OP || ', ''' || row_to_json(OLD) || '''';
          return OLD;
        ELSE
          execute 'NOTIFY ' || TG_TABLE_NAME || '_' || TG_OP || ', ''' || row_to_json(NEW) || '''';
          return NEW;
        END IF;
      END;

      $$ LANGUAGE plpgsql;
    "

  end
end
