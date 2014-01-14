action :run do
  template "CreateAvailabilityGroup.sql" do
    source "CreateAvailabilityGroup.sql"
  end
end