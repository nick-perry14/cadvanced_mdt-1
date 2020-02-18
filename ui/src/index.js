import Vue from 'vue';

import vueDebounce from 'vue-debounce';

import MDT from './views/MDT.vue';

import router from './router';
import store from './store';

Vue.use(vueDebounce);

new Vue({
    router,
    store,
    el: '#app',
    render: h => h(MDT)
});
