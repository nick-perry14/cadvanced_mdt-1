import Vue from 'vue';

import vueDebounce from 'vue-debounce';
import vSelect from 'vue-select';
import 'vue-select/dist/vue-select.css';

import MDT from './views/MDT.vue';
import Terminal from './views/Terminal.vue';

import router from './router';
import store from './store';

Vue.use(vueDebounce);
Vue.component('v-select', vSelect);

new Vue({
    router,
    store,
    el: '#app',
    // This nonsensical looking line is using the createElement function that is passed
    // to the render function to create a div containing two children, the MDT
    // and the Terminal
    render: cE => cE('div', [cE(Terminal), cE(MDT)])
});
