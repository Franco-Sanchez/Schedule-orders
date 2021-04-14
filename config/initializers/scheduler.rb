require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '3m' do
  Order.pending_orders
end
