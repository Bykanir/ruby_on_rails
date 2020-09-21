# frozen_string_literal: true

require_relative 'app'

app = App.new

['Moscow', 'Saint Petersburg', 'Volgodonsk'].each do |name|
  app.stations << Station.new(name)
end

3.times { app.routes << Route.new(app.stations.sample, app.stations.sample) }

%w[Pas-t1 Pas-t2 Pas-t1].each do |number|
  app.trains << TrainPassenger.new(number)
end

%w[Car-t1 Car-t2 Car-t3].each do |number|
  app.trains << TrainCargo.new(number)
end

['Passenger carriage #11', 'Passenger carriage #22', 'Passenger carriage #33'].each do |number|
  app.carriages << CarriagePassenger.new(number, 20)
end

['Cargo carriage #111', 'Cargo carriage #222', 'Cargo carriage #333'].each do |number|
  app.carriages << CarriageCargo.new(number, 1000)
end

app.trains.each { |train| train.accept_route(app.routes.sample) }

app.trains.each { |train| train.add_carriage(app.carriages.sample) }

app.start
