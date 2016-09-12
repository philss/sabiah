import 'phoenix_html';
import Vue from 'vue/dist/vue';

new Vue({
  el: '#timeline-app',
  data: {
    newTweet: '',
    tweets: []
  },
  methods: {
    postTweet: function() {
      this.tweets.unshift(this.newTweet);
      this.newTweet = '';
    }
  }
});
