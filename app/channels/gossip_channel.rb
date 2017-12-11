class GossipChannel < ApplicationCable::Channel
  CHANNEL_NAME = 'gossip_channel'

  def subscribed
    stream_from CHANNEL_NAME
  end

  # a simple echo implementation
  def send_message(data)
    ActionCable.server.broadcast CHANNEL_NAME, { message: data['message'], name: data['name']}
  end
end