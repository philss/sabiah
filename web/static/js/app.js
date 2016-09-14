import 'phoenix_html';
import Vue from 'vue/dist/vue';
import socket from './socket';

const userId = window.userId;
// Now that you are connected, you can join channels with a topic:
let channel = socket.channel(`timeline:${userId}`, {});

channel.join()
  .receive('ok', resp => { console.log('Joined successfully', resp) })
  .receive('error', resp => { console.log('Unable to join', resp) });

let app = new Vue({
  el: '#timeline-app',
  data: {
    newTweet: '',
    tweets: []
  },
  methods: {
    postTweet: function() {
      channel.push('new_tweet', { content: this.newTweet });
      this.newTweet = '';
    }
  }
});

channel.on('new_tweet', (payload) => {
  app.tweets.unshift(payload);
});
