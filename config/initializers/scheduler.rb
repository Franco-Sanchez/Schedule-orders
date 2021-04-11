require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '1m' do
  Order.pending_orders
end
