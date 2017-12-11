actioncable_methods =
  connected: ->
    console.log 'connected to ChatChannel'

  disconnected: ->

  received: (data) ->
    console.log "Receive message #{data} from ChatChannel"
    App.vue.receiveMessage data

  send_message: (name, message) ->
    console.log "Send message #{message} to ChatChannel"
    @perform 'send_message', { message: message, name: name }


App.chat = App.cable.subscriptions.create { channel: "GossipChannel" }, actioncable_methods

App.vue = new Vue(
  el: '#gossip'
  data:
    name: 'anonymous'
    message: null
    messages: []
  methods:
    sendMessage: ->
      App.chat.send_message @name, @message
      @message = null
      return
    receiveMessage: (data) ->
      @messages.push {message: data.message, name: data.name}
      return
)
