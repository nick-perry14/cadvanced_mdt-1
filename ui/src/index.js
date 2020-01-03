import Vue from 'vue';
import MDT from './views/MDT.vue';

import router from './router';
import store from './store';

new Vue({
    router,
    store,
    el: '#app',
    render: h => h(MDT)
});
