class FixExpiresAtFunction < ActiveRecord::Migration
  def up
    execute "
    DROP FUNCTION expires_at(projects);
    CREATE OR REPLACE FUNCTION expires_at(projects) RETURNS timestamptz AS $$
     SELECT (((($1.online_date + ($1.online_days || ' days')::interval)::TIMESTAMP WITH TIME ZONE AT TIME ZONE coalesce((SELECT value FROM configurations WHERE name = 'timezone'), 'America/Bogota'))::DATE::TEXT  || ' 23:59:59')::TIMESTAMP AT TIME ZONE coalesce((SELECT value FROM configurations WHERE name = 'timezone'), 'America/Bogota'))::TIMESTAMP::TIMESTAMP WITH TIME ZONE
    $$ LANGUAGE SQL;
    "
  end

  def down
    execute "
    CREATE OR REPLACE FUNCTION expires_at(projects) RETURNS timestamptz AS $$
     SELECT (($1.online_date + ($1.online_days || ' days')::interval)::date::text || ' 23:59:59')::timestamp AT TIME ZONE coalesce((SELECT value FROM configurations WHERE name = 'timezone'), 'America/Bogota')
    $$ LANGUAGE SQL;
    "
  end
end
